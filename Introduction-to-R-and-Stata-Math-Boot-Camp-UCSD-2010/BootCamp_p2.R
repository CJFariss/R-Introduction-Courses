#----------------------------------------------------------------------------------------------------#
# INTRODUCTION TO R Part II
#----------------------------------------------------------------------------------------------------#
#
# Math Boot Camp, Department of Political Science, UCSD
# INSTRUCTOR: Chris Fariss and Dimitar Gueorguiev
# Tuesday, September 21, 2010
#
#
#----------------------------------------------------------------------------------------------------#



#----------------------------------------------------------------------------------------------------#
# LOAD DATA INTO AN R SESSION 
#----------------------------------------------------------------------------------------------------#


# we'll use data from Kosuke Imai, Gary King, and Olivia Lau. 2007. "Zelig: Everyone’s Statistical Software," http://GKing.harvard.edu/zelig.
# you can load the data by loading the Zelig library:
# library(Zelig)
# then using the data() function:
# data(macro)


# or just download the data and read it in using the read.csv function
# macro <- read.csv("macro.csv", header=TRUE) 

# or read it in directly from the internet
macro <- read.csv("http://polisci2.ucsd.edu/cfariss/code/macro.csv", header=TRUE)

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



#----------------------------------------------------------------------------------------------------#
# Q6: how many variables are contained in the macro dataset ?
#----------------------------------------------------------------------------------------------------#


#----------------------------------------------------------------------------------------------------#
# Q7: how many units/observations/records are contained in the macro dataset?
#----------------------------------------------------------------------------------------------------#



# look at the unemployment variable called unem that exists in the macro dataset 
macro$unem


# calculate the mean and standard deviation for each variable in the data set

sum(macro$unem)/length(macro$unem)
sqrt(sum((macro$unem-mean(macro$unem))^2)/(length(macro$unem)-1))

mean(macro$unem)
sd(macro$unem)

summary(macro)

# generate plots of the distribution of the trade variable
hist(macro$trade, col=grey(.5), xlab="Trade", ylab="Frequency", main="Distribution of Trade")
plot(density(macro$trade), col=2, lwd=3, xlab="Trade", ylab="Density", main="Distribution of Trade")

#----------------------------------------------------------------------------------------------------#
# Q8: What is the function of the following graphical parameters: 
# col, ylab, xlab, main, lwd, xlim, ylim, cex
#----------------------------------------------------------------------------------------------------#



#----------------------------------------------------------------------------------------------------#
#  SUBSET IS A HANDY COMMAND! 
#----------------------------------------------------------------------------------------------------#

# reference the subset command 
?subset

# select the numeric variables (columns) from the full macro data set
macro.variables <- subset(macro, select=c(gdp, unem, capmob, trade))
dim(macro.variables)
summary(macro.variables)

# select only the observations (rows) that occured in the year 1990 from the full data set
macro.1990 <- subset(macro, year==1990)
dim(macro.1990)
summary(macro.1990)

# select the numeric variables (columns) AND the observations (rows) that occured in the year 1990 from the full macro data set
macro.variables.1990 <- subset(macro,  year==1990, select=c(gdp, unem, capmob, trade))
dim(macro.variables.1990)
summary(macro.variables.1990)

                               
# calculate correlation coefficients for each pair of variables in the macro.variables dataset

cor(macro)

cor(macro.variables)

#----------------------------------------------------------------------------------------------------#
# Q8: Why does the cor(macro) command return an error while the cor(macro.variables) does not?
#----------------------------------------------------------------------------------------------------#


cor(macro.variables$unem, macro.variables$trade)

cor.test(macro.variables$unem, macro.variables$trade)

#----------------------------------------------------------------------------------------------------#
# Q9: Which variables have the highest correlation coefficient?  Interpret this in words.
# What is the 95% confidence interval around this correlation coefficient?
#----------------------------------------------------------------------------------------------------#



#----------------------------------------------------------------------------------------------------#
# LOOP THROUGH A DATASET AND USE AN IF STATEMENT
#----------------------------------------------------------------------------------------------------#

