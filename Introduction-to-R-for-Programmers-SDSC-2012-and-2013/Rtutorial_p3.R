# ---------------------------------------------------- #
# ----- Introduction to R for Programmers part 3 ----- #
# ---------------------------------------------------- #
#
# INSTRUCTOR: Chris Fariss 
# Wednesday, May 23, 2012
# 
# Text book: "The Art of R Programming" by Norman Matloff
# http://nostarch.com/artofr.htm



# ---------------------------------- #
# ----- user defined functions ----- #
# ---------------------------------- #

foo <- function(a, b)
{
    return (a+b)
}

foo(1,1)

foo(1,2)



# ----------------------#
# ----- functions ----- #
# ----------------------#

# generic non-parametric boot strap function that takes THREE arguments:
# (1) a datset x, (2) integer value for the number of trials (total number of draws) and (3) draw.by.cell
# a logical argument that determines the type of bootstraping within the dataset
# the x argument that accepts a dataframe that the function then samples from
# the trials argument in the number of boot strapped datasets desired, which defaults to 10
# the draw.by.cell argument, defaults to FALSE and draws rows with replacement from the dataset

bootstrapin.boogie <- function(x, trials=10, draw.by.cell=FALSE){
  data <- x
  temp <- array(NA, dim=c(nrow(data), ncol(data), trials))

  if(draw.by.cell==FALSE){
    for(i in 1:trials){

      draws <- data[round(x=runif(nrow(data), min=1, max=nrow(data)), digits = 0), ]
 
      temp[, , i] <- array(as.matrix(draws), dim=c(nrow(data), ncol(data), 1))

    }
  }

  if(draw.by.cell==TRUE){
    for(i in 1:trials){
      for(j in 1:ncol(data)){

        draws <- data[round(x=runif(nrow(data), min=1, max=nrow(data)), digits = 0), j]
 
        temp[, j, i] <- array(as.vector(draws))
     }
    }
  }
  return(temp) 
}


# or you could just use the boot() and sample() functions

# generate one replicate column vector from the macro dataset
draws <- sample(macro$unem)

# generate 1000 replciated column vectors from the macro dataset
draws <- matrix(NA, ncol=1000, nrow=length(macro$unem))

for(i in 1:1000){
  draws[,i] <- sample(macro$unem)
}


# ---------------- #
# ----- text ----- #
# ---------------- #

# use the readLines function for very large datasets
# you can read in data a chunk at a time
tweets <- readLines("SIMpoliticalTweets.txt", n=-1)
tweets <- readLines("http://polisci2.ucsd.edu/cfariss/code/SIMpoliticalTweets.txt", n=-1)

# pattern matching with regular expressions (see Chapter 11):
grep()
grepl()
sub()
gsub()
regexpr()
gregexpr()


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
# ----- Problem 3 ----- #
# --------------------- #

# 3.
# see if you can generate a binary document-by-term matrix using the corpus of 10 tweets readin above
# hint: you will need to use a couple of functions that I have not covered, which are:
# unqiue() and strsplit()



# -------------------------------------------------------------------------------- # 
# ----- if we have time, we will look at the SIMols.R and SIMlogit.R scripts ----- #
# -------------------------------------------------------------------------------- # 

http://polisci2.ucsd.edu/cfariss/code/SIMols.R
http://polisci2.ucsd.edu/cfariss/code/SIMlogit.R
