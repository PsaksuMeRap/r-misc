# Goodness of fit test in R
# http://hameddaily.blogspot.ru/2015/01/goodness-of-fit-test-in-r2.html

# An arbitrary dataset
num_of_samples <- 1000
x <- rgamma(num_of_samples, shape=10, scale=3)
x <- x + rnorm(length(x), mean=0, sd=0.1)

# Major steps to determine the generative distribution for the dataset

# 1. Visualization
p <- hist(x, breaks=50)

# 2. Guess what distribution would fit to the data the best

# 3. Use statistical tests for goodness of fit

# The following is true for all the tests to be considered
# H0 = the data is consistent with a specified reference distribution
# H1 = the data is not consistent with a specified reference distribution

# Chi Square test
# The chi-square (I) test is used to determine whether
# there is a significant difference between the expected frequencies
# and the observed frequencies in one or more categories.
# - Candidate distribution needs to be a pmf where its sum is 1.
# - It needs to be run using Monte Carlo to make sure its result is accurate
#   enough (simulate.p.value=TRUE, B - iteration number)

library("zoo")
breaks_cdf <- pgamma(p$breaks, shape=10, scale=3)
null.probs <- rollapply(breaks_cdf, 2, function (x) x[2]-x[1])
res <- chisq.test(p$counts, p=null.probs, rescale.p=TRUE,
                  simulate.p.value=TRUE, B=1000)
cat(res$p.value)

# Cramer-von Mises criterion
# Cramer von Mises test compares a given empirical distribution
# with another distribution.
# Since the second gamma distribution is the basis of the comparison
# we are using a large sample size to closely estimate the Gamma distribution.

library("CDFt")
num_of_samples <- 10^5
y <- rgamma(num_of_samples, shape=10, scale=3)
res <- CramerVonMisesTwoSamples(x, y)
p.value <- 1/(10*res)
cat(p.value)


# Kolmogorov-Smirnov test
# Kolmogorov-Smirnov is simple nonparametric test
# for one dimensional probability distribution.
# Same as Cramer von Mises test, it compares empirical distribution
# with reference probability.

num_of_samples <- 100000
y <- rgamma(num_of_samples, shape=10, scale=3)
res <- ks.test(x, y=y)
cat(res$p.value)

# 4. Repeat 2 and 3 if measure of goodness is not satisfactory
