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
data.frame, as.data.frame
split
expand.grid

          # Control flow
          if, &&, || (short circuiting)
          for, while
          next, break
          switch
          ifelse

          # Apply & friends
          lapply, sapply, vapply
          apply
          tapply
          replicate
          Common data structures
          # Date time
          ISOdate, ISOdatetime, strftime, strptime, date
          difftime
          julian, months, quarters, weekdays
          library(lubridate)

          # Character manipulation
          grep, agrep
          gsub
          strsplit
          chartr
          nchar
          tolower, toupper
          substr
          paste
          library(stringr)

          # Factors
          factor, levels, nlevels
          reorder, relevel
          cut, findInterval
          interaction
          options(stringsAsFactors = FALSE)

          # Array manipulation
          array
          dim
          dimnames
          aperm
          library(abind)
          Statistics
          # Ordering and tabulating
          duplicated, unique
          merge
          order, rank, quantile
          sort
          table, ftable

          # Linear models
          fitted, predict, resid, rstandard
          lm, glm
          hat, influence.measures
          logLik, df, deviance
          formula, ~, I
          anova, coef, confint, vcov
          contrasts

          # Miscellaneous tests
          apropos("\\.test$")

          # Random variables
          (q, p, d, r) * (beta, binom, cauchy, chisq, exp, f, gamma, geom,
                          hyper, lnorm, logis, multinom, nbinom, norm, pois, signrank, t,
                          unif, weibull, wilcox, birthday, tukey)

          # Matrix algebra
          crossprod, tcrossprod
          eigen, qr, svd
          %*%, %o%, outer
          rcond
          solve
          Working with R
          # Workspace
          ls, exists, rm
          getwd, setwd
          q
          source
          install.packages, library, require

          # Help
          help, ?
          help.search
          apropos
          RSiteSearch
          citation
          demo
          example
          vignette

          # Debugging
          traceback
          browser
          recover
          options(error = )
          stop, warning, message
          tryCatch, try
          I/O
          # Output
          print, cat
          message, warning
          dput
          format
          sink, capture.output

          # Reading and writing data
          data
          count.fields
          read.csv, write.csv
          read.delim, write.delim
          read.fwf
          readLines, writeLines
          readRDS, saveRDS
          load, save
          library(foreign)

          # Files and directories
          dir
          basename, dirname, tools::file_ext
          file.path
          path.expand, normalizePath
          file.choose
          file.copy, file.create, file.remove, file.rename, dir.create
          file.exists, file.info
          tempdir, tempfile
          download.file, library(downloader)
