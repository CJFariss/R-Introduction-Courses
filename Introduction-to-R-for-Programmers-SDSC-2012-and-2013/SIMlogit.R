# SIMlogit.R 

# One variable simulation of a binary dependent variable y and one independent variable x
# using (1) a user defined numerical function, (2) a user defined function optimized with the
# optim function in R, (3) the generalized linear model function glm in R, (4) a Gibbs sampler

#install.packages("graphics")
library(graphics)

# simulate x1 and set the "true" population values alpha and beta
n <- 100
x1 <- rnorm(n,0,1)
alpha <- 1.250000
beta <- 2.500000

# systematic component of the model
xb <-  alpha + beta * x1

# transform the linear term xb using the logit function so that theta is bound from 0 to 1
theta <-  1 / (1 + exp(-xb))

# generate the dependent variable y with theta and measurment error
#error <- runif(n,0,1)
#y <- ifelse(error < theta,1,0)
y <- rbinom(n, size=1, prob=theta)

# column bind all x variables (there is only one x in this version of the simulation)
x <- cbind(x1)

# generate the number of k variables in the regression
k <- ncol(x) 

# column bind the x variables to a vector of 1s to form the X-variable matrix
X <- cbind(1, x)

# create a likelihood-matrix of possible values for beta0 and beta1 as the corrdinates within that matrix
b0 <- seq(-5, 5, 0.1)  # these sequences should technically range from -Inf to Inf
b1 <- seq(-5, 5, 0.1)  # but we know that the parameter values that maximize the likelihood lie within their range
likelihood <- matrix(NA, nrow=length(b0), ncol=length(b1))

# fill in the values of the matrix using the coordiates in b0 and b1 as possible parameter values that will maximize the likelihood
for(i in 1:length(b0)){
  for(j in 1:length(b1)){ 
    betas <- rbind(b0[i], b1[j])
    mu <- X %*% betas
    likelihood[i,j] <- -sum(log(1 + (exp((1-(2*y))*mu))))
  }
}

# print the maximum value from the matrix, which should approximate the maximum likelihood estimate
max(likelihood)

# determine the coordinates of the maximum value within the matrix
# these coordiates are also the parameters estimates for the values of alpha and beta that maximize the likelihood function
coordinates <- NA
for(i in 1:length(b0)){
  for(j in 1:length(b1)){
    if(max(likelihood)==likelihood[i,j]){
      coordinates <- c(i,j)
    }
  }
}

# find the coordinates from the matrix where the likelihood resides
max(likelihood) == likelihood[coordinates[1], coordinates[2]]

# the coordinates of the likelihood matrix are the parameters alpha and beta that maximize the likelihood function
par <- c(b0[coordinates[1]], b1[coordinates[2]])

# print the maximum likelihood estimates
par

# a faster alternative for finding the maximum value within the matrix
coordinates <- which(max(likelihood)==likelihood, arr.ind = TRUE)
par <- c(b0[coordinates[1]], b1[coordinates[2]])
par


# use the optim function R for faster and more precise results

# create a function that is passed to the optim function below
# par is the initial parameter values that optim starts with to maximize the function
# X is the matrix of covariates with a column of 1s, y is the observed dependent variable
# out the value of the log likelihood function that is returned by the function
logit.ll <- function(par, X, y){
 betas <- par[1:ncol(X)]
 mu <- X %*% betas
 out <- -sum(log(1 + (exp((1-(2*y))*mu))))
 return(out)
}

# pass the user defind function to optim with 0s as starting values for each parameter estimate
optim.out <- optim(par = rep(0,ncol(X)), logit.ll, y = y, X = X, method="BFGS", control=list(fnscale = -1), hessian = TRUE)

se <- sqrt(diag(solve(-optim.out$hessian))) #calculate standard errors
VCV <- solve(-optim.out$hessian) #compute variance-covariance matrix

# print the maximum likelihood, parameter estimates and standard errors of the parameter estimates
optim.out$value
optim.out$par
se

# check the values using the glm function
model <- glm(y ~ x1, binomial(link = "logit"))
logLik(model)
summary(model)$coefficients

# plot the likelihood function in space 
# 3D plot
persp(b0, b1,  likelihood, theta = 45, phi = 30, shade=NA, col=5)

# 2D plots
par(mfrow=c(1,2))
plot(b0, likelihood[,coordinates[2]], type="l", ylim=c(min(likelihood), max(likelihood)), lwd=3, col=4, xlab="alpha", ylab="Likelihood Function")
points(b0[coordinates[1]], likelihood[coordinates[1],coordinates[2]], col=2, pch=19)

plot(b1, likelihood[coordinates[1],], type="l", ylim=c(min(likelihood), max(likelihood)), lwd=3, col=4, xlab="beta", ylab="Likelihood Function")
points(b1[coordinates[2]], likelihood[coordinates[1],coordinates[2]], col=2, pch=19)

# reset the plot window
par(mfrow=c(1,1))



# the code below is modeified from
# http://people.musc.edu/~brn200/r/index_old.html

# this code works but isn't quite right yet

# Number of parms
k<-2

# Prior Mean for Beta
beta0<-c(0,0)

# Prior Cov of Beta (vague)
vbeta0<-diag(10,2)

# Initial Values
fit<-glm(y~x,family=binomial(link=probit))
Beta<-rep(0,k)

# Create vectors to store results
# Number of Iterations of Gibbs Sampler
nsim<-1000

# linear component Variable
z<-rep(0,n)

# Store Results
Betamat<-matrix(0,nrow=nsim,ncol=k)

# priors
prec0<-solve(vbeta0)
vbeta<-solve(prec0+crossprod(X,X))

for (i in 2:nsim) {
    
    # Draw linear component, z, from its full conditional, given y
    muz<-X%*%Beta			# Update Mean of Z
    
    z[y==0]<-qnorm(runif(n,0,pnorm(0,muz,1)),muz,1)[y==0]  # using inverse-CDF method
    z[y==1]<-qnorm(runif(n,pnorm(0,muz,1),1),muz,1)[y==1]
    
    mbeta <- vbeta%*%(prec0%*%beta0+crossprod(X,z))
    Betamat[i,]<-Beta<-c(rmvnorm(1,mbeta,vbeta))
    
    i#f (i%%100==0) print(i)
}

# plots
par(mfrow=c(1,2))
plot(1:nsim,Betamat[,1], type="l", col="lightgreen", ylim=c(0,2.25))
abline(h=mean(Betamat[501:nsim,1]),col="blue4")
plot(1:nsim,Betamat[,2], type="l", col="lightgreen", ylim=c(0,2.25))
abline(h=mean(Betamat[501:nsim,2]),col="blue4")


