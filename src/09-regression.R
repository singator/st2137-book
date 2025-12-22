## ----setup-----------------------------------------------------------------------------------------
#| echo: false
#| message: false
#| warning: false
library(knitr)


## --------------------------------------------------------------------------------------------------
#| fig-align: center
#| echo: false
#| label: fig-flow-water
#| fig-cap: "Scatterplot with simple linear regression model"
library(lattice)
concrete <- read.csv("data/concrete+slump+test/slump_test.data")
names(concrete)[c(1,11)] <- c("id", "Comp.Strength")
xyplot(FLOW.cm. ~ Water, type=c("p", "r"), data= concrete, main="Concrete data")


## --------------------------------------------------------------------------------------------------
#| fig-align: center
#| echo: false
#| label: fig-reg-casual
#| fig-cap: Scatterplot of registered vs. casual bike renters
bike2 <- read.csv("data/bike2.csv")
xyplot(registered ~ casual, groups=workingday, type=c("p", "r"), data=bike2,
       auto.key = TRUE, main="Registered vs. Casual, by Working Day Status")


## ----r-concrete-lm---------------------------------------------------------------------------------
#R 
concrete <- read.csv("data/concrete+slump+test/slump_test.data")
names(concrete)[c(1,11)] <- c("id", "Comp.Strength")
lm_flow_water <- lm(FLOW.cm. ~ Water, data=concrete)
summary(lm_flow_water)


## #Python
## import pandas as pd
## import numpy as np
## import statsmodels.api as sm
## from statsmodels.formula.api import ols
## 
## concrete = pd.read_csv("data/concrete+slump+test/slump_test.data")
## concrete.rename(columns={'No':'id',
##                          'Compressive Strength (28-day)(Mpa)':'Comp_Strength',
##                          'FLOW(cm)': 'Flow'},
##                 inplace=True)
## lm_flow_water = ols('Flow ~ Water', data=concrete).fit()
## print(lm_flow_water.summary())

## ----r-concrete-lm-ci------------------------------------------------------------------------------
#R 
confint(lm_flow_water)


## ----r-bike-lm-------------------------------------------------------------------------------------
#R 
bike2 <- read.csv("data/bike2.csv")
bike2_sub <- bike2[bike2$workingday == "no", ]
lm_reg_casual <- lm(registered ~ casual, data=bike2_sub)
anova(lm_reg_casual)


## #Python
## bike2 = pd.read_csv("data/bike2.csv")
## bike2_sub = bike2[bike2.workingday == "no"]
## 
## lm_reg_casual = ols('registered ~ casual', bike2_sub).fit()
## anova_tab = sm.stats.anova_lm(lm_reg_casual,)
## anova_tab

## ----r-concrete-pred-------------------------------------------------------------------------------
#| fig-align: center
#| fig-height: 4
#| fig-cap: "R: Confidence intervals flow versus water"

#R 
new_df <- data.frame(Water = seq(160, 240, by = 5))
conf_intervals <- predict(lm_flow_water, new_df, interval="conf")

plot(concrete$Water, concrete$FLOW.cm., ylim=c(0, 100),
     xlab="Water", ylab="Flow", main="Confidence Bands for Flow vs. Water")
abline(lm_flow_water, col="red")
lines(new_df$Water, conf_intervals[,"lwr"], col="red", lty=2)
lines(new_df$Water, conf_intervals[,"upr"], col="red", lty=2)
legend("bottomright", legend=c("Fitted line", "Lower/Upper CI"), 
       lty=c(1,2), col="red")


## # Python
## new_df = sm.add_constant(pd.DataFrame({'Water' : np.linspace(160,240, 10)}))
## 
## predictions_out = lm_flow_water.get_prediction(new_df)
## 
## ax = concrete.plot(x='Water', y='Flow', kind='scatter', alpha=0.5 )
## ax.set_title('Confidence Bands for Flow vs. Water');
## ax.plot(new_df.Water, predictions_out.conf_int()[:, 0].reshape(-1),
##         color='blue', linestyle='dashed');
## ax.plot(new_df.Water, predictions_out.conf_int()[:, 1].reshape(-1),
##         color='blue', linestyle='dashed');
## ax.plot(new_df.Water, predictions_out.predicted, color='blue');

