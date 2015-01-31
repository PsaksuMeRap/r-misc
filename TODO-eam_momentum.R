# http://www.capitalspectator.com/ A Momentum-Based Trading Signal With Strategic
# Value

# load packages
library("TTR")
library("zoo")
library("quantmod")

# download daily S&P 500 prices from Dec 31, 1990 forward
gspc <- getSymbols("^gspc", from = "1990-12-31", auto.assign = FALSE)

# error adjusted momentum function
eam <- function(x, y, z) {
  # x=ticker, y=lookback period for forecast, z=SMA period
  a <- na.omit(ROC(Cl(x), 1, "discrete"))
  # forecast based on 'y' trailing period returns
  b <- na.omit(SMA(a, y))
  # lag forecasts by 1 period
  c <- na.omit(Lag(b, k = 1))
  # combine lagged forecasts with actual returns into one file
  d <- na.omit(cbind(c, a))
  # actual daily return less forecast
  e <- as.xts(apply(d, 1, diff))
  # mean absolute error
  f <- to.daily(na.omit(rollapplyr(e, y, function(x) mean(abs(x)))), drop.time = TRUE, 
    OHLC = FALSE)
  # combine actual return with MAE into one file
  g <- cbind(a, f)
  # divide actual return by MAE
  h <- na.omit(a[, 1]/g[, 2])
  # generate 200-day moving average of adjusted return
  i <- na.omit(SMA(h, z))
  
  # lag adjusted return signal by one day for trading analysis
  j <- na.omit(Lag(ifelse(i > 0, 1, 0)))
}

eam.sig <- eam(gspc, 10, 200)

# function to generate raw EAM signal data
eam.ret <- function(x, y, z) {
  # x=ticker, y=lookback period for vol forecast, z=SMA period
  a <- eam(x, y, z)
  print("a")
  print(head(a))
  print(length(a))
  b <- na.omit(ROC(Cl(x), 1, "discrete"))
  print("b")
  print(head(b))
  print(length(b))
  c <- length(a) - 1
  print("c")
  print(head(c))
  print(length(c))
  d <- tail(b, c)
  print("d")
  print(head(d))
  print(length(d))
  e <- d * a
  print("e")
  print(head(e))
  print(length(e))
  f <- cumprod(c(100, 1 + e))
  print("f")
  print(head(f))
  print(length(f))
  g <- tail(b, c)
  print("g")
  print(head(g))
  print(length(g))
  h <- cumprod(c(100, 1 + g))
  print("h")
  print(head(h))
  print(length(h))
  i <- cbind(f, h)
  colnames(i) <- c("model", "asset")
  print("i")
  print(head(i))
  print(length(i))
  date.a <- c((first(tail((as.Date(index(x))), c)) - 1), (tail((as.Date(index(x))), 
    c)))
  print("date.a")
  print(head(date.a))
  print(length(date.a))
  j <- xts(i, date.a)
  print("j")
  print(head(j))
  print(length(j))
  return(j)
}

eam.model <- eam.ret(gspc, 10, 200)

eam.data <- function(x, y, z) {
  # x=ticker, y=lookback period for forecast, z=SMA period
  a <- na.omit(ROC(Cl(x), 1, "discrete"))
  b <- na.omit(SMA(a, y))  # forecast based on 'y' trailing period returns
  c <- na.omit(Lag(b, k = 1))  # lag forecasts by 1 period
  d <- na.omit(cbind(c, a))
  e <- as.xts(apply(d, 1, diff))
  f <- to.daily(na.omit(rollapplyr(e, y, function(x) mean(abs(x)))), drop.time = TRUE, 
    OHLC = FALSE)
  g <- cbind(a, f)
  h <- na.omit(a[, 1]/g[, 2])
  i <- na.omit(SMA(h, z))
  colnames(i) <- c("eam data")
  return(i)
}

eam.data.history <- eam.data(gspc, 10, 200) 
