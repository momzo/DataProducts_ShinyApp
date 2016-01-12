#library("ggplot2") ## but I read there is built in support for ggplot
library("gcookbook")

server <- function(input, output) {
    # Return the requested dataset
    datasetInput <- reactive({
        switch(input$dataset,
               "School Children H&W" = list(heightweight, "ageYear", "heightIn"),
               "pressure" = list(pressure, "temperature", "pressure"),
               "US Population Age" = list(uspopage, "AgeGroup", "Thousands"))
    })
    
    output$distPlot <- renderPlot({
        dset <- datasetInput()
        ggp <- ggplot(dset[[1]], aes_string(x=dset[[2]], y=dset[[3]])) + geom_point()
        ggp + stat_smooth(method = "lm", formula = y ~ x, size = 1)
    })
}

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            selectInput("dataset", "Choose a dataset:", choices = c("School Children H&W", "pressure", "US Population Age")),
            selectInput("Smoothing Method", "Choose a smooth:", choices = c("Linear", "Locally Weighted", "Polynomial", "Logarithmic", "Exponential"))
        ),
        mainPanel(plotOutput("distPlot"))
    )
)

shinyApp(ui = ui, server = server)