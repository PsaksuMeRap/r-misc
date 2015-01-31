# Portfolio Analysis in R A 60/40 US Stock/Bond Portfolio capitalspectator.com

# rebalancing analysis for 60/40 US stock/bond portfolio

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
