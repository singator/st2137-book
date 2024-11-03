## ----setup--------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(tidyverse)
library(knitr)
library(reticulate)
venv_paths <- read.csv("venv_paths.csv")
id <- match(Sys.info()["nodename"], venv_paths$nodename)
use_virtualenv(venv_paths$path[id])


## ----r-stud-perf-1------------------------------------------------------------------------------
#| warning: false
#| message: false
stud_perf <- read.table("data/student/student-mat.csv", sep=";", 
                        header=TRUE)
summary(stud_perf$G3)
sum(is.na(stud_perf$G3))


## import pandas as pd
## import numpy as np
## 
## stud_perf  = pd.read_csv("data/student/student-mat.csv", delimiter=";")
## stud_perf.G3.describe()
## #stud_perf.G3.info()

## ----r-stud-perf-2------------------------------------------------------------------------------
round(aggregate(G3 ~ Medu, data=stud_perf, FUN=summary), 2)
table(stud_perf$Medu)


## stud_perf[['Medu', 'G3']].groupby('Medu').describe()

## ----r-stud-perf-3------------------------------------------------------------------------------
#| fig-align: center
#| out-width: "70%"
hist(stud_perf$G3, main="G3 histogram")


## fig = stud_perf.G3.hist(grid=False)
## fig.set_title('G3 histogram');

## ----r-stud-perf-4------------------------------------------------------------------------------
#| fig-align: center
#| out-width: "70%"
library(lattice)
histogram(~G3 | Medu, data=stud_perf, type="density")


## stud_perf.G3.hist(by=stud_perf.Medu, figsize=(15,10), density=True,
##                   layout=(2,3));

## ----r-stud-perf-5------------------------------------------------------------------------------
#| fig-align: center
#| out-width: "70%"
densityplot(~G3, groups=Medu, data=stud_perf, auto.key = TRUE, bw=1.5)


## import matplotlib.pyplot as plt
## f, axs = plt.subplots(2, 3, squeeze=False, figsize=(15,6))
## out2 = stud_perf.groupby("Medu")
## for y,df0 in enumerate(out2):
##     tmp = plt.subplot(2, 3, y+1)
##     df0[1].G3.plot(kind='kde')#(kind="kde", ax=tmp)
##     tmp.set_title(df0[0])

## ----r-stud-perf-6------------------------------------------------------------------------------
#| fig-align: center
#| out-width: "70%"
bwplot(G3 ~ goout, horizontal = FALSE, data=stud_perf)


## stud_perf.plot.box(column='G3', by='goout')

## ----qq-eg-1------------------------------------------------------------------------------------
#| echo: false
#| label: fig-qq-1
#| layout-ncol: 2
#| fig-align: center
#| fig-cap: "QQ-plots"
#| fig-subcap:
#|  - "Thinner than Normal"
#|  - "Fatter than Normal"
set.seed(2137)
X <- runif(100)
qqnorm(X, main="Both tails thinner than Normal")
qqline(X)

Y <- rt(100, df=2)
qqnorm(Y, main="Both tails fatter than Normal")
qqline(Y)



## -----------------------------------------------------------------------------------------------
concrete <- read.csv("data/concrete+slump+test/slump_test.data")
names(concrete)[c(1,11)] <- c("id", "Comp.Strength")


## concrete = pd.read_csv("data/concrete+slump+test/slump_test.data")
## concrete.rename(columns={'No':'id', 'Compressive Strength (28-day)(Mpa)':'Comp_Strength'},
##                 inplace=True)

## -----------------------------------------------------------------------------------------------
#| echo: false
#| out-width: "70%"
#| fig-align: center
#| fig-cap: Comparing data with reference Normal (blue)
#| label: fig-concrete-1

hist(concrete$Comp.Strength, freq = FALSE)
dens_out <- density(concrete$Comp.Strength)
lines(dens_out$x, dens_out$y, col="red")

x_mean <- mean(concrete$Comp.Strength)
x_sd <- sd(concrete$Comp.Strength)
x_vals <- seq(10, 65, by=0.5)
y_vals <- dnorm(x_vals, mean=x_mean, sd=x_sd)
lines(x_vals, y_vals, col="blue", lty=2)


## ----r-concrete-1-------------------------------------------------------------------------------
#| fig-align: center
#| out-width: "70%"
qqnorm(concrete$Comp.Strength)
qqline(concrete$Comp.Strength)


## from scipy import stats
## import statsmodels.api as sm
## sm.qqplot(concrete.Comp_Strength, line="q");

## ----r-concrete-2-------------------------------------------------------------------------------
#| fig-align: center
#| out-width: "100%"
col_to_use <- c("Cement", "Slag", "Comp.Strength", "Water", "SLUMP.cm.",
                "FLOW.cm.")
pairs(concrete[, col_to_use], panel = panel.smooth)


## pd.plotting.scatter_matrix(concrete[['Cement', 'Slag', 'Comp_Strength', 'Water',
##                                      'SLUMP(cm)', 'FLOW(cm)']],
##                            figsize=(12,12));

## ----r-concrete-3-------------------------------------------------------------------------------
#| fig-align: center
#| message: false
#| warning: false

library(psych)
corPlot(cor(concrete[, col_to_use]), cex=0.8, show.legend = FALSE)


## corr = concrete[['Cement', 'Slag', 'Comp_Strength', 'Water',
##                  'SLUMP(cm)', 'FLOW(cm)']].corr()
## corr.style.background_gradient(cmap='coolwarm_r')
