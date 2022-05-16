# ---------------------------------------------------------------------- #
# ----- Introduction to R and statistical analysis of data using R ----- #
# ---------------------------------------------------------------------- #
#
# INSTRUCTOR: Chris Fariss 
# Tuesday, July 9, 2013
# 
# Some of the material is adapted from:
# "The Art of R Programming" by Norman Matloff
# http://nostarch.com/artofr.htm
#
# Modified versions of this material exist in several 
# forms in the teaching section of on my website here:
# http://polisci2.ucsd.edu/cfariss/Home/Christopher_J_Fariss.html
#
# Please e-mail me if you find any errors or have and suggestions!
# e-mail: cjf0006@gmail.com
# 
# ---------------------------------------------------------------------- #
#
# Distributed for free under the following license:
# Creative Commons Attribution-Noncommercial-Share Alike 3.0 U.S. License.
#
# ---------------------------------------------------------------------- #
#
# Course Notes: 
#
# Optional slides are available here:
# http://polisci2.ucsd.edu/cfariss/documents/Introduction_R_for_Programmers.pdf
#
# There are 4 optional problems found throughout the text below.
#
# Additional online resources are listed at the end of this file and throughout it. 
#
# ---------------------------------------------------------------------- #


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


# ---------------------------- #
# ---- read in data to R ----- #
# ---------------------------- #

# Note: see Chapter 10 (Input/Output) for more information on the material below

# lots of ways to load different data formats:
#?load
#?read.csv
#?read.table
#?read.delim
#?read.dta
#?read.spss
#?readline

# In this part of the code we'll use data from Kosuke Imai, Gary King, and Olivia Lau. 2007. "Zelig: Everyoneâ€™s Statistical Software," http://GKing.harvard.edu/zelig.
# you can load the data by loading the Zelig library:
# library(Zelig)
# then using the data() function:
# data(macro)

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



# ------------------------------ #
# ----- the apply function ----- #
# ------------------------------ #

#apply()  # for matrices
#lapply() # for lists
#sapply() # for lists without all the list formatting
#tapply() # for tables

# compute row and column sums for a matrix (adapated from R help documentation)
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
dimnames(x)[[1]] <- letters[1:8]

col.sums <- apply(x, 2, sum)
row.sums <- apply(x, 1, sum)

rbind(cbind(x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))



# ------------------------------------------ #
# ----- compare loops to vectorization ----- #
# ------------------------------------------ #

# declare variables 

# to raise the number of simulations
power <- c(2,3,4) 

# calculate the time taken for each operation
simple.time <- NA
apply.time <- NA
loop.time <- NA

# loop through each operation and store the time taken in the variables declared above
for(i in 1:length(power)){
  # print what power the loop is at
  print(power[i])  

  # set the number of draws to take
  n <- 10^power[i]

  # generate 5 0,1 vectors of length n
  v1 <- rbinom(n, 1, 0.5)
  v2 <- rbinom(n, 1, 0.5)
  v3 <- rbinom(n, 1, 0.5)
  v4 <- rbinom(n, 1, 0.5)
  v5 <- rbinom(n, 1, 0.5)

  # column bind the vectors together
  v <- cbind(v1, v2, v3, v4, v5)

  # declare a vector that uses one of the sequence function to store numbers from 1 until n
  j <- 1:n

  # create a variable to store the output
  out <- NA
  d1 <- Sys.time()
  out[j] <- v[j,1]+v[j,2]+v[j,3]+v[j,4]+v[j,5]
  d2 <- Sys.time()
  simple.time[i] <- d2-d1

  # print the summary while the loop is running to compare the output
  # and make sure each procedure is generating the same answer
  print(summary(out))

  # same as above but use the apply function
  d1 <- Sys.time()
  apply.out <- apply(v, MARGIN=1, FUN=sum)
  d2 <- Sys.time()
  apply.time[i] <- as.list(d2-d1)

  print(summary(apply.out))


  # same as above but use a for loop
  d1 <- Sys.time()
  loop.out <- NA
  for(k in 1:n){
      loop.out[j] <- sum(v[k,])    
  }
  d2 <- Sys.time()
  loop.time[i] <- d2-d1
  print(summary(loop.out))

}


cbind(power, simple.time, apply.time, loop.time)




# ---------------------------------------------- #
# ----- distributions and random variables ----- #
# ---------------------------------------------- #

# draw random values from many distributions
rnorm
rbinom
rgamma
rpoison
rpois

