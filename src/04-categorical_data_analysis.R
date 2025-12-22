## ----setup-----------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(knitr)


## ----chest_gender----------------------------------------------------------------------------------
#| echo: false
set.seed(13)
mf_sample <- sample(c("male", "female"), size=6, TRUE)
pain_sample <- sample(c("pain", "no pain"), size=6, TRUE)
chest_gender_df <- data.frame(Patient = 1:6,
                              Gender = mf_sample, 
                              Pain = pain_sample)
kable(chest_gender_df)


## ----chest_gender_2--------------------------------------------------------------------------------
#| echo: false
x <- matrix(c(46, 37, 474, 516), nrow=2)
dimnames(x) <- list(c("male", "female"), c("pain", "no pain"))
chest_tab <- as.table(x)
kable(chest_tab)


## --------------------------------------------------------------------------------------------------
#| echo: false
x <- matrix(c(762,327,468,484,239,477), ncol=3, byrow=TRUE)
dimnames(x) <- list(c("female", "male"), 
                    c("Dem", "Ind", "Rep"))
political_tab <- as.table(x)
kable(political_tab)


## --------------------------------------------------------------------------------------------------
#| fig-align: center
#| fig-cap: "R: Stacked barchart for political association data"
#| out-width: 65%
#| label: fig-r-barchart-pol
library(lattice)
x <- matrix(c(762,327,468,484,239,477), ncol=3, byrow=TRUE)
dimnames(x) <- list(c("female", "male"), 
                    c("Dem", "Ind", "Rep"))
political_tab <- as.table(x)
barchart(political_tab/rowSums(political_tab), 
         main="Political association by gender",
         horizontal = FALSE, auto.key=TRUE)


## ----r-claritin-0----------------------------------------------------------------------------------
#| echo: false
y <-  matrix(c(4, 2, 184, 260), nrow=2)
dimnames(y) <- list(c("claritin", "placebo"), c("nervous", "not nervous"))
claritin_tab <- as.table(y)
kable(claritin_tab)


## import numpy as np
## import pandas as pd
## 
## claritin_tab = np.array([[4, 184], [2, 260]])
## claritin_prop = claritin_tab/claritin_tab.sum(axis=1).reshape((2,1))
## 
## xx = pd.DataFrame(claritin_prop,
##                   columns=['nervous', 'not_nervous'],
##                   index=['claritin', 'placebo'])
## 
## ax = xx.plot(kind='bar', stacked=False, rot=1.0, figsize=(10,4),
##              title='Nervousness by drug')
## ax.legend(loc='upper left');

## --------------------------------------------------------------------------------------------------
#| fig-align: center
#| fig-cap: "R: Mosaic plot for political association data"
#| label: fig-r-mosaic-pol
#| out-width: 80%
#| fig-height: 4.5
mosaicplot(political_tab, shade=TRUE, main="Political association by gender")


## from statsmodels.graphics.mosaicplot import mosaic
## import matplotlib.pyplot as plt
## 
## political_tab = np.asarray([[762,327,468], [484,239,477]])
## mosaic(political_tab, statistic=True, gap=0.05);

## --------------------------------------------------------------------------------------------------
#| fig-align: center
#| fig-cap: "R: Spine plot for heart failure data"
#| label: fig-r-spine-heart
#| out-width: 65%

data_path <- file.path("data", "heart+failure+clinical+records", 
                       "heart_failure_clinical_records_dataset.csv")
heart_failure <- read.csv(data_path)
spineplot(as.factor(DEATH_EVENT) ~ age, data=heart_failure,
          ylab = "Death", xlab="Age", main="Proportion dying, by age")


## --------------------------------------------------------------------------------------------------
#| fig-align: center
#| fig-cap: "R: Conditional density plot for heart failure data"
#| label: fig-r-cd-heart
#| out-width: 65%
cdplot(as.factor(DEATH_EVENT) ~ age, data=heart_failure,
       ylab = "Death", xlab="Age", main="Proportion dying, by age")


## ----chest_gender_3--------------------------------------------------------------------------------
#| echo: false
library(DescTools)
Desc(chest_tab, rfrq="011", plotit = FALSE, verbose=1)


## ----r-chest_gender-1------------------------------------------------------------------------------
x <- matrix(c(46, 37, 474, 516), nrow=2)
dimnames(x) <- list(c("male", "female"), c("pain", "no pain"))
chest_tab <- as.table(x)

chisq_output <- chisq.test(chest_tab)
chisq_output


## from scipy import stats
## 
## chest_array = np.array([[46, 474], [37, 516]])
## 
## chisq_output = stats.chi2_contingency(chest_array)
## 
## print(f"The p-value is {chisq_output.pvalue:.3f}.")
## print(f"The test-statistic value is {chisq_output.statistic:.3f}.")

## ----r-chest_gender-2------------------------------------------------------------------------------
chisq_output$expected


## chisq_output.expected_freq

## ----r-claritin-1----------------------------------------------------------------------------------
y <-  matrix(c(4, 2, 184, 260), nrow=2)
dimnames(y) <- list(c("claritin", "placebo"), c("nervous", "not nervous"))
claritin_tab <- as.table(y)
fisher.test(claritin_tab)


## fe_output = stats.fisher_exact(claritin_tab)
## 
## print(f"The p-value for the test is {fe_output.pvalue:.4f}.")

## ----claritin-r-chisq------------------------------------------------------------------------------
chisq.test(claritin_tab)$expected


## ----pol-1-----------------------------------------------------------------------------------------
chisq.test(political_tab)


## ----r-pol-2---------------------------------------------------------------------------------------
chisq.test(political_tab)$stdres


## ----r-chest_gender-4------------------------------------------------------------------------------
library(DescTools)
OddsRatio(chest_tab,conf.level = .95)


## import statsmodels.api as sm
## chest_tab2 = sm.stats.Table2x2(chest_array)
## 
## print(chest_tab2.summary())
## 

## ----r-job-1---------------------------------------------------------------------------------------
#| warning: false
#| message: false
x <- matrix(c(1, 3, 10, 6,
              2, 3, 10, 7,
              1, 6, 14, 12,
              0, 1,  9, 11), ncol=4, byrow=TRUE)
dimnames(x) <- list(c("<15,000", "15,000-25,000", "25,000-40,000", ">40,000"), 
                    c("Very Dissat.", "Little Dissat.", "Mod. Sat.", 
                      "Very Sat."))
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
## kt_output = stats.kendalltau(x, y)
## print(f"The estimate of tau-b is {kt_output.statistic:.4f}.")
