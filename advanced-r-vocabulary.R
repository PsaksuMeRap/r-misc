# Advanced R by Hadley Wickham, Vocabulary
# http://adv-r.had.co.nz/Vocabulary.html

# The basics ====

# The first functions to learn
# ?
?str
# str
str(options())

# Important operators and assignment
# %in%, match
1:10 %in% c(1, 3, 5, 9)
match(x = 1:10, table = c(1, 3, 5, 9))
# =, <-, <<-
# $, [, [[, head, tail, subset
subset(1:10, c(rep(TRUE, 5), rep(FALSE, 5)))
# with
with(list(a=c(1:10), b=c(11:20)), summary(a > 5))
# assign, get
a <- 1:4
assign("a[1]", 2)
get("a[1]")

# Comparison
# all.equal, identical
all.equal(c(pi, 1), c(355/113, 2))
identical(pi, 355/113)
# !=, ==, >, >=, <, <=
# is.na, complete.cases
complete.cases(c(5, NA, 6))
# is.finite

# Basic math
# *, +, -, /, ^, %%, %/%
# abs, sign
# acos, asin, atan, atan2
# sin, cos, tan
# ceiling, floor, round, trunc, signif
# exp, log, log10, log2, sqrt
# max, min, prod, sum
# cummax, cummin, cumprod, cumsum, diff
cumsum(1:10)
cummax(1:10)
diff(1:10)
# pmax, pmin
x <- sample(1:100, 10)
y <- sample(1:100, 10)
pmax(x, y)
# range
range(x, y)
# mean, median, cor, sd, var
cor(1:10, 2:11)
# rle
inverse.rle(rle(rev(rep(6:10, 1:5))))

# Functions to do with functions
# function
# missing
# on.exit
# return, invisible

# Logical & sets
# &, |, !, xor
# all, any
any(1:10 > 5)
all(1:10 > 5)
# intersect, union, setdiff, setequal
intersect(c(1:10), c(5:15))
# which
which(LETTERS == "R")

# Vectors and matrices
# c, matrix
# automatic coercion rules character > numeric > logical
# length, dim, ncol, nrow
# cbind, rbind
# names, colnames, rownames
# t
# diag
# sweep
sweep(array(1:24, dim = 4:2), 1, 5)
# as.matrix, data.matrix
DF <- data.frame(a = 1:3, b = letters[10:12],
                 c = seq(as.Date("2004-01-01"), by = "week", len = 3),
                 stringsAsFactors = TRUE)
data.matrix(DF[1:2])
data.matrix(DF)

# Making vectors
# c
# rep, rep_len
# seq, seq_len, seq_along
seq_along(5:15)
# rev
rev(seq_along(5:15))
# sample
# choose, factorial, combn
choose(5, 3)
combn(5, 3)
# (is/as).(character/numeric/logical/...)

# Lists & data.frames
# list, unlist
# data.frame, as.data.frame
data.frame(1, 1:10, sample(LETTERS[1:3], 10, replace = TRUE))
# split
split(1:10, factor(sample(1:10, 10, replace = TRUE)))
# expand.grid
expand.grid(1:5, c("First", "Second"))

# Control flow
# if, &&, || (short circuiting)
f <- function() {
  print("function f() was evaluated")
  TRUE
}
FALSE && f()  # example of short circuiting
# for, while
# next, break
# Both break and next apply only to the innermost of nested loops
# switch
centre <- function(x, type) {
  switch(type, 
         "1" = mean(x), 
         "2" = median(x), 
         "3" = mean(x, trim = .1))
}
# The result of expression evaluation in the switch statement must be
#   a number or a character string
x <- rcauchy(10)
centre(x, 1)
centre(x, 2)
centre(x, 3)
# ifelse
x <- c(6:-4)
sqrt(x)  #- gives warning
sqrt(ifelse(x >= 0, x, NA))  # no warning

# Apply & friends
# lapply, sapply, vapply
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE, FALSE, FALSE, TRUE))
lapply(x, mean)
sapply(x, quantile)
# apply
apply(cbind(x1 = 3, x2 = c(4:1, 2:5)), 2, sum)
# tapply
tapply(rep_len(1, 10), sample(1:4, 10, replace = TRUE), sum)
# replicate
replicate(10, print(Sys.time()))


# Common data structures ====

# Date time
# ISOdate, ISOdatetime, strftime, strptime, date
x <- ISOdate(2010, 12, 31)
x
strftime(x)
str(date())
# difftime
difftime(Sys.time(), x, units = "days")
# julian, months, quarters, weekdays
julian(Sys.time(), origin = ISOdate(1989, 12, 29))
quarters(Sys.time())
# library(lubridate)
library("lubridate")

# Character manipulation
# grep, agrep
txt <- c("arm", "foot", "lefroo", "bafoobar")
grep("[a-d]", txt)
grep("[a-d]", txt, value = TRUE)
grepl("[a-d]", txt)
agrep("lasy", "1 lazy 2")
# gsub
gsub("lazy", "hard working", "lazy ass")
# strsplit
unlist(strsplit("2013:12:12", ":"))
unlist(strsplit("2013:12:12", ""))
# chartr
# nchar
# tolower, toupper
chartr("m0", "Mo", "m0sc0w")
toupper("moscow")
# substr
x <- "123456"
substr(x, 2, 4) <- "---"
# paste
paste("A", 1:6, sep = "+", collapse = "~~")
# library(stringr)
library("stringr")

