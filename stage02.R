# install the packages and load them
#install.packages(c("reshape2"))
#install.packages("stringi")
library(reshape2)
library(ggplot2)
library(tidyverse)



# Load the data
microbial_growth <- read.table("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/mcb/microbial_stationary_phase.dat", header = TRUE)

head(microbial_growth)
tail(microbial_growth)
str(microbial_growth)
summary(microbial_growth)

# reshape the data frame
reshaped_data <- melt(microbial_growth, id = "Time", value.name = "OD", variable.name = "Well")

# plot the data
ggplot(data = reshaped_data, aes(x = Time, y = OD )) +
  geom_line() +
  facet_wrap(~Well)

### from the plot we can say that bacteria enters stationary phase pretty much at the same time except for the first well A1


# Determine the time when the bacteria enters its stationary phase

## loop through the variables (columns)
for (j in 2:13) {
  
  ## create a variable gradient
  gradient <- c()
  
  ## loop through all the observations(rows)
  for (i in 1:54) {
    
    # calculate all the gradients
    g <- ((microbial_growth[i+1,j] - microbial_growth[i,j]) / (microbial_growth[i+1,1] - microbial_growth[i,1]))
    
    # append g to gradient
    gradient <- c(gradient, g)
  }
  
  
  for (t in which.max(gradient):54) {
    if (gradient[t] < 0) {
      
      # print the stationary point
      print(paste0("The bacteria enters the stationary phase for ", names(microbial_growth)[j], " at ", microbial_growth[t,1]))
      break;
    }
  }
}

# All the samples enter the stationary at the same time (11.86028) except for A1 which enters the stationary phase at 5.738611

