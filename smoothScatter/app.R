library("ggplot2") ## but I read there is built in support for ggplot. BUT did NOT work
library("gcookbook") ## for datasets, but may decide to remove this and ggplot and base R datasets

server <- function(input, output) {
    # Return the requested dataset
    datasetInput <- reactive({
        switch(input$dataset,
        "School Children H&W" = list(heightweight, "ageYear", "heightIn", "Height and weight of schoolchildren", heightweight$sex, "Gender"),
        "pressure" = list(pressure, "temperature", "pressure", "Data on the relation between temperature in degrees Celsius and vapor pressure of mercury in millimeters (of mercury)", 0, "None"),
        "Old Faithful" = list(faithful, "eruptions", "waiting", "Waiting time between eruptions and the duration of the eruption for the Old Faithful geyser in Yellowstone National Park, Wyoming, USA", 0, "None"),
        "Economics" = list(economics, "date", "psavert", "This dataset was produced from US economic time series data available from http://research.stlouisfed.org/fred2. Plotting savings rate over time", 0, "None"),
        "mtcars" = list(mtcars, "hp", "mpg", "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)", factor(mtcars$am), "Transmission"))
    })
    
    # Return the requested smoothing lm, glm, gam, loess
    smoothInput <- reactive({
        switch(input$smoothing,
               "Linear" = "lm",
               "Locally Weighted" = "loess",
               "Generalized Linear Model" = "glm",
               "Generalized Additive Model" = "gam")
    })
    
    thirdInput <- reactive({
        input$thirdVar
    })
    
        output$distPlot <- renderPlot({
        dset <- datasetInput()
        smoo <- smoothInput()
        ggp <- ggplot(dset[[1]], aes_string(x=dset[[2]], y=dset[[3]])) + geom_point() +
            theme(legend.title=element_blank())
        ggp <- ggp + stat_smooth(method = smoo[[1]], formula = y ~ x, size = 1) + ggtitle(paste("Scatterplot of",dset[[2]], "by", dset[[3]], ifelse(thirdInput(), paste("with factor", dset[[6]]), "")))
        if(thirdInput()){ggp + aes(color=dset[[5]])
            } else{ggp}
    })
        
        output$text1 <- renderText({ 
            dset <- datasetInput()
            dset[[4]]
        })
}

ui <- fluidPage(
    titlePanel("Learn about using smooths"),
    sidebarLayout(
        sidebarPanel(
            selectInput("dataset", "Choose a dataset:", choices = c("School Children H&W", "pressure", "Old Faithful", "Economics", "mtcars")),
            selectInput("smoothing", "Choose a smooth:", choices = c("Linear", "Locally Weighted", "Generalized Linear Model", "Generalized Additive Model")),
            checkboxInput("thirdVar", "Use 3rd variable for separate fits", value=T),
            withTags({
                div(class="header", checked=NA,
                    p("Try out different smooths with the datasets to learn more about your data."),
                    p("Learn more about smooths in ggplot"),
                    a(href="http://www.ats.ucla.edu/stat/r/faq/smooths.htm", "Click Here!"),
                    br(""),
                    p("App.R code in Github"),
                    a(href="https://github.com/bdelaney/DataProducts_ShinyApp/blob/master/smoothScatter/app.R", "Github")
                    )
            })
        ),
        mainPanel(
            plotOutput("distPlot"),
            tags$b(textOutput("text1"))
                  )
    )
)

shinyApp(ui = ui, server = server)