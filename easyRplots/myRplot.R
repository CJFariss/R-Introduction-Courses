## myRplot.R
##########################################################################
## Student name: your_first_name_here your_last_name_here
## COURSE NAME: Human Rights
## University of Michigan, Winter 2021
##########################################################################

## hint01: you only need to know getwd(), read.csv(), and plot() or barplot() to complete the R plot assignment for class

## hint02: modify the code below for your own R graph


## this line varifies that I'm in the working directory
getwd()

## if you want to change the workin directory, you can use this line 
## this line tells R where to find the files
##setwd("/Users/cjfariss/Documents/R1")

## read in data file from csv file
data <- read.csv("ny_stop_frisk.csv")

## print data to screen
data

## look at the third column of data
data$total

## make a barplot
barplot(data$total)

## read in data file from csv file
data <- read.csv("ny_stop_frisk_black.csv")

## print the data to screen
data

## make a barplot
barplot(data$total)


## use the code from the end of the easyRplots.R file to modify your dataset
par(mar=c(8,4,2,2))
barplot(data$total, 
        col="blue", 
        main="title of the graph", 
        ylab="number of stops", 
        xlab="year", 
        names.arg=data$year)