# Factors
# factor, levels, nlevels
x <- factor(sample(letters, 10), levels = letters)
levels(x)
nlevels(x)
# reorder, relevel
y <- reorder(x, seq_len(8), FUN = sum)
# cut, findInterval
cut(runif(10), breaks = c(0, 0.33, 0.66, 1), right = TRUE)
findInterval(1:10, c(0, 3, 7, 10), rightmost.closed = TRUE)
# interaction
interaction(1:3, letters[1:3], sep = "+", lex.order = TRUE)
# options(stringsAsFactors = FALSE)

# Array manipulation
# array
# dim
# dimnames
dim(array(1:10)); dim(1:10)
# aperm
t(array(1:10)); aperm(array(1:10))
# library(abind)
library("abind")
x <- matrix(1:12, 3, 4)
y <- x + 100
abind(x, y, along = 1)


# Statistics ====

# Ordering and tabulating
# duplicated, unique
duplicated(c(1:4, 2:5), fromLast = TRUE)
# merge
a <- data.frame(name = letters[1:3], place = 2:4)
b <- data.frame(nick = letters[1:3], tool = c("R", "Stata", "Python"))
merge(a, b, by.x = "name", by.y = "nick")
merge(b, a, by.x = "nick", by.y = "name")
# order, rank, quantile
# order tells you how to get them in ascending order
order(x <- c(1,1,3:1,1:4,3), y <- c(9,9:1), z <- c(2,1:9))
# rank tells you what order the numbers are in
quantile(x, probs = runif(10))
# sort
sort(x) == x[order(x)]
# table, ftable
Titanic
ftable(Titanic, row.vars = 1:3)

# Linear models
ctl <- c(4.17, 5.58, 5.18, 6.11, 4.50, 4.61, 5.17, 4.53, 5.33, 5.14)
trt <- c(4.81, 4.17, 4.41, 3.59, 5.87, 3.83, 6.03, 4.89, 4.32, 4.69)
group <- gl(2, 10, 20, labels = c("Ctl", "Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1)  # omitting intercept
test <- factor(sample(c("Ctl", "Trt"), 10, replace = TRUE), 
               levels = c("Ctl", "Trt"))
# fitted, predict, resid, rstandard
fitted(lm.D9)
predict(lm.D9, newdata = data.frame(group = test))
resid(lm.D9)
rstandard(lm.D9)
# lm, glm
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1)  # omitting intercept
# hat, influence.measures
hatvalues(lm.D9)
influence.meaures(lm.D9)  # regression diagnostics
# logLik, df, deviance
logLik(lm.D9)
df.residual(lm.D9)
deviance(lm.D9)
# formula, ~, I
?formula
# weight ~ I(group)
# anova, coef, confint, vcov
anova(lm.D90)
coef(lm.D90)
confint(lm.D90)
vcov(lm.D90)
# contrasts
contrasts(group)  # needed when you fit linear models with factors

# Miscellaneous tests
apropos("\\.test$")

# Random variables
#(q, p, d, r) * (beta, binom, cauchy, chisq, exp, f, gamma, geom,
#  hyper, lnorm, logis, multinom, nbinom, norm, pois, signrank, t,
#  unif, weibull, wilcox, birthday, tukey)

# Matrix algebra
x <- matrix(1:4, nrow = 2, ncol = 2)
y <- matrix(5:8, nrow = 2, ncol = 2)
# crossprod, tcrossprod
crossprod(x, y)
# eigen, qr, svd
eigen(diag(1:4), only.values = TRUE)
qr(x)
svd(x)
svd(x)$u %*% diag(svd(x)$d) %*% t(svd(x)$v)
# %*%, %o%, outer
x %*% y
x %o% y
outer(x, y, "*")
# rcond
rcond(x)
# solve
solve(x, 1:2)


# Working with R ====

# Workspace
# ls, exists, rm
ls()
exists("test")
# getwd, setwd
# q
# source
# install.packages, library, require

# Help
# help, ?
# help.search
# apropos
# RSiteSearch
# citation
citation()
# demo
demo()
# example
example("lm")
# vignette

# Debugging
# traceback
# browser
# recover
# options(error = )  # current default error handler
# stop, warning, message
stop("too many interactions", call. = TRUE)
# tryCatch, try


# I/O ====

# Output
#print, cat
print("TEST", quote = TRUE)
# cat is useful to produce output in user-defined functions
# message, warning
message("Debugging in R is a headcase!")
warning("Don't be so reckless, boy!")
# dput
# format
# sink, capture.output

# Reading and writing data
# data
# The ‘.R’ file can effectively contain a metadata specification 
#   for the plaintext formats.
# count.fields
# can be useful in discovering problems in reading a file by read.table
# read.csv, write.csv
# read.delim, write.delim
# read.fwf
# readLines, writeLines
# readRDS, saveRDS
# load, save
# library(foreign)
library(help = "foreign")

# Files and directories
# dir
# basename, dirname, tools::file_ext
basename(getwd())
dirname(getwd())
# file.path
# path.expand, normalizePath
normalizePath(getwd())
# file.choose
# file.copy, file.create, file.remove, file.rename, dir.create
# file.exists, file.info
# tempdir, tempfile
tempfile(fileext = ".Rtmp")
tempdir()
# download.file, library(downloader)
# RCurl provides more comprehensive facilities to download from URLs
# Unlike RCurl, downloader requires no external dependencies
#   and adds functionality of downloading files over https 
#   and remote R script sourcing 
