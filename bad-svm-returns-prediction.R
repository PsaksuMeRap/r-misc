# Using R in Algorithmic Trading: Building and testing a machine learning model
# http://mechanicalforex.com/

library("quantmod")
library("caret")
library("ggplot2")
library("e1071")
library("rpart")

getSymbols("UUP", src = "google")
daily <- dailyReturn(UUP)
daily <- na.omit(daily)

t <- 10
k <- length(daily[, 1]) - t + 1
data <- data.frame(matrix(NA, nrow = k, ncol = t))

colnames(data)[1] <- "output"

for (i in 2:t){
  colnames(data)[i] <- paste(c("input", i), collapse = "")
}

j <- 1
for (i in t:length(daily[, 1])) {  
  data$output[j] <- daily[i, 1]
  for(n in 2:t){
    data[j, n] <- daily[i - n + 1, 1]
  }
  j <- j + 1
}

trainIndex <- createDataPartition(data$output, 
                                  p = 0.70, list = FALSE, times = 1)
efTrain <- data[trainIndex, ]
efTest <- data[-trainIndex, ]

r1 <- svm(output ~ ., data = efTrain, cost = 1000, gamma = 0.01)

p <- ggplot()
p <- p + geom_point(size = 3, aes(x      = efTrain$output, 
                                  y      = predict(r1, efTrain), 
                                  colour = "Training set"))
p <- p + geom_point(size = 3, aes(x      = efTest$output, 
                                  y      = predict(r1, efTest), 
                                  colour = "Testing set"))
p <- p + ylab("Predicted return")
p <- p + xlab("Real return")
p <- p + theme(axis.title.y = element_text(size = rel(1.5)))
p <- p + theme(axis.title.x = element_text(size = rel(1.5)))
p <- p + theme(axis.text.x = element_text(angle = 45, hjust = 1))
p <- p + theme(panel.background = element_rect(colour = "black"))
p

efTest$error <- 100 * (abs(predict(r1, efTest) - efTest$output))
efTest <- na.omit(efTest)
mean(efTest$error)

