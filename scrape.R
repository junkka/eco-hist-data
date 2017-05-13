library(readxl)
library(tidyverse)

r_url <- "http://www.ekh.lu.se/media/ekh/legs/forskning/database/lu-madd/prices_and_wages/wages/day_wages_1803-1914__sek_.xls"
t_d <- tempdir()

download.file(r_url, file.path(t_d, "temp.xls"))
indata <- read_excel(file.path(t_d, "temp.xls"), skip = 4, col_names = T)

wages <- indata %>% gather(county, wage, -`SEK`) %>% 
	rename(year = `SEK`) %>% 
	mutate(year = as.integer(year)) %>% 
	filter(!is.na(year))

write_csv(wages, path="data/wages-1803-1914.csv")

r_url <- "http://www.ekh.lu.se/media/ekh/legs/forskning/database/lu-madd/prices_and_wages/agriculture/price_of_rye_1776-1914__sek_per_hectolitre_.xls"
t_d <- tempdir()

download.file(r_url, file.path(t_d, "temp.xls"))
indata <- read_excel(file.path(t_d, "temp.xls"), skip = 4, col_names = T)

rye_price <- indata %>% gather(county, price, -`SEK/hectolitre`) %>% 
	rename(year = `SEK/hectolitre`) %>% 
	mutate(year = as.integer(year)) %>% 
	filter(!is.na(year))

write_csv(rye_price, path = "data/rye-prices-1776-1914.csv")
