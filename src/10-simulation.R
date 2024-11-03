## ----setup--------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(knitr)
library(reticulate)
venv_paths <- read.csv("venv_paths.csv")
id <- match(Sys.info()["nodename"], venv_paths$nodename)
use_virtualenv(venv_paths$path[id])


## ----r-rng-1------------------------------------------------------------------------------------
#| fig-align: center
#R 
set.seed(2137)

opar <- par(mfrow=c(1,3))
Y <- rgamma(50, 2, 3)
hist(Y)

W <- rpois(50, 1.3) # 50 obs from Pois(1.3)
barplot(table(W))

Z <- rbinom(50, size=2, 0.3) # 50 obs from Binom(2, 0.3)
barplot(table(Z))

par(opar)



## #Python
## import numpy as np
## import pandas as pd
## from scipy.stats import binom, gamma, norm, poisson
## from scipy import stats
## import matplotlib.pyplot as plt
## 
## rng = np.random.default_rng(2137)
## fig, ax = plt.subplots(1, 3, figsize=(8,4))
## 
## ax1 = plt.subplot(131)
## r = gamma.rvs(2, 3, size=50, random_state=rng)
## ax1.hist(r);
## 
## ax1 = plt.subplot(132)
## r = poisson.rvs(1.3, size=50, random_state=rng)
## ax1.hist(r);
## 
## ax1 = plt.subplot(133)
## r = binom.rvs(2, 0.3, size=50, random_state=rng)
## ax1.hist(r);

## ----r-mc-1-------------------------------------------------------------------------------------
set.seed(2138)
X <- runif(50000, 0, 1)
hX <- exp(2*X)
(mc_est <- mean(hX))


## from scipy.stats import uniform
## 
## X = uniform.rvs(0,1, size=50000, random_state=rng)
## hX = np.exp(2*X)
## hX.mean()

## ----r-ci-95------------------------------------------------------------------------------------
# R 
set.seed(2139)
output_vec <- rep(0, length=100)
n <- 20
lambda <- 0.5
for(i in 1:length(output_vec)) {
  X <- rpois(15, .5)
  Xbar <- mean(X)
  s <- sd(X)
  t <- qt(0.975, n-1)
  CI <- c(Xbar - t*s/sqrt(n), Xbar + t*s/sqrt(n))
  if(CI[1] < lambda & CI[2] > lambda) {
    output_vec[i] <- 1
  }
}
mean(output_vec)


## rng = np.random.default_rng(2137)
## output_vec = np.zeros(100)
## n = 20
## lambda_ = 0.5
## for i in range(100):
##     X = poisson.rvs(0.5, size=15, random_state=rng)
##     Xbar = X.mean()
##     s = X.std()
##     t = norm.ppf(0.975)
##     CI = [Xbar - t*s/np.sqrt(n), Xbar + t*s/np.sqrt(n)]
##     if CI[0] < lambda_ and CI[1] > lambda_:
##         output_vec[i] = 1
## output_vec.mean()
## 

## ----r-test-1-----------------------------------------------------------------------------------
generate_one_test <- function(n=100) {
  X <- rnorm(n)
  Y <- rnorm(n)
  t_test <- t.test(X, Y,var.equal = TRUE)
  # extract the p-value from the t_test
  if(t_test$p.value < 0.10) 
    return(1L) 
  else 
    return(0L)
}

set.seed(11)
output_vec <- vapply(1:2000, 
                     function(x) generate_one_test(), 
                     1L)
mean(output_vec)


## def generate_one_test(n=100):
##     X = norm.rvs(0, 1, size=n, random_state=rng)
##     Y = norm.rvs(0, 1, size=n, random_state=rng)
##     t_test = stats.ttest_ind(X, Y, equal_var=True)
##     if t_test.pvalue < 0.10:
##         return 1
##     else:
##         return 0
## output_vec = np.array([generate_one_test() for j in range(2000)])
## output_vec.mean()

## ----r-newspaper-1------------------------------------------------------------------------------
# R code to estimate the expected daily profit
set.seed(2141)
n <- 10000
X <- rgamma(n, 100, rate=1/100)
hX <- ifelse(X >= 11000, 11000, floor(X) + (11000 - floor(X)) * (-0.25))
#mean(hX)

# 90% CI for the mean
s <- sd(hX)
q1 <- qnorm(0.95)
CI <- c(mean(hX) - q1*s/sqrt(n), mean(hX) + q1*s/sqrt(n))
cat("The 90% CI for the mean is (", format(CI[1], digits=2, nsmall=2), ", ", 
    format(CI[2], digits=2, nsmall=2), ").\n", sep="")


## n = 10000
## X = gamma.rvs(100, scale=100, size=n, random_state=rng)
## hX = np.where(X >= 11000, 11000, np.floor(X) + (11000 - np.floor(X)) * (-0.25))
## 
## # 90% CI for the mean
## Xbar = hX.mean()
## s = hX.std()
## t = norm.ppf(0.95)
## CI = [Xbar - t*s/np.sqrt(n), Xbar + t*s/np.sqrt(n)]
## print(f"The 90% CI for the mean is ({CI[0]: .3f}, {CI[1]: .3f}).")

## ----r-abalone-1--------------------------------------------------------------------------------
abl <- read.csv("data/abalone_sub.csv")
x <- abl$viscera[abl$gender == "M"]
y <- abl$viscera[abl$gender == "F"]

t.test(x, y)


## ----abalone-2----------------------------------------------------------------------------------
#| fig-align: center
#|
d1 <- mean(x)  - mean(y)
print(d1)

generate_one_perm <- function(x, y) {
  n1 <- length(x)
  n2 <- length(y)
  xy <- c(x,y)
  xy_sample <- sample(xy)
  d1 <- mean(xy_sample[1:n1]) - mean(xy_sample[-(1:n1)])
  d1
}
sampled_diff <- replicate(2000, generate_one_perm(x,y))
hist(sampled_diff)

(p_val <- 2*mean(sampled_diff > d1))


## -----------------------------------------------------------------------------------------------
library(MASS)

mean(chem)
t.test(chem)
## [1] 4.280417


## -----------------------------------------------------------------------------------------------
library(boot)

stat_fn <- function(d, i) {
  b <- mean(d[i], trim=0.1)
  b
}
boot_out <- boot(chem, stat_fn, R = 1999, stype="i")
# Returns two types of bootstrap intervals:
boot.ci(boot.out = boot_out, type=c("perc", "bca"))

