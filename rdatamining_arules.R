# Association Rule Mining with R by Yanchang Zhao
# http://www.RDataMining.com
# 27 November 2014

load("./cmf-econometrics-master/titanic.raw.rdata")

# draw a sample of 5 records
idx <- sample(1:nrow(titanic.raw), 5)
titanic.raw[idx, ]

summary(titanic.raw)

# Association Rule Mining ====

library("arules")
# see apriori() default parameters
rules.all <- apriori(titanic.raw)

inspect(rules.all)

# rules with rhs containing "Survived" only
rules <- apriori(titanic.raw, 
                 control = list(verbose = FALSE), 
                 parameter = list(minlen = 2, supp = 0.005, conf = 0.8), 
                 appearance = list(rhs=c("Survived=No", 
                                         "Survived=Yes"), 
                                   default="lhs"))

# keep three decimal places
quality(rules) <- round(quality(rules), digits = 3)

# order rules by lift
rules.sorted <- sort(rules, by = "lift")

inspect(rules.sorted)

# Removing Redundancy =====

# find redundant rules
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag = T)] <- NA
redundant <- colSums(subset.matrix, na.rm = T) >= 1

# which rules are redundant
which(redundant)

# remove redundant rules
rules.pruned <- rules.sorted[!redundant]

inspect(rules.pruned)

# Interpreting Rules ====

inspect(rules.pruned[1])  # only states that all children of class 2 survived
# Rules about children
rules <- apriori(titanic.raw, control = list(verbose = FALSE), 
                 parameter = list(minlen = 3, supp = 0.002, conf = 0.2), 
                 appearance = list(default = "none", rhs = c("Survived=Yes"), 
                                   lhs = c("Class=1st", "Class=2nd", 
                                          "Class=3rd", "Age=Child", 
                                          "Age=Adult")))
rules.sorted <- sort(rules, by = "confidence")
inspect(rules.sorted)

# Visualizing Association Rules

library("arulesViz")
plot(rules.all)
plot(rules.all, method = "grouped")
plot(rules.all, method = "graph")
plot(rules.all, method = "graph", control = list(type = "items"))
plot(rules.all, method = "paracoord", control = list(reorder = TRUE))

# Further Readings ====

# Post mining of association rules, such as selecting interesting
#   association rules, visualization of association rules and using
#   association rules for classification
# Yanchang Zhao, Chengqi Zhang and Longbing Cao (Eds.). “Post-Mining
#   of Association Rules: Techniques for Effective Knowledge Extraction”,
#   ISBN 978-1-60566-404-0, May 2009. Information Science Reference.

# Package arulesSequences: mining sequential patterns
# http://cran.r-project.org/web/packages/arulesSequences/



