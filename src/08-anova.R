## ----setup--------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(knitr)
library(reticulate)
venv_paths <- read.csv("venv_paths.csv")
id <- match(Sys.info()["nodename"], venv_paths$nodename)
use_virtualenv(venv_paths$path[id])


## ----heifer-plot--------------------------------------------------------------------------------
#| fig-align: center
#| echo: false
library(lattice)
heifers <- read.csv("data/antibio.csv")
u_levels <- sort(unique(heifers$type))
heifers$type <- factor(heifers$type, levels=u_levels[c(2, 1, 3, 4, 5, 6)])
bwplot(org ~ as.factor(type), data=heifers, 
       main="Organic Weight after 8 weeks")


## ----heifer-summary-----------------------------------------------------------------------------
#| echo: FALSE
aggregate(org ~ type, heifers, function(x) c(mean = mean(x),  
                                             sd = sd(x),
                                             count=as.integer(length(x))))


## ----r-f-test-----------------------------------------------------------------------------------
#R 
heifers <- read.csv("data/antibio.csv")
u_levels <- sort(unique(heifers$type))
heifers$type <- factor(heifers$type, 
                       levels=u_levels[c(2, 1, 3, 4, 5, 6)])
anova1 <- aov(org ~ type, data=heifers)
summary(anova1)


## #Python
## import pandas as pd
## import numpy as np
## from scipy import stats
## import statsmodels.api as sm
## from statsmodels.formula.api import ols
## 
## heifers = pd.read_csv("data/antibio.csv")
## heifer_lm = ols('org ~ type', data=heifers).fit()
## anova_tab = sm.stats.anova_lm(heifer_lm, type=3,)
## print(anova_tab)

## ----r-coef-------------------------------------------------------------------------------------
# R
coef(anova1)


## # Python
## heifer_lm.summary()

## ----r-normality--------------------------------------------------------------------------------
#| layout-ncol: 2
# R
r1 <- residuals(anova1)
hist(r1)
qqnorm(r1); qqline(r1)



## # Python
## import matplotlib.pyplot as plt
## 
## f, axs = plt.subplots(1, 2, figsize=(8,4))
## tmp = plt.subplot(121)
## heifer_lm.resid.hist();
## tmp = plt.subplot(122)
## sm.qqplot(heifer_lm.resid, line="q", ax=tmp);

## ----r-pairwise---------------------------------------------------------------------------------
# R 
summary_out <- summary(anova1)
est_coef <- coef(anova1)
est1  <- unname(est_coef[3]) # coefficient for Enrofloxacin
MSW <- summary_out[[1]]$`Mean Sq`[2]
df <- summary_out[[1]]$Df[2]
q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- est1 - q1*sqrt(MSW * (1/6 + 1/4))
upper_ci <- est1 + q1*sqrt(MSW * (1/6 + 1/4))
cat("The 95% CI for the diff. between Enrofloxacin and Control is (",
    format(lower_ci, digits = 3), ",", format(upper_ci, digits = 3), ").", sep="")


## # Python
## est1  = heifer_lm.params.iloc[2] - heifer_lm.params.iloc[1]
## MSW = heifer_lm.mse_resid
## df = heifer_lm.df_resid
## q1 = -stats.t.ppf(0.025, df)
## 
## lower_ci = est1 - q1*np.sqrt(MSW * (1/6 + 1/4))
## upper_ci = est1 + q1*np.sqrt(MSW * (1/6 + 1/4))
## print(f"The 95% CI for the diff. between Enrofloxacin and control is ({lower_ci:.3f}, {upper_ci:.3f}).")

## ----r-contrast---------------------------------------------------------------------------------
c1 <- c(-1, 0.5, 0.5)
n_vals <- c(6, 6, 6)
L <- sum(c1*est_coef[3:5])

MSW <- summary_out[[1]]$`Mean Sq`[2]
df <- summary_out[[1]]$Df[2]
se1 <- sqrt(MSW * sum( c1^2 / n_vals ) )

q1 <- qt(0.025, df, 0, lower.tail = FALSE)

lower_ci <- L - q1*se1
upper_ci <- L + q1*se1
cat("The 95% CI for the diff. between the two groups is (",
    format(lower_ci, digits = 2), ",", format(upper_ci, digits = 2), ").", sep="")


## c1 = np.array([-1, 0.5, 0.5])
## n_vals = np.array([6, 6, 6,])
## L = np.sum(c1 * heifer_lm.params.iloc[2:5])
## 
## MSW = heifer_lm.mse_resid
## df = heifer_lm.df_resid
## q1 = -stats.t.ppf(0.025, df)
## se1 = np.sqrt(MSW*np.sum(c1**2 / n_vals))
## 
## lower_ci = L - q1*se1
## upper_ci = L + q1*se1
## print(f"The 95% CI for the diff. between the two groups is ({lower_ci:.3f}, {upper_ci:.3f}).")

## ----r-tukey------------------------------------------------------------------------------------
TukeyHSD(anova1, ordered = TRUE)


## import statsmodels.stats.multicomp as mc
## 
## cp = mc.MultiComparison(heifers.org, heifers.type)
## tk = cp.tukeyhsd()
## print(tk)

## ----r-kw---------------------------------------------------------------------------------------
kruskal.test(heifers$org, heifers$type)


## out = [x[1] for x in heifers.org.groupby(heifers.type)]
## stats.kruskal(*out)
