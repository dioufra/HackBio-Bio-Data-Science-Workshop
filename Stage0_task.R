# stage0 task

# caluclate the product of 31 and 78
31*78

# divide 697 by 41
697/41

# Add 314 and 654
314 + 654

# Substrack 23 from 56765
56765 - 23
# Assign 39 to x and 14 to y and store the difference to z
x <- 39
y <- 14
z <- x - y

# square root of 2345 and log2 transformation of the result.
square_root <- sqrt(2345)
log2(square_root)

# create vec1 with the numbers 2,5,8,12 and 16
vec1 <- c(2,5,8,12,16)

# create a vector of 100 values starting at 2 and increasing by 3 each time
vec2 <- seq(2,100,3)

# extract the values at position 5 10 15 20 in vec2
vec2[c(5,10,15,20)]

# extract the values at position 10 and 30
vec2[c(10, 30)]

# create a vector mouse_color with values purple, red, yellow, and brow
mouse_color <- c("purple", "red", "yellow", "brown")

# create a vector mouse_weigth with values 23, 21, 18, and 16
mouse_weight <- c(23, 21, 18, 16)

# join mouse_color and mouse_weight in a dataFrame
mouse_info <- data.frame("color" = mouse_color, "weight"= mouse_weight)

# download file from a url
download.file("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/small_file.txt",
              "/cloud/project/small_file.txt")

# read the file "small_file.txt" and view the data
small <- read.table("small_file.txt", header = TRUE, sep = "\t")
View(small)

# read the "Child_Variant.csv"
download.file("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/Child_Variants.csv",
                               "/cloud/project/Child_Variant.csv")  # download the file

child_variant <- read.csv("Child_Variant.csv", header = TRUE, sep = ",")
head(child_variant)
View(child_variant)

# calculate the mean of MutantReadPercent
mean(child_variant$MutantReadPercent)

# Filter child_variant: MutantReadPercent >= 70  using the subset()
filtered_child_variant <- subset(child_variant, MutantReadPercent >= 70)

# Filter child_variant: MutantReadPercent >= 70  using the [] notation

# Visualization

library(ggplot2) # load the library

# save iris under iris_table
pl <- ggplot(iris)

# Sepal.length Vs Sepal.Width
pl+geom_point(aes(x = Sepal.Length, y = Sepal.Width, color = Species))

# Petal.lenght and Petal.Widht
pl+geom_point(aes(x = Petal.Length, y = Petal.Width, color = Species))


# correlation
pairs(iris[,1:4],col=iris[,5],oma=c(4,4,6,12))
par(xpd=TRUE)
legend(0.85,0.6, as.vector(unique(iris$Species)),fill=c(1,2,3))
