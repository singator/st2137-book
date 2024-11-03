## ----setup--------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(knitr)
library(reticulate)
library(MASS)
venv_paths <- read.csv("venv_paths.csv")
id <- match(Sys.info()["nodename"], venv_paths$nodename)
use_virtualenv(venv_paths$path[id])


## ----cu_1---------------------------------------------------------------------------------------
#| fig-cap: "Copper measurements dataset"
#| fig-align: center
#| warning: false
library(MASS)
hist(chem, breaks = 20)
sort(chem)
mean(chem)


## ----self_1-------------------------------------------------------------------------------------
#| fig-cap: "Self-awareness study timing"
#| fig-align: center
#| warning: false
awareness <- c(77, 87, 88, 114, 151, 210, 219, 246, 253, 262, 296, 299, 306,
               376, 428, 515, 666, 1310, 2611)
hist(awareness, breaks=10)
mean(awareness)


## ----r-demo-cn----------------------------------------------------------------------------------
#| echo: false
#| fig-align: center
#| out-width: 75%

x <- seq(-3, 3, length=100)
y1 <- dnorm(x)
epsilon <- 1/100
y2 <- (1-epsilon)*dnorm(x) + epsilon*dnorm(x, sd=3)
plot(x, y1, type="l", col="blue")
lines(x, y2, type="l", col="red")
legend("topright", legend=c("Normal", "Contaminated Normal,\nEpsilon=0.01"), col=c("blue", "red"), lty=1, cex=0.8)



## ----r-loc-copper-------------------------------------------------------------------------------
#| collapse: true

mean(chem)

mean(chem, trim = 0.1) # using gamma = 0.1

library(DescTools)
vals = quantile(chem, probs=c(0.05, 0.95))
win_sample <- Winsorize(chem, vals) # gamma = 0.1
mean(win_sample)


## import pandas as pd
## import numpy as np
## from scipy import stats
## 
## chem = pd.read_csv("data/mass_chem.csv")
## 
## chem.chem.mean()
## 
## stats.trim_mean(chem, proportiontocut=0.1)
## 
## stats.mstats.winsorize(chem.chem, limits=0.1).mean()

## ----r-scale-self-------------------------------------------------------------------------------
#| collapse: true

sd(awareness)

mad(awareness, constant=1) 

IQR(awareness)


## awareness = np.array([77, 87, 88, 114, 151, 210, 219, 246, 253, 262, 296, 299, 306,
##                       376, 428, 515, 666, 1310, 2611])
## 
## awareness.std()
## 
## stats.median_abs_deviation(awareness)
## 
## stats.iqr(awareness)
