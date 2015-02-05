# http://www.capitalspectator.com/out-of-sample-risk-strikes-again/
# Out-Of-Sample Risk Strikes Again

library("quantmod")
library("TTR")
library("zoo")
library("tseries")

# Download prices
fred.tickers <- c("DCOILWTICO", "WILL5000PR")
getSymbols(fred.tickers, src = "FRED")

# Generate monthly % returns
oil.m <- monthlyReturn(apply.monthly(na.omit(DCOILWTICO), mean))
stocks.m <- monthlyReturn(apply.monthly(na.omit(WILL5000PR), mean))

# Create lagged data for oil returns
oil.m.lag <- Lag(oil.m, 1)

# Combine current stock returns and lagged oil returns
oil.stocks.lag <- na.omit(merge(oil.m.lag, stocks.m))
colnames(oil.stocks.lag) <- c("oil", "stocks")

# Model with 1-mo Lag: 1986:2003
oil.stocks.lag.2003 <- oil.stocks.lag["1986-01-31::2003-12-31"]
model.withlag.2003 <- lm(oil.stocks.lag$stocks ~ oil.stocks.lag$oil)

plot(as.numeric(oil.stocks.lag.2003$oil), 
     as.numeric(oil.stocks.lag.2003$stocks), 
     main = "Linear Regression | Monthly % returns: 1986-2003",
     cex.main = .9, 
     xlab = "oil", 
     ylab = "stocks (subsequent month return)")
abline(lm(oil.stocks.lag.2003$stocks ~ oil.stocks.lag.2003$oil), col = "red")

# Model with 1-mo Lag: 2004:2014
oil.stocks.lag.2014 <- oil.stocks.lag["2004-01-30::2014-09-30"]
model.withlag.2014 <- lm(oil.stocks.lag.2014$stocks ~ oil.stocks.lag.2014$oil)

plot(as.numeric(oil.stocks.lag.2014$oil), 
     as.numeric(oil.stocks.lag.2014$stocks), 
     main = "Linear Regression | Monthly % returns: 2004-2014", 
     cex.main = .9, 
     xlab = "oil", 
     ylab = "stocks (subsequent month return)")
abline(lm(oil.stocks.lag.2014$stocks ~ oil.stocks.lag.2014$oil), col = "red")

