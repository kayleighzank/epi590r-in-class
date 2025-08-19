# Exploration

library(kableExtra)

# For dev version
install.packages("devtools")
devtools::install_github("haozhu233/kableExtra")


dt <- mtcars[1:5, 1:6]

kbl(dt)


dt %>%
	kbl() %>%
	kable_styling()

dt %>%
	kbl() %>%
	kable_paper("hover", full_width = F)

dt %>%
	kbl(caption = "Recreating booktabs style table") %>%
	kable_classic(full_width = F, html_font = "Cambria")


dt %>%
	kbl() %>%
	kable_classic_2(full_width = F)

dt %>%
	kbl() %>%
	kable_minimal()

dt %>%
	kbl() %>%
	kable_material(c("striped", "hover"))

dt %>%
	kbl() %>%
	kable_material_dark()


kbl(dt) %>%
	kable_styling(bootstrap_options = c("striped", "hover"))

kbl(dt) %>%
	kable_styling(bootstrap_options = c("striped", "hover", "condensed"))

kbl(dt) %>%
	kable_styling(bootstrap_options = c("striped", "hover", "condensed", "responsive"))

kbl(dt) %>%
	kable_paper(bootstrap_options = "striped", full_width = F)

kbl(dt) %>%
	kable_styling(bootstrap_options = "striped", full_width = F, position = "left")

kbl(dt) %>%
	kable_styling(bootstrap_options = "striped", font_size = 7)

kbl(mtcars[1:10, 1:5]) %>%
	kable_styling(fixed_thead = T)

text_tbl <- data.frame(
	Items = c("Item 1", "Item 2", "Item 3"),
	Features = c(
		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin vehicula tempor ex. Morbi malesuada sagittis turpis, at venenatis nisl luctus a. ",
		"In eu urna at magna luctus rhoncus quis in nisl. Fusce in velit varius, posuere risus et, cursus augue. Duis eleifend aliquam ante, a aliquet ex tincidunt in. ",
		"Vivamus venenatis egestas eros ut tempus. Vivamus id est nisi. Aliquam molestie erat et sollicitudin venenatis. In ac lacus at velit scelerisque mattis. "
	)
)

kbl(text_tbl) %>%
	kable_paper(full_width = F) %>%
	column_spec(1, bold = T, border_right = T) %>%
	column_spec(2, width = "30em", background = "yellow")

kbl(nlsy)