## ----r-concrete-lm-2-------------------------------------------------------------------------------
# R 
lm_flow_water_slag <- lm(FLOW.cm. ~ Water + Slag, data=concrete)
summary(lm_flow_water_slag)


## # Python
## lm_flow_water_slag = ols('Flow ~ Water + Slag', data=concrete).fit()
## print(lm_flow_water_slag.summary())

## ----r-bike-lm-2-----------------------------------------------------------------------------------
# R 
lm_reg_casual2 <- lm(registered ~ casual + workingday, data=bike2)
summary(lm_reg_casual2)


## # Python
## lm_reg_casual2 = ols('registered ~ casual + workingday', bike2).fit()
## print(lm_reg_casual2.summary())

## --------------------------------------------------------------------------------------------------
#| echo: false
#| fig-align: center
#| fig-cap: "R: Comparing two linear regression models"
#| label: fig-r-bike-compare-models

plot(x=bike2$casual, y=bike2$registered, 
     col=ifelse(bike2$workingday == "yes", "salmon", "deepskyblue4"),
     main="Comparing fitted models", cex=0.8,
     xlab="Casual", ylab="Registered")
abline(lm_reg_casual, col="deepskyblue4", lty=2)
est_coef <- coef(lm_reg_casual2)
abline(est_coef[1], est_coef[2], col="deepskyblue4")
abline(est_coef[1]+est_coef[3], est_coef[2], col="salmon")
legend("bottomright", legend=c("lm_reg_casual", "lm_reg_causal2"),
       lty=c(2,1), cex=0.7)
#legend("bottom", legend=c("no", "yes"), pch=1,
#       col=c("deepskyblue4", "salmon"), cex=0.7)


## ----r-bike-lm-3-----------------------------------------------------------------------------------
# R 
lm_reg_casual3 <- lm(registered ~ casual * workingday, data=bike2)
summary(lm_reg_casual3)


## # Python
## lm_reg_casual3 = ols('registered ~ casual * workingday', bike2).fit()
## print(lm_reg_casual3.summary())

## ----r-plot-bike-lm3-------------------------------------------------------------------------------
#| echo: false
#| fig-align: center
#| fig-cap: Scatterplot of regression model with interaction between working day and casual

plot(x=bike2$casual, y=bike2$registered, 
     col=ifelse(bike2$workingday == "yes", "salmon", "deepskyblue4"),
     main="Interaction model", cex=0.8,
     xlab="Casual", ylab="Registered")
est_coef <- coef(lm_reg_casual3)
abline(est_coef[1], est_coef[2], col="deepskyblue4")
abline(est_coef[1]+est_coef[3], est_coef[2]+est_coef[4], col="salmon")


## ----r-concrete-qq-1-------------------------------------------------------------------------------
#| layout-ncol: 2
#| fig-cap: 
#|   - "R: Residual histogram, flow vs. water and slag"
#|   - "R: Residual QQ-plot, flow vs. water and slag"
r_s <- rstandard(lm_flow_water_slag)
hist(r_s)
qqnorm(r_s)
qqline(r_s)


## # Python
## r_s = pd.Series(lm_flow_water_slag.resid_pearson)
## r_s.hist()

## ----r-concrete-shap-------------------------------------------------------------------------------
#| collapse: true
shapiro.test(r_s)
ks.test(r_s, "pnorm")


## --------------------------------------------------------------------------------------------------
#| fig-align: center
#| fig-height: 4
#| fig-width: 10
#| fig-cap: "R: Residual diagnostic plots, flow vs. water and slag"
#| label: fig-r-residual-diagnostics
opar <- par(mfrow=c(1,3))
plot(x=fitted(lm_flow_water_slag), r_s, main="Fitted")
plot(x=concrete$Water, r_s, main="X1")
plot(x=concrete$Slag, r_s, main="X2")
par(opar)


## ----r-concrete-infl-------------------------------------------------------------------------------
infl <- influence.measures(lm_flow_water_slag)
summary(infl)

