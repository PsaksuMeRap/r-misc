# http://www.r-bloggers.com/
# Checking Function Arguments

cylinder.volume.2 <- function(height, radius) {
  # 
  if (missing(height))
    stop("Need to specify height of cylinder for calculations.")  
  if (missing(radius))
    stop("Need to specify radius of cylinder for calculations.")
  
  volume <- pi * radius * radius * height
}

cylinder.volume.2(height = 7)
cylinder.volume.2(radius = 10)

cylinder.volume.3 <- function(height, radius) {
  #
  if (missing(height))
    stop("Need to specify height of cylinder for calculations.")
  if (missing(radius))
    stop("Need to specify radius of cylinder for calculations.")
  if (height < 0)
    stop("Negative height specified.")
  if (radius < 0)
    stop("Negative radius specified.")
  
  volume <- pi * radius * radius * height
}

cylinder.volume.3(10, -4)

