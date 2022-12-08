# NHIS tutorial from IPUMS site
library(dplyr) 
if (!require("ipumsr")) stop("Reading IPUMS data into R requires the ipumsr package. It can be installed using the following command: install.packages('ipumsr')")

ddi <- read_ipums_ddi("nhis_00008.xml")
data <- read_ipums_micro(ddi)

# What proportion of the 2010 sample report being uninsured?
data %>%
  group_by(HINOTCOVE = as_factor(HINOTCOVE)) %>%
  summarize(n = n()) %>%
  mutate(pct = n / sum(n)) 

# To get a more accurate estimation of demographic patterns, you will have to utilize the
# person weights. 
data %>%
  group_by(HINOTCOVE = as_factor(HINOTCOVE)) %>%
  summarize(n = sum(PERWEIGHT)) %>%
  mutate(pct = n / sum(n)) 

# Using weights, what proportion of the population had a 4 year college or Bachelor's
# degree as their highest educational attainment?
data %>%
  group_by(EDUCREC2 = as_factor(EDUCREC2)) %>%
  summarize(n = sum(PERWEIGHT)) %>%
  mutate(pct = n / sum(n)) 