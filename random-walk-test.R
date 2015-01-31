# Using R in Algorithmic Trading: 
# Testing whether an instrument follows a random walk
#   http://mechanicalforex.com/
# More info on the Portmanteau test and other similar tests: 
#   http://www.eea-esem.com/files/papers/EEA-ESEM/2008/210/joejan2008.pdf

library("vrtest")
data(exrates)
y <- exrates$ca
nob <- length(y)
r <- log(y[2:nob]) - log(y[1:(nob - 1)])
Auto.Q(r, lags = 40)  # the max lag you want (10, 20, 30, etc)
# Drawbacks of the Portmanteau test:
# - test requires a lot of data (nob > 5000) for intraday data
#     (as it's cyclical in nature)
# - lag should be a lot more than the default 10 for intraday data


