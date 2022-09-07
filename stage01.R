# load the packages
library(reshape2)
library(ggplot2)
library(tidyverse)

# load the data

microbial_growth <- read.table("https://github.com/HackBio-Internship/public_datasets/blob/main/R/datasets/microbial_growth_data?raw=true", header = TRUE)


#dimension of the data
dim(microbial_growth)

# names of the variables
names(microbial_growth)


# Structure of our data
str(microbial_growth)


summary(microbial_growth)
glimpse(microbial_growth)


# check for missing values
sum(is.na(microbial_growth))

# Extract unique temperatures
unique(microbial_growth$Temperature)

# install the packages



## Effect of the temperature of the growth of bacteria
reshaped <- melt(data = microbial_growth, id = c("Time", "Temperature"), variable.name = "Well", value.name = "Absorbance")
microbial_growth$Time_in_minute <- microbial_growth$Time / 60

reshaped$Time_in_minute <- reshaped$Time/60

# plot the data
ggplot(data = reshaped, aes(x = Time, y = Absorbance )) +
  geom_line() +
  facet_wrap(~Well)
