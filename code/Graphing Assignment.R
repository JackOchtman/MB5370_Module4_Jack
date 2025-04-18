

# Install and load tidyverse and ggplot packages, run install lines only if needed.
#install.packages("tidyverse")
library("tidyverse")
#install.packages("ggplot2")
library("ggplot2")

#Adds the dataframe

df <- read_csv("C:/Users/Spart/Documents/Github/MB5370_Module4_Jack/data/Extracted_Fish_Population_Data.csv")

library(ggplot2)

# Create the plot
ggplot(df, aes(x = Days.from.Unification, y = Number.of.Fish, color = Species)) +
  geom_smooth(method = "loess", se = FALSE) +  # Smoothed line without confidence interval
  labs(title = "Fish Species Growth Over Days of Unification",
       x = "Days from Unification",
       y = "Number of Fish") +
  theme_minimal()  # Optional theme