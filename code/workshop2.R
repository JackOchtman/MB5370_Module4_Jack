## This code contains the workshop 2 exercises for MB5370 Module 4 - Data science 

# Jack Ochtman

#install and load packages.  Commented out unless needed

#install.packages("ggplot2")
#library("ggplot2")

#Example illustrating use of the labs() function to set a title

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se.e = FALSE) +
  labs(title = "Fuel efficiency generally decreases with engine size")

# Illustrates use of the subtitle and caption functions withing labs().  Fixed your sneaky error.

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  labs(
    title = "Fuel efficiency generally decreases with engine size",
    subtitle = "Two seaters (sports cars) are an exception because of their light weight",
    caption = "Data from fueleconomy.gov"
  )

# Setting axis and legend titles with labs()

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_smooth(se = FALSE) +
  labs(
    x = "Engine displacement (L)",
    y = "Highway fuel economy (mpg)",
    colour = "Car type"
  )


#Use of geom_text() to add text inside the plot.  In this example a specific data value is selected and highlighted in the plot.

best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  geom_text(aes(label = model), data = best_in_class)

# Labels overlap, can use the nudge() function to reposition the text.


# Setting scales manually instead of letting ggplot do it automatically as above.

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class)) +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_colour_discrete()

# Setting axis ticks.

ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5))

# What does seq do? 

#Changes seq values
ggplot(mpg, aes(displ, hwy)) +
  geom_point() +
  scale_y_continuous(breaks = seq(10, 50, by = 10))

# seq gives the minimum and maximum tick values, and the increment.

# Choosing legend position and colour scheme.  Options are commented out, changing which line is uncommented will change the legend position. 

base <- ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = class))
#base + theme(legend.position = "left")
#base + theme(legend.position = "top")
base + theme(legend.position = "bottom")
#base + theme(legend.position = "right")


# Replacing a scale, in this case the scale is set to the log transformation
ggplot(diamonds, aes(carat, price)) +
  geom_bin2d() + 
  scale_x_log10() + 
  scale_y_log10()

# Setting colour scale

#Plot without colour scale custimisation
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv))

# Plot using colorbrewet set 1
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv)) +
  scale_colour_brewer(palette = "Set1")

# Added shape mapping
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = drv, shape = drv)) +
  scale_colour_brewer(palette = "Set1")

# Setting colours manually - useful for predefined colours or when there are a small number of variables.
presidential %>%
  mutate(id = 33 + row_number()) %>%
  ggplot(aes(start, id, colour = party)) +
  geom_point() +
  geom_segment(aes(xend = end, yend = id)) +
  scale_colour_manual(values = c(Republican = "red", Democratic = "blue"))

# Using the viridis colour scheme, from the viridis package
install.packages('viridis')
install.packages('hexbin')
library(viridis)
library(hexbin)

df <- tibble( # note we're just making a fake dataset so we can plot it
  x = rnorm(10000),
  y = rnorm(10000)
)
ggplot(df, aes(x, y)) +
  geom_hex() + # a new geom!
  coord_fixed()

ggplot(df, aes(x, y)) +
  geom_hex() +
  viridis::scale_fill_viridis() +
  coord_fixed()

# Setting themes - eight included by default, packages like ggthemes add more.  Examples below:

# Black and White theme
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_bw()

# Light theme
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_light()

# Classic Theme
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_classic()

# Dark theme
ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) +
  theme_dark()

# Can also develop your own themes by setting theme() arguments.  Examples below:

#theme (panel.border = element_blank(),
       #panel.grid.minor.x = element_blank(),
       #panel.grid.minor.y = element_blank(),
       #legend.position="bottom",
       #legend.title=element_blank(),
       #legend.text=element_text(size=8),
       #panel.grid.major = element_blank(),
       #legend.key = element_blank(),
       #egend.background = element_blank(),
       #xis.text.y=element_text(colour="black"),
       #axis.text.x=element_text(colour="black"),
       #text=element_text(family="Arial")) 

# ggsave function used to export plots to files.  Can also use R markdown to export.
# Creates plot
ggplot(mpg, aes(displ, hwy)) + geom_point()
# Saves plots
ggsave("my-plot.pdf")
#> Saving 7 x 4.32 in image