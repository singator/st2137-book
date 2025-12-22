## ----setup-----------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(knitr)
# library(reticulate)
# venv_paths <- read.csv("venv_paths.csv")
# id <- match(Sys.info()["nodename"], venv_paths$nodename)
# use_virtualenv(venv_paths$path[id])


## ----r-abalone-1-----------------------------------------------------------------------------------
abl <- read.csv("data/abalone_sub.csv")
x <- abl$viscera[abl$gender == "M"]
y <- abl$viscera[abl$gender == "F"]

t.test(x, y, var.equal=TRUE)


## import pandas as pd
## import numpy as np
## from scipy import stats
## import statsmodels.api as sm
## 
## abl = pd.read_csv("data/abalone_sub.csv")
## #abl.head()
## #abalone_df.describe()
## 
## x = abl.viscera[abl.gender == "M"]
## y = abl.viscera[abl.gender == "F"]
## 
## t_out = stats.ttest_ind(x, y)
## ci_95 = t_out.confidence_interval()
## 
## print(f"""
## * The p-value for the test is {t_out.pvalue:.3f}.
## * The actual value of the test statistic is {t_out.statistic:.3f}.
## * The upper and lower limits of the CI are ({ci_95[0]:.3f}, {ci_95[1]:.3f}).
## """)

## ----r-abalone-3-----------------------------------------------------------------------------------
aggregate(viscera ~ gender, data=abl, sd)


## abl.groupby('gender').describe()

## --------------------------------------------------------------------------------------------------
#| layout: [[1], [1,1]]
#| fig-align: center
#| out-width: 70%
#| fig-cap: 
#|   - "R: Histograms for males and females"
#|   - "R: QQ-plot for females"
#|   - "R: QQ-plot for males"
#| label: fig-r-abalone-normality

library(lattice)
histogram(~viscera | gender, data=abl, type="count")
qqnorm(y, main="Female Abalones");  qqline(y)
qqnorm(x, main="Male Abalones");  qqline(x)


## ----r-abalone-4-----------------------------------------------------------------------------------
#| collapse: true
library(DescTools)
aggregate(viscera ~ gender, data=abl, Skew, method=1)

aggregate(viscera ~ gender, data=abl, Kurt, method=1)

# Shapiro-Wilk Test only for males:
shapiro.test(x)


## abl.groupby("gender").skew()
## 
## for i,df in abl.groupby('gender'):
##     print(f"{df.gender.iloc[0]}: {df.viscera.kurt():.4f}")
## 
## stats.shapiro(x)

## ----r-hr-1----------------------------------------------------------------------------------------
hr_df <- read.csv("data/health_promo_hr.csv")
before <- hr_df$baseline
after <- hr_df$after5
t.test(before, after, paired=TRUE)


## hr_df = pd.read_csv("data/health_promo_hr.csv")
## #hr_df.head()
## 
## paired_out = stats.ttest_rel(hr_df.baseline, hr_df.after5)
## print(f"""
## Test statistic: {paired_out.statistic:.3f}.
## p-val: {paired_out.pvalue:.3f}.""")

## ----r-abalone-5-----------------------------------------------------------------------------------
wilcox.test(x, y)


## wrs_out = stats.mannwhitneyu(x, y)
## 
## print(f"""Test statistic: {wrs_out.statistic:.3f}.
## p-val: {wrs_out.pvalue:.3f}.""")

## ----r-hr-5----------------------------------------------------------------------------------------
wilcox.test(before, after, paired = TRUE, exact = FALSE)


## wsr_out = stats.wilcoxon(hr_df.baseline, hr_df.after5,
##                          correction=True, method='approx')
## print(f"""Test statistic: {wsr_out.statistic:.3f}.
## p-val: {wsr_out.pvalue:.3f}.""")
