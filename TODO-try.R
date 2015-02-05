#!/usr/bin/env Rscript
# try.Rscript -- experiments with try

# Get any arguments
arguments <- commandArgs(trailingOnly=TRUE)
a <- arguments[1]

# Define a function that can issue custom warnings and errors
# Use '.call=FALSE' to remove the function call from the message
myFunc <- function(a) {
  if (a == 'warning') {
    return_value <- 'warning return'
    warning("custom warning message", call.=FALSE)
  } else if (a == 'error-A') {
    return_value <- 'error return'
    stop("custom error message A", call.=FALSE)
  } else if (a == 'error-B') {
    return_value <- 'error return'
    stop("custom error message B", call.=FALSE)
  } else {
    return_value = log(a)
  }
  return(return_value)
}

# Turn warnings into errors so they can be trapped
options(warn = 2)
result <- try(myFunc(a), silent=TRUE)

# Process any error messages
if (class(result) == "try-error") {
  # Ignore warnings while processing errors
  options(warn = -1)
  
  # If this script were a function, warning() and stop()
  # could be called to pass errors upstream
  msg <- geterrmessage()
  if (grepl("missing value", msg)) {
    result <- paste("USER ERROR: Did you supply an argument?")
  } else if (grepl("Non-numeric argument",msg)) {
    # Oops, forgot to convert argument to numeric
    a <- as.numeric(a)
    if (is.na(a)) {
      result <- "Argument is non-numeric"
    } else {
      result <- myFunc(a)
    }
  } else if (grepl("custom warning message", msg)) {
    result <- "Took action for warning message"
  } else if (grepl("custom error message A", msg)) {
    result <- "Took action for error message A"
  } else if (grepl("custom error message B", msg)) {
    result <- "Could call stop() to pass an error upstream."
  }
  
  # Restore default warning reporting
  options(warn=0)
}

print(result)