# add in a new variable that will measure years in which the US was engaged in the Vietnam War
# set all values to 0 and then change values to 1 using the loop and if statements below
macro$us_conflict <- 0

# visually inspect the new variable
macro$us_conflict

# check the data set and new variable before running the loop
head(macro, n=25)
summary(macro, n=25)

i <- 1

while(i <= nrow(macro)){

if(macro$year[i] <=1975){
macro$us_conflict[i] <- 1
}

i <- i + 1
}


# check the data set and new variable after running the loop
head(macro, n=25)
summary(macro, n=25)

# visually inspect the modified variable
macro$us_conflict



#----------------------------------------------------------------------------------------------------#
# Q10: create a loop that creates a dummy variable for the years when 
# Ronald Regan was president 1981-1989
# HINT: Use an & statement to add a second condition within the if statement
#----------------------------------------------------------------------------------------------------#





#----------------------------------------------------------------------------------------------------#
# ESTIMATE A SIMPLE LINEAR MODEL: BIVARIATE REGRESSION
#----------------------------------------------------------------------------------------------------#

# linear algrebra for the linear model 
# for more information on the syntax for matrix 
#algebra in R see http://www.statmethods.net/advstats/matrix.html

X <- cbind(rep(1, 350), macro$trade)
Y <- macro$unem

model.01 <- solve(t(X)%*%X) %*% (t(X)%*%Y)

model.01

# linear model function lm()
model.01 <- lm(macro$unem ~ macro$trade)

model.01

model.01 <- lm(unem ~ trade, data = macro)

model.01

summary(model.01)

#----------------------------------------------------------------------------------------------------#
# ESTIMATE A SIMPLE LINEAR MODEL: MULTIPLE REGRESSION
#----------------------------------------------------------------------------------------------------#

model.01 <- lm(unem ~ gdp + capmob + trade, data = macro)

model.01

summary(model.01)



#----------------------------------------------------------------------------------------------------#
# ESTIMATE SUBSTANTIVE EFFECTS/QUANTITIES OF INTEREST 
# USING THE MODEL ESTIMATES
#----------------------------------------------------------------------------------------------------#

# generate a sequence from the lowest value of the trade variable to the highest value
e <- seq(from=min(macro$trade), to=max(macro$trade), by=1)

# visually inspect the sequence e
e

# create a new data set that is the length of the sequence created above that contains the variables gdp, unem, capmob, trade 
new.macro <- macro[1:length(e), 3:6]

# loop through the new data set and change the values of the four variables
for(i in 1:length(e)){

# change unem to NA (i.e., missing).  this is the y variable that will be predicted below using the model estimates contained in the model.01 object
new.macro$unem[i] <- NA

# change every value of the variable gdp and capmob to the mean value of these variables from the original data
new.macro$gdp[i] <- mean(macro$gdp)
new.macro$capmob[i] <- mean(macro$capmob)

# change each value of trade to the values in the sequence e
new.macro$trade[i] <- e[i]


}

# see the syntax to predict
?predict

# predict the value unem in the new.macro data object using the coefficients contained in the model.01 object
predict.model.01 <- predict.lm(model.01, new.macro, se.fit=TRUE)

# view the values contained in the new prediction object
predict.model.01

# view the predicted values only
predict.model.01$fit


#----------------------------------------------------------------------------------------------------#
# PLOT THE SUBSTANTIVE EFFECTS/QUANTITIES OF INTEREST
#----------------------------------------------------------------------------------------------------#

plot(e, predict.model.01$fit, type="n", ylim=c(0,max(macro$unem)), ylab="Predicted Value of Unemployment", xlab="Amount of Trade", main="SWANKY TITLE HERE")

lines(e, predict.model.01$fit, lty=1, lwd=3, col=1)
lines(e, predict.model.01$fit-1.96*predict.model.01$se.fit, lty=2, lwd=3, col=2)
lines(e, predict.model.01$fit+1.96*predict.model.01$se.fit, lty=2, lwd=3, col=2)


#----------------------------------------------------------------------------------------------------#
# Q11: Estimate the value of Unemployment when trade and capmob are at
# their means and gdp varies from its min to its max and plot the relationship
#----------------------------------------------------------------------------------------------------#





