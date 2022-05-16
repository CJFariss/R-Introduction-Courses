# ---------------------------------------------------- #
# ----- Introduction to R for Programmers part 1 ----- #
# ---------------------------------------------------- #
#
# INSTRUCTOR: Chris Fariss 
# Wednesday, May 23, 2012
# 
# Text book: "The Art of R Programming" by Norman Matloff
# http://nostarch.com/artofr.htm
#
# --------------------------- #
# ----- Getting Started ----- #
# --------------------------- #

# Note: see Chapter 1 for more information on the material below

# what is the current working directory?
getwd()

# set the working directory to an object using the assignment operator <- or = (more on this later) 
wd <- getwd()

# set the working directory to another folder (actually the same folder in this example)
setwd(wd) 

# list objects in the working environment
ls() 

# remove all objects in the working environment
rm(list = ls())

# list objects in the working environment again
ls() 

# getting help

# if you remember the function name use  a single question mark
?rm

# if you cannot remember the function name but remember something close try the double question mark
??remove

# OR you can use the help.search function with quotes for the words inside
# this function is especially useful if you want to search for more than one word
help.search("remove")

# you can also try google, Rseek or Quick R for help:
# R Seek (Search for R code)
# http://www.rseek.org/
#
# Quick-R for SAS/SPSS/Stata Users 
# http://www.statmethods.net

 

# ------------------------------ #
# ----- naming conventions ----- #
# ------------------------------ #

# R uses $ in a manner analogous to the way other languages use dot.
# we will look at the use of $ in more detail later
# R used dot in a similar way to the underscore
# the underscore character was once the assignment character in S (R's predecessor)
# you can use the underscore character now but more often dot is used instead
# I go back and forth between both


# create an object and assign a scalar to it (it's really just a vector with one element)
obj1 <- 3

# display the value of the object
obj1

# redefine obj1
4 -> obj1
obj1

obj1 = 2
obj1

# use an object in a calculation
obj1+2
obj1*2
obj1^2

# remove just obj1 from memory
rm(obj1)

# removing objects is often not necessary but memory managment is sometimes important if your
# code is making new objects from old ones instead of overwriting old objects.
# I had to learn this the hard way. 


# ------------------- #
# ----- vectors ----- #
# ------------------- #

# Note: see Chapter 2 (Vectors) for more information on the material below

# create some vectors of length > 1
a <- c(1,2,5.3,6,-2,4) # numeric vector
a
b <- c("one","two","three") # character vector
b
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector
c

# ------------------------ #
# ----- vector types ----- #
# ------------------------ #

# numeric (double is the same as numeric)
d <- c("1", "2", "3")
d

# you can covert at object with as.TYPE
# as. numeric changes the character vector created above to numeric
as.numeric(d)

# this conversion doesn't always work though
as.numeric(b)

# but it can work if we change b to a factor first then numeric
as.numeric(as.factor(b))

# character
as.character(a)

# integer
as.integer(1.2)

# the integer doesn't get used often in my experience. The R documentation suggests that is
# useful for passing integers to C or Fortran code


# ---------------------- #
# ----- subscripts ----- #
# ---------------------- #

# use subscript to get one element from a vector
a[1]
a[3]

# use a negative subscript to get all but that element from a vector
a[-1]

# use a vector of subscripts to get multiple elements from a vector
a[c(1,2)]

# ------------------------------ #
# ----- packages/libraries ----- #
# ------------------------------ #

# library(LIBRARY) loads a previously installed library
# install.packages("LIBRARY")

# the following functions are contained in the base library which automaticall loads with R

# column bind
cbind()

# row bind  
rbind()

a <- c(1,2,5.3,6,-2,4) # numeric vector

cbind(a,a)

rbind(a,a)

# to use the special version of row binds that combines dataframes based on column names
# you must first load the gtools library
library(gtools)
smartbind()

# the following code is adapated from the smartbind documentation
df1 <- data.frame(A=1:10, B=LETTERS[1:10], C=rnorm(10) )
df2 <- data.frame(A=11:20, D=rnorm(10), E=letters[1:10] )

# rbind would fail
rbind(df1, df2)

# but smartbind combines them, appropriately creating NA entries
smartbind(df1, df2)



# ----------------- #
# ----- lists ----- #
# ----------------- #

# Note: see Chapter 4 (Lists) for more information on the material below

