# ---------------------------------------------------- #
# ----- Introduction to R for Programmers part 2 ----- #
# ---------------------------------------------------- #
#
# INSTRUCTOR: Chris Fariss 
# Wednesday, May 23, 2012
# 
# Text book: "The Art of R Programming" by Norman Matloff
# http://nostarch.com/artofr.htm
#
# ----------------- #
# ----- apply ----- #
# ----------------- #

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





