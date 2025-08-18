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

poisson_model <- glm(glasses ~ eyesight_cat + sex_cat + region_cat,
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