# you can also calculate densities, cumulative densities/probabilites and the quantile at a given density
# by changing the first letter in the function above from r to d, p or q respectively 

# Examples:

# the highest point of the density is at the mean
dnorm(0, mean=0, sd=1)
dnorm(0, mean=1, sd=1)
dnorm(1, mean=1, sd=1)

# the cumulative probability 1.96 standard deviations above the mean
pnorm(1.96)

# the number of standard deviations above the mean at a given probability
qnorm(.975)

# the mean value of a 1000 draws from a normal distribution with mean 0 and standard deviation 1
mean(rnorm(1000,0,1))

# more summary statistics
summary(rnorm(1000,0,1))




# slower alternative
d1 <- Sys.time()
sum <- 0 
nreps <- 100000 

for (i in 1:nreps) { 
  xy <- rnorm(2) # generate 2 N(0,1)s 
  sum <- sum + max(xy) 
} 
print(sum/nreps) 

d2 <- Sys.time()
d2-d1

# faster alternative 
d1 <- Sys.time()
nreps <- 100000 

xymat <- matrix(rnorm(2*nreps),ncol=2) 
maxs <- pmax(xymat[,1],xymat[,2]) 

print(mean(maxs)) 

d2 <- Sys.time()
d2-d1


# some other useful functions

#seq()
#rep()
#sort()
#order()
#aggregate()
#duplicated()

# --------------------- #
# ----- Problem 2 ----- #
# --------------------- #

# 2.
# simulate values from a normal distribution (or any one of the other distributions you prefer) as a function
# of the index values from the object you store the draws in. For a matrix make the values in each cell a function
# of that cell's first and second dimension. This should be straightforward using 2 for loops. Start with a vector
# and one for loop if you're still getting used to loops and the idea of nesting them. Once your loops are working
# try to re-create the same matrix or vector without using loops or using one less loop if you are using a matrix.
# If you are feeling really ambitious try this with a 3 dimensional array. 


# ---------------------------------- #
# ----- user defined functions ----- #
# ---------------------------------- #

foo <- function(a, b)
{
    return (a+b)
}

foo(1,1)

foo(1,2)



# ----------------------------------- #
# ----- Linear Model Simulation ----- #
# ----------------------------------- #

# set number of observations
n <- 100

# generate simulated vales
x <- rnorm(n,0,1) 

# select true population parameters
alpha <- 1.25 
beta <- 2.5


# generate y with error 
y <- alpha + beta * x + rnorm(n)

# fit linear model
model <- lm(y ~ x) 

# use the summary() function to display summary results from linaer model
summary(model)


# --------------------------------------- #
# ----- Large Scale GLM Simulations ----- #
# --------------------------------------- #

# declare number of simulations to run
SIMS <- 1e+03

# declare empty list to save data frames 
data.list <- list()

# declare empty vectors to save population level parameters
alpha <- NA
beta <- NA

# use a for loop to simulate data
for(i in 1:SIMS){
	x <- rnorm(n,0,1) 

	alpha[i] <- runif(1,0,1)
	beta[i] <- rnorm(1,0,1)
	
	# systematic component of the model
	xb <-  alpha[i] + beta[i] * x

	# transform the linear term xb using the logit function so that theta is bound from 0 to 1
	theta <-  1 / (1 + exp(-xb))

	# generate the dependent variable y with theta and measurment error
	error <- runif(n,0,1)
	y <- ifelse(error < theta,1,0)

	data.list[[i]] <- data.frame(cbind(y,x)) 
}


# use a for loop to run all SIMS linear models on the data.list object

TIME <- Sys.time() # store start time
for(i in 1:SIMS){
	out <- glm(y~x, data=data.list[[i]], binomial(link = "logit"))
}
print(Sys.time() - TIME) # subtract end time from start time
 

# use the list apply function to apply the lm() function on each of the data frames contained in the list object 
TIME <- Sys.time()
out <- lapply(data.list, glm, binomial(link = "logit"))
print(Sys.time() - TIME)


# use the simple apply function to extract the coefficients from the out list object made in the previous step
vec <- sapply(out, coefficients)

# the vec object is a vector transform the vector into a 2 column matrix, where the first column contains the alpha estimates and the second column contains the beta estimates 
mat <- matrix(vec,ncol=2,byrow=T)


