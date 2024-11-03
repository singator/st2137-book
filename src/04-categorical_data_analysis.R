## ----setup--------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(knitr)
library(reticulate)
venv_paths <- read.csv("venv_paths.csv")
id <- match(Sys.info()["nodename"], venv_paths$nodename)
use_virtualenv(venv_paths$path[id])


## ----chest_gender-------------------------------------------------------------------------------
#| echo: false
set.seed(13)
mf_sample <- sample(c("male", "female"), size=6, TRUE)
pain_sample <- sample(c("pain", "no pain"), size=6, TRUE)
chest_gender_df <- data.frame(Gender = mf_sample, Pain = pain_sample)
kable(chest_gender_df)


## ----chest_gender_2-----------------------------------------------------------------------------
#| echo: false
x <- matrix(c(46, 37, 474, 516), nrow=2)
dimnames(x) <- list(c("male", "female"), c("pain", "no pain"))
chest_tab <- as.table(x)
kable(chest_tab)


## ----chest_gender_3-----------------------------------------------------------------------------
#| echo: false
library(DescTools)
Desc(chest_tab, rfrq="011", plotit = FALSE, verbose=1)


## ----r-chest_gender-1---------------------------------------------------------------------------
x <- matrix(c(46, 37, 474, 516), nrow=2)
dimnames(x) <- list(c("male", "female"), c("pain", "no pain"))
chest_tab <- as.table(x)

chisq_output <- chisq.test(chest_tab)
chisq_output


## import numpy as np
## import pandas as pd
## from scipy import stats
## 
## chest_array = np.array([[46, 474], [37, 516]])
## 
## chisq_output = stats.chi2_contingency(chest_array)
## 
## print(f"The p-value is {chisq_output.pvalue:.3f}.")
## print(f"The test-statistic value is {chisq_output.statistic:.3f}.")

## ----r-chest_gender-2---------------------------------------------------------------------------
chisq_output$expected


## chisq_output.expected_freq

## ----r-claritin-0-------------------------------------------------------------------------------
#| echo: false
y <-  matrix(c(4, 2, 184, 260), nrow=2)
dimnames(y) <- list(c("claritin", "placebo"), c("nervous", "not nervous"))
claritin_tab <- as.table(y)
kable(claritin_tab)


## ----r-claritin-1-------------------------------------------------------------------------------
y <-  matrix(c(4, 2, 184, 260), nrow=2)
dimnames(y) <- list(c("claritin", "placebo"), c("nervous", "not nervous"))
claritin_tab <- as.table(y)

fisher.test(claritin_tab)


## claritin_tab = np.array([[4, 184], [2, 260]])
## 
## stats.fisher_exact(claritin_tab)

## ----claritin-r-chisq---------------------------------------------------------------------------
chisq.test(claritin_tab)$expected


## -----------------------------------------------------------------------------------------------
#| echo: false
x <- matrix(c(762,327,468,484,239,477), ncol=3, byrow=TRUE)
dimnames(x) <- list(c("female", "male"), 
                    c("Dem", "Ind", "Rep"))
political_tab <- as.table(x)
kable(political_tab)


## ----pol-1--------------------------------------------------------------------------------------
x <- matrix(c(762,327,468,484,239,477), ncol=3, byrow=TRUE)
dimnames(x) <- list(c("female", "male"), 
                    c("Dem", "Ind", "Rep"))
political_tab <- as.table(x)
chisq.test(political_tab)


## ----r-pol-2------------------------------------------------------------------------------------
chisq.test(political_tab)$stdres


## ----r-chest_gender-4---------------------------------------------------------------------------
library(DescTools)
OddsRatio(chest_tab,conf.level = .95)


## import statsmodels.api as sm
## chest_tab2 = sm.stats.Table2x2(chest_array)
## 
## print(chest_tab2.summary())
## 

## ----r-job-1------------------------------------------------------------------------------------
#| warning: false
#| message: false
x <- matrix(c(1, 3, 10, 6,
              2, 3, 10, 7,
              1, 6, 14, 12,
              0, 1,  9, 11), ncol=4, byrow=TRUE)
dimnames(x) <- list(c("<15,000", "15,000-25,000", "25,000-40,000", ">40,000"), 
                    c("Very Dissat.", "Little Dissat.", "Mod. Sat.", "Very Sat."))
us_svy_tab <- as.table(x)

output <- Desc(x, plotit = FALSE, verbose = 3)
output[[1]]$assocs


## from scipy import stats
## 
## us_svy_tab = np.array([[1, 3, 10, 6],
##                       [2, 3, 10, 7],
##                       [1, 6, 14, 12],
##                       [0, 1,  9, 11]])
## 
## dim1 = us_svy_tab.shape
## x = []; y=[]
## for i in range(0, dim1[0]):
##     for j in range(0, dim1[1]):
##         for k in range(0, us_svy_tab[i,j]):
##             x.append(i)
##             y.append(j)
## 
## stats.kendalltau(x, y)

## ----r-pol-3------------------------------------------------------------------------------------
#| fig-align: center
#| out-width: 65%
library(lattice)
barchart(political_tab/rowSums(political_tab), 
         horizontal = FALSE)


## claritin_prop = claritin_tab/claritin_tab.sum(axis=1).reshape((2,1))
## 
## xx = pd.DataFrame(claritin_prop,
##                   columns=['nervous', 'not_nervous'],
##                   index=['claritin', 'placebo'])
## 
## xx.plot(kind='bar', stacked=True)

## ----r-pol-4------------------------------------------------------------------------------------
#| fig-align: center
#| out-width: 65%
mosaicplot(political_tab, shade=TRUE)


## from statsmodels.graphics.mosaicplot import mosaic
## import matplotlib.pyplot as plt
## 
## political_tab = np.asarray([[762,327,468], [484,239,477]])
## mosaic(political_tab, statistic=True, gap=0.05);

## ----r-cd-1-------------------------------------------------------------------------------------
#| fig-align: center
#| out-width: 65%
heart_failure <- read.csv("data/heart+failure+clinical+records/heart_failure_clinical_records_dataset.csv")
spineplot(as.factor(DEATH_EVENT) ~ age, data=heart_failure)


## ----r-cd-2-------------------------------------------------------------------------------------
#| fig-align: center
#| out-width: 65%
cdplot(as.factor(DEATH_EVENT) ~ age, data=heart_failure)

