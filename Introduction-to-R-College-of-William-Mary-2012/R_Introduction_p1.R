
#----------------------------------------------------------------------------------------------------#
# INTRODUCTION TO R Part I
#----------------------------------------------------------------------------------------------------#
#
# College of William & Mary, Department of Government
# INSTRUCTOR: Jaime Settle and Chris Fariss
# Thursday, October 18th
# See http://polisci2.ucsd.edu/cfariss/Home/Christopher_J_Fariss.html for additional resources
#

#----------------------------------------------------------------------------------------------------#
# WORKING DIRECTORY and WORKING ENVIRONMENT
#----------------------------------------------------------------------------------------------------#

#When you open R, you are greeted by a prompt: >
#This is the character that indicates you can type in your command
#Your output will be prefaced by an index for the line number, such as [1]
#The # character is what we call the "comment" character. When you want to write something in your code that you don't want to run, you need to "comment it out."

# what is the current working directory?
getwd()

# set the working directory to another folder 
# for a Mac, it might look something like this: setwd("/Users/jaimesettle/Desktop/RIntro")
# setwd()

# list objects in the working environment
ls() 

# remove all objects in the working environment
rm(list = ls())

# list objects in the working environment again
ls() 



#----------------------------------------------------------------------------------------------------#
# R AS A FANCY CALCULATOR
#----------------------------------------------------------------------------------------------------#

#You can use all of the usual arithmetic operations: +, -, *, /, ^ . Remember your order of operations!

2+3

4^2-3*2

#In addition to common arithmetic operations, R has hundreds of other functions, for everything from mathematical operations to data analysis, to making graphs

#to learn what you need to input into a function, type in help(function) or ?(function), where "function" is the name of the function you want


help(log)

#Notice that all of this code produces the same answer
log(100)
log(100, base=10)
log(100, 10)


#----------------------------------------------------------------------------------------------------#
# R AS A WAY TO GENERATE DATA
#----------------------------------------------------------------------------------------------------#

#The simplest data structure is a numeric vector, which is a one-dimensional set of numbers. In fact, in individual number is just a vector with a single element

#The simple way to construct a vector is with the c function

c(1,2,3,4)

#Here are some other options

1:4
4:1
-1:2
seq(1,4)
seq(2,8, by=2)
seq(0,1, length=11)

rep(5,3)
rep(c(1,2,3), 2)


##Vectors can be made of things other than just numbers

c("Cat", "Dog", "Bird", "Snake", "Rabbit")
rep(rep(c('male', 'female'), c(5,5)), 2)


#You can combine arithmetic functions with operators on vectors

c(1,2,3,4)/2


#Of course, most of the time we want to be able to save these variables. To do that, we use the assignment operator <-

#There are a few "best practice" rules. Variable names are composed of letters, numerals, or periods, but must begin with a letter or period. Variable names are case sensitive. 

x<- c(1,2,3,4)
y <- sqrt(x)

gender <- rep(rep(c('male', 'female'), c(5,5)), 2)


#Notice that once you've defined a variable, you can use it to define another variable. You can redefine a variable anytime you want


#You can use the rnorm function to generate standard-normal random numbers. The default is with mean=0 and sd=1

z <- rnorm(100)
z
summary(z)

#If you do it again, you will another random draw


#Looking at particular rows and columns

z <- rnorm(100)
z[21]
z[11:20]
z[-(11:20)]

#Logical values are either T or F, and can be used in conjunction with comparison operators.

x <- z[1:10]
x <  -.5
abs(x) > .5


#----------------------------------------------------------------------------------------------------#
# PACKAGES
#----------------------------------------------------------------------------------------------------#

#There are basic functions and operations built into R, but you will likely want to do other things than just the standard capabilities. There are hundreds of packages that you can easily install and load to give you additional functionalities. 

#A package is simply a collection of functions, code and data in a well-defined format that is ready for you to use instead of needing to write your own code. The directory where the packages are stored are clued a library. 

#The first things is to see what packages you have. Some of these will come default. 

package.manager()

#Let's say you want to find a package and install it. This is one of the few times I use the menu. Go to "Packages & Data" and click "Package Installer." Then you can search for packages that are interesting, and install them (including dependencies)

#However, installing the package doesn't mean that it is ready to use. While you only have to install packages once, you need to load them for each new session of R. To do this, you use the library() command

library(sna)

#----------------------------------------------------------------------------------------------------#
# LOADING IN DATA
#----------------------------------------------------------------------------------------------------#

#Although it is very rare that you would need to do this, you can enter in data by hand. There are really very few times you would need to do this, but it will be a good practice for what we want to do. 

#See Data Generation Exercise 1

#Most of the time, you are going to want to load in data from another source. This, in theory, is very easy when you are using delimited data (that is, plain text data that is separated in some way, such as white space, commas, or tabs.) In practice, this means that .dat, .txt or .csv files are the easiest to load in.

