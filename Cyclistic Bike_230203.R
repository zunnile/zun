library(tidyverse)  
library(lubridate)  
library(ggplot2)  
getwd() 
setwd("D:/career/Data Analytics/Final Project/working directory")
#Import all monthly datasets
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
#Check data structure of all files to make sure that they can be combined
str(m1_2022)
str(m2_2022)
str(m3_2022)
str(m4_2022)
str(m5_2022)
str(m6_2022)
str(m7_2022)
str(m8_2022)
str(m9_2022)
str(m10_2022)
str(m11_2022)
str(m12_2022)
#Merge all datasets into a single one
all_trips <- bind_rows(m1_2022, m2_2022, m3_2022, m4_2022, m5_2022, m6_2022, m7_2022, m8_2022, m9_2022, m10_2022, m11_2022, m12_2022)
#Extract the month, day, day of week and hour of the day from the date respectively
all_trips$month <- month(all_trips$started_at, label=TRUE)
all_trips$day <- day(all_trips$started_at)
all_trips$day_of_week <- wday(all_trips$started_at, label = TRUE)
all_trips$hour_of_day <- hour(all_trips$started_at)
#Calculate the length of each ride
all_trips$ride_length <- difftime(all_trips$ended_at,all_trips$started_at)
#Convert the ride length into numeric data
all_trips$ride_length <- as.numeric(as.character(all_trips$ride_length))
#Remove the trips with negative ride length and the trips on which the bikes were taken out for quality checking
all_trips_v2 <- all_trips[!(all_trips$start_station_name == "HQ QR" | all_trips$ride_length < 0),]
#Delete incomplete rows
all_trips_v2 <- all_trips_v2 %>% drop_na()
#Export csv file
write.csv(all_trips_v2, "all_trips_data.csv")