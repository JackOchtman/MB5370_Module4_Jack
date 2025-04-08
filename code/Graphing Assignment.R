


data <- read.csv("E:/MB5370/MB5370_Module4_Jack/data/Extracted_Fish_Population_Data.csv")

library(ggplot2)

# Create the plot
ggplot(data, aes(x = Days.from.Unification, y = Number.of.Fish, color = Species)) +
  geom_smooth(method = "loess", se = FALSE) +  # Smoothed line without confidence interval
  labs(title = "Fish Species Growth Over Days of Unification",
       x = "Days from Unification",
       y = "Number of Fish") +
  theme_minimal()  # Optional theme
####test
