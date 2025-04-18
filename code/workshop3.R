## This code contains the workshop 3 exercises for MB5370 Module 4 - Data science 

# Jack Ochtman

#install and load packages.  Commented out unless needed

#install.packages("tidyverse")
#library("tidyverse)

#This section uses datasets included with the tidyverse package

# Uses the mutate function to get cases/10,000 people instead of raw case numbers.
table1 %>% 
  mutate(rate = cases / population * 10000)

# Compute cases per year
table1 %>% 
  count(year, wt = cases)

# Visualise changes over time
library(ggplot2)
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

# Now using the billboard dataset to showcase pivoting and lengthening
# Pivoted so each row contains an observation.  However, multiple
# NA values are added in this process
billboard |> 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    values_to = "rank"
  )

#Same as above, but with added "values_drop_na" function to remove NA values.

billboard |> 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    values_to = "rank",
    values_drop_na = TRUE
  )

#More on pivoting, using an extremely simple 3 variable dataset for visualisation purposes

#Creates simple dataset
df <- tribble(
  ~id,  ~bp1, ~bp2,
  "A",  100,  120,
  "B",  140,  115,
  "C",  120,  125
)

# Gives dataset three named variables: ID, measurment (column names), value (cell values)

df |> 
  pivot_longer(
    cols = bp1:bp2,
    names_to = "measurement",
    values_to = "value"
  )

# Pivot wider is useful if data is scattered across multiple rows.  In this example the cms_patient_experience sample dataset is used.

#Shows variables and column names
cms_patient_experience |> 
  distinct(measure_cd, measure_title)


#Pivots wider, using measure_cd as the source for column names and prf_rate as the source for values
cms_patient_experience |> 
  pivot_wider(
    names_from = measure_cd,
    values_from = prf_rate
  )

#Incorrect results, need to designate values to identify each row.  Values starting with org used below.

cms_patient_experience |> 
  pivot_wider(
    id_cols = starts_with("org"),
    names_from = measure_cd,
    values_from = prf_rate
  )

#Simple example of pivoting wider, as before with pivot longer.

#creates the simple dataset

df2 <- tribble(
  ~id, ~measurement, ~value,
  "A",        "bp1",    100,
  "B",        "bp1",    140,
  "B",        "bp2",    115, 
  "A",        "bp2",    120,
  "A",        "bp3",    105
)

#Takes names from measurment column and values from value column

df2 |> 
  pivot_wider(
    names_from = measurement,
    values_from = value
  )

# Unique values in measurment used for column names

df2 |> 
  distinct(measurement) |> 
  pull()

#Rows determined by variables that aren't used as names or values

df2 |> 
  select(-measurement, -value) |> 
  distinct()

# pivot wider combines results to generate empty dataframe

df2 |> 
  select(-measurement, -value) |> 
  distinct() |> 
  mutate(x = NA, y = NA, z = NA)

# Final step is to fill in missing values using the input data.

# Exercises.

# Question 1: Why are pivot_longer() and pivot_wider() not perfectly symmetrical? 

#Creates dataset for question
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

stocks %>% 
  pivot_wider(names_from = year, values_from = return) %>%   #Pivots the dataset longer
  pivot_longer(`2015`:`2016`, names_to = "year", values_to = "return")  #Then pivots wider

#The end result is not the same as the original dataset.  This is due to the names_from function in the pivot_wider function converting the year values
# (or any other values used as column names) into categorical data from the original numeric data, and pivot_longer does not convert them back.

# Question 2: Why does this code fail?

# Failing code for question
table4a %>% 
  pivot_longer(c(1999, 2000), names_to = "year", values_to = "cases")

#Opens table 4a
table4a

# Table 4a is a 3x3 tibble that does not contain "year" or "cases".  Using (c(1999,2000)) does not select cells with those values,
# it selects cells with those locations.  In a 3x3 tibble columns 1999 and 2000 obviously do not exist, resulting in the error.
# Using backticks tells R to treat 1999 and 2000 as column names, not locations.

# Fixed code for answer.
table4a %>% 
  pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")


# Question 3:  Consider the sample tibble below. Do you need to make it wider or longer? What are the variables?

# Creates tibble for question
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

# Variables are gender (male/female), pregnant(Y/N) and count.  Male/female variable is split actoss two columns.
# Making it longer can put male and female as a single column.

# Pivots the tibble longer to create a gender column.
preg %>%
  pivot_longer(
    cols = c(male, female),
    names_to = "gender",
    values_to = "count"
  )