# make a nice plot of the estimates vs. the true value
par(mar=c(4,4,1,1))
plot(beta, mat[,2], pch=21, col=1, bg=grey(.85), xlim=c(-4.5,4.5), ylim=c(-4.5,4.5), xlab="true beta", ylab="estimated beta")
abline(a=0,b=1,col=2,lwd=2)

# make a nice plot of the estimates vs. the true value
par(mar=c(4,4,1,1))
plot(alpha, mat[,1], pch=21, col=1, bg=grey(.85), xlim=c(-.2,1.2), ylim=c(-.2,1.2), xlab="true alpha", ylab="estimated alpha")
abline(a=0,b=1,col=2,lwd=2)


# --------------------- #
# ----- Problem 3 ----- #
# --------------------- #

# 3a.
# Simulate a new y variable using one of the other exponential family functions.
# Next use the glm function to fit the model. Compare the fit to the fit using a linear model.  
# An example of this can be found here:
# http://polisci2.ucsd.edu/cfariss/code/SIMPoisson01.R
#
# 3b.
# Notice that the alpha parameter was drawn from uniform distribution with support 0 to 1.
# How might you model that restriction? Consider writing your own function to accomplish this part?
# You may need to use the optim function, examples for which can be found here:
# http://polisci2.ucsd.edu/cfariss/code/SIMols.R
# or here:
# http://polisci2.ucsd.edu/cfariss/code/SIMlogit.R
# You could also run a Bayesian model, examples of which are in the "R Code to Implement JAGS Models" section here:
# http://polisci2.ucsd.edu/cfariss/HumanRightsScores/Code.html



# ----------------------------------------------------- #
# ----- working with text and regular expressions ----- #
# ----------------------------------------------------- #

# use the readLines function for very large datasets
# you can read in data a chunk at a time
tweets <- readLines("SIMpoliticalTweets.txt", n=-1)
tweets <- readLines("http://polisci2.ucsd.edu/cfariss/code/SIMpoliticalTweets.txt", n=-1)

# pattern matching with regular expressions (see Chapter 11):
?grep()
# grepl()
# sub()
# gsub()
# regexpr()
# gregexpr()


as.numeric(grepl("obama", tweets))

# create binary vectors where 1 indicates if the term was present in the tweet and 0 otherwise 
obama <- as.numeric(grepl("obama", tweets))
love <- as.numeric(grepl("love", tweets))
hate <- as.numeric(grepl("hate", tweets))

# look at the output as columns
cbind(obama,love,hate)

# create a data frame
tweet.data <- as.data.frame(cbind(obama,love,hate))
tweet.data

# write the data frame as a csv file
write.csv(tweet.data, "tweetdata.csv")

# save the tweet data as an R object
save(tweet.data, file="tweetdata")

rm(tweet.data)
tweet.data

load(file="tweetdata")
tweet.data


# -------------------------------- #
# --- tables are useful too! ----- #
# -------------------------------- #
table(obama,love)
table(obama,hate)



# --------------------- #
# ----- Problem 4 ----- #
# --------------------- #

# 4.
# see if you can generate a binary document-by-term matrix using the corpus of 10 tweets readin above
# hint: you will need to use a couple of functions that I have not covered, which are:
# unqiue() and strsplit()



# -------------------------------------------------------------------------------- # 
# ----- if we have time, we will look at the SIMols.R and SIMlogit.R scripts ----- #
# -------------------------------------------------------------------------------- # 

# http://polisci2.ucsd.edu/cfariss/code/SIMols.R
# http://polisci2.ucsd.edu/cfariss/code/SIMlogit.R



# ------------------------------------------------------------- # 
# ----- there are many more useful R scripts here as well ----- #
# ------------------------------------------------------------- # 
 
# http://polisci2.ucsd.edu/cfariss/HumanRightsScores/Code.html


#------------------------------------------------- #
# ---- STATISTICAL COMPUTING RESOURCES FOR R ----- #
#------------------------------------------------- #

# Quick-R for SAS/SPSS/Stata Users 
# http://www.statmethods.net

# UCLA Statistical Computing (R and Stata)
# http://www.ats.ucla.edu/stat/
 
# R Seek (Search for R code)
# http://www.rseek.org/

# R Graph Gallery
# http://addictedtor.free.fr/graphiques/allgraph.php

# Simple R Plots
# http://www.phaget4.org/R/plot.html

# Zelig (its a sweet package by none other than Gary King and friends
# http://gking.harvard.edu/zelig/docs/

#----------------------- #
# ---- END OF FILE ----- #
#----------------------- #
