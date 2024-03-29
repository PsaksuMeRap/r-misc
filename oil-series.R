# http://kukuruku.co/hub/r/oil-series-oil-prices-in-r
# Oil series in R

library("Quandl")

# Download prices
oil.ts <- Quandl("DOE/RBRTE", type="zoo", 
                 trim_start = "1987-11-10", trim_end = "2015-01-01")
oil.tsw <- Quandl("DOE/RBRTE", type="zoo",  
                  trim_start = "1987-11-10", trim_end = "2015-01-01", 
                  collapse = "weekly")
oil.tsm <- Quandl("DOE/RBRTE", type="ts", 
                  trim_start = "1987-11-10", trim_end = "2015-01-01", 
                  collapse = "monthly")

# LOWESS smoother
plot(oil.tsm, xlab = "Year", ylab = "Price, $", type = "l")
lines(lowess(oil.tsm), col = "red", lty = "dashed")

# Time series decomposition
plot(decompose(oil.tsm, type = "multiplicative"))

# Time series is non-stationary
library("tseries")
library("forecast")
adf.test(oil.tsm, alternative = "stationary")

# The first-order differences of the series are stationary
# This will allow to apply the ARIMA model
adf.test(diff(oil.tsm), alternative = c('stationary'))
ndiffs(oil.tsm)

# Box-Cox transformation allows to stabilize dispersion and 
#   transform the data to a more standard form
L <- BoxCox.lambda(ts(oil.ts, frequency = 260), method = "loglik")
Lw <- BoxCox.lambda(ts(oil.tsw, frequency = 52), method = "loglik")
Lm <- BoxCox.lambda(oil.tsm, method = "loglik")

# Fit NN for long-run
fit.nn <- nnetar(ts(oil.ts, frequency = 260), lambda = L, size = 3)
fcast.nn <- forecast(fit.nn, h = 520, lambda = L)
fit.nnw <- nnetar(ts(oil.tsw, frequency = 52), lambda = Lw, size = 3)
fcast.nnw <- forecast(fit.nnw, h = 104, lambda = Lw)
fit.nnm <- nnetar(oil.tsm, lambda = Lm, size = 3)
fcast.nnm <- forecast(fit.nnm, h = 24, lambda = Lm)
par(mfrow = c(3, 1))
plot(fcast.nn, include = 1040)
plot(fcast.nnw, include = 208)
plot(fcast.nnm, include = 48)

# Fit ARIMA, NN and ETS for short-run
short <- ts(oil.ts[index(oil.ts) > "2014-06-30" 
                   & index(oil.ts) < "2014-12-01"], 
            frequency=20)
short.test <- as.numeric(oil.ts[index(oil.ts) >= "2014-12-01", ])
h <- length(short.test)
fit.arima <- auto.arima(short, lambda = L)
fcast.arima <- forecast(fit.arima, h, lambda = L)
fit.nn <- nnetar(short, size = 7, lambda = L)
fcast.nn <- forecast(fit.nn, h, lambda = L)
fit.tbats <-tbats(short, lambda = L)
fcast.tbats <- forecast(fit.tbats, h, lambda = L)
par(mfrow = c(3, 1))
plot(fcast.arima, include = 3 * h)
plot(fcast.nn, include = 3 * h)
plot(fcast.tbats, include =  3 * h)

# Comparison with the real data in December
par(mfrow = c(1, 1))
plot(short.test, type = "l", col = "red", lwd = 5, 
     xlab = "Day", ylab = "Price, $", main = "December prices", 
     ylim = c(min(short.test, fcast.arima$mean, fcast.tbats$mean, 
                  fcast.nn$mean), 
              max(short.test, fcast.arima$mean, fcast.tbats$mean, 
                  fcast.nn$mean)))
lines(as.numeric(fcast.nn$mean), 
      col = "green", lwd = 3, lty = 2)
lines(as.numeric(fcast.tbats$mean), 
      col="magenta", lwd = 3,lty = 2)
lines(as.numeric(fcast.arima$mean), 
      col = "blue", lwd = 3, lty = 2)
legend("topright", 
       legend = c("Real Data", "NeuralNet", "TBATS", "ARIMA"), 
       col = c("red","green", "magenta","blue"), 
       lty = c(1, 2, 2, 2), lwd = c(5, 3, 3, 3))
grid()

# Mean absolute % error for predictions in December
mape <- function(r, f) {
  len <- length(r)
  return(sum(abs(r - f$mean[1:len]) / r) / len * 100)
}
mape(short.test, fcast.arima)
mape(short.test, fcast.nn)
mape(short.test, fcast.tbats)

