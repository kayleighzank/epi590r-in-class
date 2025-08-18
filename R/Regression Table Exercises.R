library(tidyverse)
library(gtsummary)

# load and clean data
nlsy_cols <- c(
	"glasses", "eyesight", "sleep_wkdy", "sleep_wknd",
	"id", "nsibs", "samp", "race_eth", "sex", "region",
	"income", "res_1980", "res_2002", "age_bir"
)
nlsy <- read_csv(here::here("data", "raw", "nlsy.csv"),
								 na = c("-1", "-2", "-3", "-4", "-5", "-998"),
								 skip = 1, col_names = nlsy_cols
) |>
	mutate(
		region_cat = factor(region, labels = c("Northeast", "North Central", "South", "West")),
		sex_cat = factor(sex, labels = c("Male", "Female")),
		race_eth_cat = factor(race_eth, labels = c("Hispanic", "Black", "Non-Black, Non-Hispanic")),
		eyesight_cat = factor(eyesight, labels = c("Excellent", "Very good", "Good", "Fair", "Poor")),
		glasses_cat = factor(glasses, labels = c("No", "Yes"))
	)

# Each of the univariate regression examples held the outcome (y =) constant, while varying the predictor variables with include =. You can also look at one predictor across several outcomes. Create a univariate regression table looking at the association between sex (sex_cat) as the x = variable and each of nsibs, sleep_wkdy, and sleep_wknd, and income.
tbl_uvregression(
	nlsy,
	x = sex_cat,
	include = c(
		nsibs, sleep_wkdy,
		sleep_wknd, income
	),
	method = lm
)

# Fit a Poisson regression (family = poisson()) for the number of siblings, using at least 3 predictors of your choice. Create a nice table displaying your Poisson regression and its exponentiated coefficients.

poisson_model <- glm(nsibs ~ eyesight_cat + sex_cat + region_cat,
											data = nlsy, family = poisson()
)

tbl_regression(
	poisson_model,
	exponentiate = TRUE,
	label = list(
		sex_cat ~ "Sex",
		eyesight_cat ~ "Eyesight",
		region_cat = "Region"
	)
)

# Instead of odds ratios for wearing glasses, as in the example in the slides., we want risk ratios. We can do this by specifying in the regression family = binomial(link = "log"). Regress glasses on eyesight_cat and sex_cat and create a table showing the risk ratios and confidence intervals from this regression.

logistic_model_RR <- glm(glasses ~ eyesight_cat + sex_cat,
											data = nlsy, family = binomial(link = "log")
)

tbl_regression(
	logistic_model_RR,
	label = list(
		sex_cat ~ "Sex",
		eyesight_cat ~ "Eyesight"
	)

)

# Make a table comparing the logistic and the log-binomial results.

logistic_model <- glm(glasses ~ eyesight_cat + sex_cat,
											data = nlsy, family = binomial()
)

logistic_table <- tbl_regression(
		logistic_model,
		exponentiate = TRUE,
		label = list(
			sex_cat ~ "Sex",
			eyesight_cat ~ "Eyesight"
		)
	)

log_binomial_table <- tbl_regression(
	logistic_model_RR,
	exponentiate = TRUE,
	label = list(
		sex_cat ~ "Sex",
		eyesight_cat ~ "Eyesight"
	)

)

tbl_merge(list(logistic_table, log_binomial_table),
					tab_spanner = c("**Logistic Regression Model**", "**Log-Binomial Regression Model**")
)
