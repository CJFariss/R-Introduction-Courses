## easyRplots.R
##########################################################################
## INSTRUCTOR: Christopher Fariss
## COURSE NAME: Human Rights
## University of Michigan, Fall 2021
##
##
## Please e-mail me if you find any errors or have and suggestions (either email is fine)
## e-mail: cjf0006@gmail.com
## e-mail: cjfariss@umich.edu
##########################################################################
## Introduction to tutorial:
##
## download R for free: https://cran.r-project.org/
## also download Rstudio for free: https://rstudio.com/ (https://rstudio.com/products/rstudio/download/#download)
##
## For this R tutorial, we will learn how:
##
##  (1) to find and change the working directory,
##  (2) how to create objects in the workspace and save those objects to the working directory
##  (3) how to load libraries with additional functions
##  (4) load data using read.csv()
##  (5) make a plot() and barplot()
##
## HINT: you only need to know getwd(), read.csv(), and plot() or barplot() to complete the R plot assignment for class 
## (see myRplot.R for more hints)
##
##########################################################################

## When you open R, you are greeted by a prompt: >
## > is called a right chevron 
## This is the character that indicates you can type in your command
## Your output will be prefaced by an index for the line number, such as [1]
## The # character is what we call the "comment" character (you can also use double backspace to comment which is like C or C++ '//'). 
## When you want to write something in your code that you don't want to run, you need to "comment it out."

## what is the current working directory?
getwd()
  
## set the working directory to another folder 
## for a Mac, it might look something like this: "/Users/CJFariss/Documents/R1"
setwd("/Users/CJFariss/Documents/R1")

## list objects in the working environment
ls() 

# remove all objects in the working environment
rm(list = ls())

## list objects in the working environment again
ls() 



##----------------------------------------------------------------------------------------------------#
## R IS JUST A FANCY CALCULATOR
##----------------------------------------------------------------------------------------------------#

## You can use all of the usual arithmetic operations: +, -, *, /, ^ . Remember your order of operations!

2+3

4^2-3*2

## In addition to common arithmetic operations, R has hundreds of other functions, 
## for everything from mathematical operations to data analysis, to making graphs

## to learn what you need to input into a function 
## type in help(function) or ?function_name, where "function_name" is the name of the function you want
## e.g., ?ls
?ls


#Notice that all of this code produces the same answer
log(100)
log(100, base=10)
log(100, 10)


##----------------------------------------------------------------------------------------------------#
## LOADING IN DATA
##----------------------------------------------------------------------------------------------------#

## Although it is very rare that you would need to do this, you can enter in data by hand. 
## There are really very few times you would need to do this, but it will be a good practice for what we want to do.

## Most of the time, you are going to want to load in data from another source. 
## This, in theory, is very easy when you are using delimited data (that is, plain text data that is separated in some way, such as white space, commas, or tabs.) 
## In practice, this means that .dat, .txt or .csv files are the easiest to load in.

## Loading in Data

## Look at the documentation for this command
?read.csv

## Notice that you need to give R some information. 
## Where do you find the file? 
## Is there a header row? 
## How are the columns separated? 
## What does missing data look like?

## There are several other read options.
## read.table # virtually identical
## read.delim # very similar to read.table
## read.fwf # when you have data with fixed width

## When you have data from other software programs, you need to install the "foreign" package

install.packages("foreign")
library(foreign)

?read.spss  #this reads in SPSS files
?read.xport  #this reads in SAS files


## You can import files straight from the Internet
macro <- read.csv("http://cfariss.com/code/macro.csv")

## or from the workin directory
macro <- read.csv("macro.csv")


## In the beginning, I found that this was one of the more frustrating aspects of learning R, but once you get the hang of it, it is less of a hassle


##----------------------------------------------------------------------------------------------------#
## GETTING A FEEL FOR YOUR DATA
##----------------------------------------------------------------------------------------------------#

## Let's take a closer look at the macro dataset.

## A good first step is to get a sense of the size and an overview of your data. 
## These are some commands--fill in the parentheses with the name of your data, in this case, "macro", i.e. names(macro)

names()
dim()
nrow()
ncol()
dim()[1]
dim()[2]

## place the object macro into the parantheses of the function
names(macro)
dim(smacro)
nrow(macro)
ncol(macro)
dim(macro)[1]
dim(macro)[2]


## Next, you might want to look at specific variables. To do this, you use the format "dataset$variablename"
macro$country


## What if you want to know how many cases are in each of the different values for country?
table(macro$country)


## You might want a quick summary of a variable. Notice that the summary you get back depends on which kind of variable you have
summary(macro$country)
summary(macro$gdp)


## When you are working with very small datasets, it may be feasible to look at your data in its entirety.
macro

## However, you can imagine that this becomes really messy when your data gets to be of a certain size.

## One first step is just to look at the very top and very bottom of your data set
head(macro)
tail(macro)

## You can also look at specific subsections of your data. 
## Within the brackets, you first identify the rows of interest, and then the columns of interest.

macro[1,1] # a single datum
macro[1, ] #the first row of data
macro[,1] #the first column of data

macro[15:30, 1:3]


#----------------------------------------------------------------------------------------------------#
# R Makes very nice graphs (this code can be adapted for your assignment)
#----------------------------------------------------------------------------------------------------#

## NOTE that you can google: "Qucik R graphical parameters" for a good resource for making graphs
## the URL is here: http://www.statmethods.net/advgraphs/parameters.html
## R color names are available here: http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

## read in data using read.csv() function
data <- read.csv("http://cfariss.com/code/ny_stop_frisk.csv")
#data <- read.csv("ny_stop_frisk.csv")

COLOR <- "lightblue"


## make a plot using the barplot() function
barplot(data$total,
    beside=T,
    space=1,
    col=COLOR, # I used the named variable defined above instead of naming here
    font=2,
    font.lab=2,
    ylab="Total Stop and Frisks",
    main="Stop and Frisks by Race in 2012",
    xpd=F,
    horiz=F,
    names.arg=data$race,
    ylim=c(0, 1.1*max(data$total)) # I made the top of the plot a little bit larger than the largest value
)

## additional plot elements
box() # add box around plot region


## read in data using read.csv() function
data <- read.csv("http://cfariss.com/code/ny_stop_frisk_black.csv")
#data <- read.csv("ny_stop_frisk_black.csv")

## make a plot using the plot() function
plot(data$total,
    type="o",
    col="navy",
    bg="lightblue",
    pch=21,
    ylim=c(0, 1.1*max(data$total)), # I made the top of the plot a little bit larger than the largest value
    xlab="Year",
    ylab="Total Stop and Frisks",
    main="Stop and Frisks for African Americans Over Time",
    xaxt="n"
)

# additional plot elements
axis(side=1, at=c(1,2,3,4,5,6,7,8,9,10), label=data$year)




