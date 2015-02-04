# Portfolio Analysis in R A 60/40 US Stock/Bond Portfolio
# http://www.capitalspectator.com

# load packages
library("quantmod")
library("tseries")
library("PerformanceAnalytics")

# download prices
spy <- get.hist.quote(instrument = "spy", start = "2003-12-31", 
                      quote = "AdjClose", compression = "d")
agg <- get.hist.quote(instrument = "agg", start = "2003-12-31", 
                      quote = "AdjClose", compression = "d")

# choose asset weights
w <- c(0.6, 0.4)

# merge price histories into one dataset calculate 1-day % returns and label
# columns
portfolio.prices <- as.xts(merge(spy, agg))
portfolio.returns <- na.omit(ROC(portfolio.prices, 1, "discrete"))
colnames(portfolio.returns) <- c("spy", "agg")

# calculate portfolio total returns rebalanced portfolio
portfolio.rebal <- Return.portfolio(portfolio.returns, 
                                    rebalance_on = "years", weights = w, 
                                    wealth.index = TRUE, verbose = TRUE)

# buy and hold portfolio/no rebalancing
portfolio.bh <- Return.portfolio(portfolio.returns, 
                                 weights = w, wealth.index = TRUE, 
                                 verbose = TRUE)

# merge portfolio returns into one dataset label columns
portfolios.2 <- cbind(portfolio.rebal$returns, portfolio.bh$returns)
colnames(portfolios.2) <- c("rebalanced", "buy and hold")

chart.CumReturns(portfolios.2, wealth.index = TRUE, 
                 legend.loc = "bottomright", main = "Growth of $1 investment", 
                 ylab = "$")

# compare return/risk
table.AnnualizedReturns(portfolios.2)

# review biggest drawdowns
table.Drawdowns((portfolio.bh$returns))
table.Drawdowns((portfolio.rebal$returns))

# compare portfolio return distribution vs. normal distribution
qqnorm(portfolio.rebal$returns, main = "Rebalanced portfolio")
qqline(portfolio.rebal$returns, col = "red")

# compare rolling 1-year ruturns
chart.RollingPerformance(portfolios.2, width = 252, 
                         legend.loc = "bottomright", 
                         main = "Rolling 1yr % returns") 

# create rolling correlations for 1yr windows (252 trading days) 
#   vs. rebalanced portfolio
spy.port.corr <- na.omit(runCor(x = portfolio.returns$spy, 
                                y = portfolio.rebal$returns, 
                                n = 252))
agg.port.corr <- na.omit(runCor(x = portfolio.returns$agg, 
                                y = portfolio.rebal$returns, 
                                n = 252))

# combine and label correlation data
spy.agg.port.corr <- cbind(spy.port.corr, agg.port.corr)
colnames(spy.agg.port.corr) <- c("spy", "agg")

# create date file for plot
dates <- index(spy.agg.port.corr)

# plot correlation data
matplot(dates, spy.agg.port.corr, type = "l", xaxt = "n", 
        xlab = "", ylab = "", main = "Rolling 252-day correlations")
axis.Date(side = 1, dates, format = "%b-%d-%Y")
legend("bottomleft", c(colnames(spy.agg.port.corr)), fill = palette())

# create volatility data
spy.port.vol <- na.omit(runSD(x = portfolio.returns$spy, n = 252))
agg.port.vol <- na.omit(runSD(x = portfolio.returns$agg, n = 252))
port.vol <- na.omit(runSD(x = portfolio.rebal$returns, n = 252))

# combine and label volatility data
spy.agg.port.vol <- cbind(spy.port.vol, agg.port.vol, port.vol)
colnames(spy.agg.port.vol) <- c("spy", "agg", "portfolio")

# create dates file for plot
dates <-index(spy.agg.port.vol)

# plot correlation data
matplot(dates, spy.agg.port.vol, type = "l", xaxt = "n", 
        xlab = "", ylab = "", main="Rolling 252-day volatility (std dev)")
axis.Date(side = 1, dates, format = "%b-%d-%Y")
legend("topleft", c(colnames(spy.agg.port.vol)), fill = palette())


# review the weights for each asset
tail(portfolio.rebal$EOP.Weight)

# review the weighted return contribution for each asset
tail(portfolio.rebal$contribution)

# review portfolio returns, the sum of weighted returns for the assets
tail(portfolio.rebal$returns)

# verify portfolio returns by summing weighted returns for the assets
tail(as.xts(apply(portfolio.rebal$contribution, 1, sum)))