# a simple list, with 3 elements:
# (1) a named character
# (2) an unamed scalar
# (3) a named vector
l1 <- list(name="list1", 3, values=c(3,8,9))
l1

# list of lists
l2 <- list(name="list2", values=list(c(1,2,3), c(4,5,6), c(7,8,9,10,11,12)), 24)
l2

# indexing lists
l2[[1]]

l2[[2]][1]

l2[[2]][2]


# lists to the extreme: triple lists
l3 <- list(name="list3", list(list(c(1,2,3), c(4,5,6), c(7,8,9)), list(c(1,2,3), c(4,5,6), c(7,8,9))))

# the unlist function creates a vector of all the elements from the list obect
unlist(l3)

unlist(l3[[2]])


# -------------------- #
# ----- matrices ----- #
# -------------------- #

# Note: see Chapter 3 (Matrices and Arrays) for more information on the material below

# 2D arrays
m <- matrix( c(1,2,3,4,5,6), nrow=2, ncol=3)
m

m <- matrix( c(1,2,3,4,5,6), nrow=2, ncol=3, byrow = TRUE)

# 2D arrays using the array function
m <- array( c(1,2,3,4,5,6), dim=c(2,3))
m

m <- array( c(1,2,3,4,5,6), dim=c(2,3), byrow = TRUE)
m

# arrays with more than 3 dimensions
m3 <- array( c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18), dim=c(2,3,3))
m3

# covert the array back into a vector
c(m3)


# --------------------------- #
# ----- loops in review ----- #
# --------------------------- #

# Note: see Chapter 7 (Control Structures) for more information on the material below

# while loop
i <- 0
i

while(i <= 10){
  i <- i + 1
}

i

# for loop
count <- 0
for(i in 1:10){
  count <- count + 1
}
count
i


# -------------------- #
# ---- read data ----- #
# -------------------- #

# Note: see Chapter 10 (Input/Output) for more information on the material below

# lots of ways to load different data formats:
#?load
#?read.csv
#?read.table
#?read.delim
#?read.dta
#?read.spss
#?readline


# read data from the current working directory
macro <- read.csv("macro.csv", header=TRUE) 

# or read it in directly from the internet
macro <- read.csv("http://polisci2.ucsd.edu/cfariss/code/macro.csv", header=TRUE)


# Note: see Chapter 5 (Dataframes) for more information on the material below

# list the variables in mydata
names(macro)

# dimensions of an object
dim(macro) 

# other commands to look at the dimensions of an object
nrow(macro)

ncol(macro)

dim(macro)[1]

dim(macro)[2]


# look at the first 6 rows in the data set
head(macro)

# look at the first 10 rows in the data set
head(macro, n=10)

# look at the last 6 rows in the data set
tail(macro)


# alternative syntax to look at rows in a data set
macro[1:10,]

macro[1:10, 1:2]

# return summary statistics from a dataframe
summary(macro)

# return the mean of one of the variable from the dataset   
mean(macro$gdp)


# ---------------------------------- #
# ----- additional R functions ----- #
# ---------------------------------- #

# Note: see Chapter 8 (Math) for more information on the material below

# Exponential function, base e 
#exp()

# Natural logarithm
#log()

# Logarithm base 10 
#log10()

# Square root
#sqrt()

# Absolute value
#abs()

# Trig functions
#sin(); cos()

# Minimum value and maximum value within a vector 
#min(); max()

# Index of the minimal element and maximal element of a vector
#which.min(); which.max()

# Element-wise minima and maxima of several vectors
#pmin(); pmax()

# Sum and product of the elements of a vector
#sum(); prod()

# Cumulative sum and product of the elements of a vector
#cumsum(); cumprod()

# Round to the closest integer, to the closest integer below, and to the closest integer above
#round(); floor(); ceiling()

# Factorial function
#factorial()  


# --------------------- #
# ----- Problem 1 ----- #
# --------------------- #

# 1a.
# use a for loop to go through the data frame and generate a new variable that is a function
# of at least 2 existing variables using one of the mathmatical functions above

# 1b.
# If 1a seems to easy then tryout the subset command on the macro dataframe. See if you can make a random
# subset of half of the records from that file. Then, if there's time, run a linear model using the lm()
# function. Then use the predict function to see how well the model fits to the out of sample data (the data not randomly selected).
# All of these functions are discussed in more detail here: http://polisci2.ucsd.edu/cfariss/code/BootCamp_p2.R
