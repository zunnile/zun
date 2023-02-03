library(tidyverse)  #helps wrangle data
library(lubridate)  #helps wrangle date attributes
library(ggplot2)  #helps visualize data
getwd() #displays your working directory
setwd("D:/career/Data Analytics/Final Project/working directory")
m1_2022 <- read_csv("202201-divvy-tripdata.csv")
m2_2022 <- read_csv("202202-divvy-tripdata.csv")
m3_2022 <- read_csv("202203-divvy-tripdata.csv")
m4_2022 <- read_csv("202204-divvy-tripdata.csv")
m5_2022 <- read_csv("202205-divvy-tripdata.csv")
m6_2022 <- read_csv("202206-divvy-tripdata.csv")
m7_2022 <- read_csv("202207-divvy-tripdata.csv")
m8_2022 <- read_csv("202208-divvy-tripdata.csv")
m9_2022 <- read_csv("202209-divvy-tripdata.csv")
m10_2022 <- read_csv("202210-divvy-tripdata.csv")
m11_2022 <- read_csv("202211-divvy-tripdata.csv")
m12_2022 <- read_csv("202212-divvy-tripdata.csv")
all_trips <- bind_rows(m1_2022, m2_2022, m3_2022, m4_2022, m5_2022, m6_2022, m7_2022, m8_2022, m9_2022, m10_2022, m11_2022, m12_2022)
all_trips <- all_trips %>%  
  select(-c(start_lat, start_lng, end_lat, end_lng))
all_trips$date <- as.Date(all_trips$started_at) #The default format is yyyy-mm-dd
all_trips$month <- format(as.Date(all_trips$date), "%m")
all_trips$day <- format(as.Date(all_trips$date), "%d")
all_trips$day_of_week <- format(as.Date(all_trips$date), "%A")
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length<0),]
all_trips_v2 <- all_trips_v2 %>% drop_na()
write.csv(all_trips_v2, "all_trips_data.csv")
aggregate(all_trips_v2$ride_length~all_trips_v2$member_casual, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = median)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = max)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual, FUN = min)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$day_of_week, FUN = mean)
aggregate(all_trips_v2$ride_length ~ all_trips_v2$member_casual + all_trips_v2$month, FUN = mean)
all_trips_v2 %>% 
  mutate(weekday=wday(started_at, label=TRUE))
all_trips_v2 %>% 
  group_by(member_casual) %>% 
  summarise(number_of_rides = n(), avg_ride_length = mean(ride_length))
