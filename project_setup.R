## set up packages for working in this project
library("shiny", lib.loc="C:/Program Files/R/R-3.2.3/library")
library("devtools", lib.loc="C:/Program Files/R/R-3.2.3/library")
devtools::install_github('rstudio/shinyapps')
## I used shinyapps to help set up my account for publishing fomr Rstudio. Forgot to sign up with Coursera in the link
shinyapps::setAccountInfo(name='dataframes', token='57B96C7B141A8B254A57917F82E0C50C', secret='V/Jft6I2ph3QM/O8ICumzvOhCWMxJAj10Hmkc8kC')
## do not need to run that code again unless setting up new environment for publishing to shinyapps.io

library(shinyapps) ## must use forward slashes for windows path below
shinyapps::deployApp('C:/Users/delan/Source/Repos/DataProducts_ShinyApp/testapp')
## Worked! Application successfully deployed to https://dataframes.shinyapps.io/testapp/


## some of the plotting code I want to use depends on ggplot and datasets from gcookbook
library("gcookbook", lib.loc="C:/Program Files/R/R-3.2.3/library")
library("ggplot2", lib.loc="C:/Program Files/R/R-3.2.3/library")

## example plots and smoothing choices
p <- ggplot(heightweight, aes(x=ageYear, y=heightIn)) + geom_point()
p + stat_smooth(method = "lm", formula = y ~ x, size = 1)
p + stat_smooth(method = "loess", formula = y ~ x, size = 1)
p + stat_smooth(method = "lm", formula = y ~ x + I(x^2), size = 1)