#Loading in Data

#Look at the documentation for this command
?read.table

#Notice that you need to give R some information. Where do you find the file? Is there a header row? How are the columns separated? What does missing data look like? 

#There are several other read options.
#read.csv # virtually identical 
#read.delim # very similar to read.table
#read.fwf # when you have data with fixed width

#When you have data from other software programs, you need to install the "foreign" package

library(foreign)

?read.spss  #this reads in SPSS files
?read.xport  #this reads in SAS files


#You can also import files straight from the Internet

macro <- read.csv("http://polisci2.ucsd.edu/cfariss/code/macro.csv")


#In the beginning, I found that this was one of the more frustrating aspects of learning R, but once you get the hang of it, it is less of a hassle


#----------------------------------------------------------------------------------------------------#
# GETTING A FEEL FOR YOUR DATA
#----------------------------------------------------------------------------------------------------#

#Let's take a closer look at the macro dataset. 

#A good first step is to get a sense of the size and an overview of your data. These are some commands--fill in the parentheses with the name of your data, in this case, "macro", i.e. names(macro)

names()
dim()
nrow()
ncol()
dim()[1]
dim()[2]


#Next, you might want to look at specific variables. To do this, you use the format "dataset$variablename"

macro$country

#What if you want to know how many cases are in each of the different values for country?

table(macro$country)


##You might want a quick summary of a variable. Notice that the summary you get back depends on which kind of variable you have

summary(macro$country)
summary(macro$gdp)


#When you are working with very small datasets, it may be feasible to look at your data in its entirety.

macro

#However, you can imagine that this becomes really messy when your data gets to be of a certain size. 

#One first step is just to look at the very top and very bottom of your data set

head()
tail()

#You can also look at specific subsections of your data. Within the brackets, you first identify the rows of interest, and then the columns of interest. 

macro[1,1] # a single datum
macro[1, ] #the first row of data
macro[,1] #the first column of data

macro[15:30, 1:3]


#----------------------------------------------------------------------------------------------------#
# THE WHICH, LENGTH, UNIQUE and ORDER COMMANDS
#----------------------------------------------------------------------------------------------------#


#More frequently, you are going to want to look at data not based on the row and column locations, but based on values of the data. When you are trying to do this, you are going to "call" your data, but only the data that meets certain criteria. You want to use logical statements to isolate those subsections of the data.

#In this case, we want to look at all columns for all the rows in which the year is larger than 1985

macro[which(macro$year>1985),]

#Perhaps you only want to look at a particular country

macro[which(macro$country=="Canada"),]

#or cases where unemployment is between 5 and 6 percent

macro[which(macro$unem>5 & macro$unem < 6),]

#You might also want to visualize an abbreviated table of your data

#perhaps you want to make sure that there is only one case per year
table(macro$country, macro$year)

#or perhaps you want to know how many cases (years) there are in each country when unemployment was above 4%

table(macro$country[which(macro$unem >4)])



#Another useful command is the "length" command

length(macro$country)
length(macro$country[which(macro$country=="United States")])


#The "unique" command might be useful

length(unique(macro$country))


##You might also want to visualize the data in ascending or descending order

macro[order(macro$unem),]
macro[order(macro$unem, decreasing=T),]

macro[order(macro$unem, macro$gdp),]


#----------------------------------------------------------------------------------------------------#
# CREATING, RECODING AND RENAMING VARIABLES
#----------------------------------------------------------------------------------------------------#

#let's say (for some inexplicable reason) that you wanted to create a variable that was the sum of gap and unemployment

#best practice is first to create a new variable that is full of NAs

macro$sum <- NA
macro$sum <- macro$gdp + macro$unem


#then you decide that particular variable is meaningless so you want to remove it. These commands do the same thing

macro <- macro[,-7]
macro <- macro[,1:6]


###perhaps you want to make a dummy variable for all the cases where unemployment is 8% or greater

macro$highunem <- NA
macro$highunem[which(macro$unem >= 8)] <- 1
macro$highunem[which(macro$unem < 8)] <- 0


#and then in hindsight you decide you want to rename the variable

names(macro)[7] <- c("romney.magic.number")



#----------------------------------------------------------------------------------------------------#
# SAVING, CLEANING, and CLOSING
#----------------------------------------------------------------------------------------------------#

#R does not automatically save the changes you make!!! If you make changes to your data, you need to save it. I always recommend keeping a clean copy of your original data, so before I save anything, I will make a new version of it

macro2 <- macro
save(macro2, file="/Users/jaimesettle/Desktop/macro2.rda")


###If you want to remove an object from memory, you can do this, where "obj1" is an example of what you might want to remove

rm(obj1)

##If you want to save the output of your session, you can go to the menu and hit file "save" and that will save a text file of all of the output from your working session. 



