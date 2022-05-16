#----------------------------------------------------------------------------------------------------#
# INTRODUCTION TO R Part I
#----------------------------------------------------------------------------------------------------#
#
# Math Boot Camp, Department of Political Science, UCSD
# INSTRUCTOR: Chris Fariss and Dimitar Gueorguiev
# Tuesday, September 21, 2010
#
#
#----------------------------------------------------------------------------------------------------#
# STATISTICAL COMPUTING RESOURCES FOR R
#----------------------------------------------------------------------------------------------------#
#
# Quick-R for SAS/SPSS/Stata Users 
# http://www.statmethods.net
#
# UCLA Statistical Computing (R and Stata)
# http://www.ats.ucla.edu/stat/
# 
# R Seek (Search for R code)
# http://www.rseek.org/
#
# R Graph Gallery
# http://addictedtor.free.fr/graphiques/allgraph.php
#
# Simple R Plots
# http://www.phaget4.org/R/plot.html
#
# Zelig (its a sweet package by none other than Gary King and friends
# http://gking.harvard.edu/zelig/docs/
#
#
# IF ALL ELSE FAILS ...
# http://www.google.com
#
#
#----------------------------------------------------------------------------------------------------#


#----------------------------------------------------------------------------------------------------#
# BEGINNING AN R SESSION 
#----------------------------------------------------------------------------------------------------#

# what is the current working directory?
getwd()

# set the working directory to another folder 
# setwd()

# list objects in the working environment
ls() 

# remove all objects in the working environment
rm(list = ls())

# list objects in the working environment again
ls() 


# create an object and assign a scalar to it
obj1 <- 3

# display the value of the object
obj1

# use an object in a calculation
obj1+ 2
obj1 * 2
obj1^2

# remove just obj1 from memory
rm(obj1)

#----------------------------------------------------------------------------------------------------#
# Q1: what command removes all objects from memory?
#----------------------------------------------------------------------------------------------------#


# if you can remember the answer to the question above you can do a keyword search for the term remove
??remove

# if you remember the correct command rm() but do not remember the syntax for the command search for the help file for the specific command
?rm

#----------------------------------------------------------------------------------------------------#
#  Q2: what is the difference between ?? and ? when placed in front of a search term ?
#----------------------------------------------------------------------------------------------------#

# create an object that is a sequence of numbers
obj <- 1:10

# create an object that is a sequence of numbers
obj2 <- seq(from=1, to=10, by=2)
obj2

obj3 <- seq(from=2, to=10, by=2)
obj3

#----------------------------------------------------------------------------------------------------#
#  Q3: why are obj2 and obj3 different ?
#----------------------------------------------------------------------------------------------------#



#----------------------------------------------------------------------------------------------------#
# Q4: create a new object that is a sequence from -10 to 20 that contains 61 elements
# and then check the length of your new object
# hint use the length() command
#----------------------------------------------------------------------------------------------------#



# concatenate together several numbers into an object
obj4 <- c(1,3,2,3,2)
obj4

# use the object in a calculation
obj4+ 2
obj4 * 2
obj4^2

# create another concatenated object with 5 values
obj5 <- c(5,6,7,8,9)
obj5

# concatenate obj4 and obj5 together
obj6 <- c(obj4, obj5)
obj6

# column-bind obj4 and obj5 together
obj7 <- cbind(obj4, obj5)
obj7

# row-bind obj4 and obj5 together
obj8 <- rbind(obj4, obj5)
obj8

# see also for other methods of creating data structures 
?matrix
?vector 
?data.frame
?list

# and also see commands to draw random values from known distributions
?rnorm
?runif
?rbinom


#----------------------------------------------------------------------------------------------------#
# THE WONDERFUL WORLD OF LOOPS!
#----------------------------------------------------------------------------------------------------#

i <- 1
i

while(i <= 10){

i <- i + 1
}

i


count <- 1

for(i in 1:10){
count <- count + 1
}

count


#----------------------------------------------------------------------------------------------------#
#  Q5: Describe in words how the while loop works.  
#----------------------------------------------------------------------------------------------------#






