library("ggplot2") ## but I read there is built in support for ggplot. BUT did NOT work
library("gcookbook")

server <- function(input, output) {
    # Return the requested dataset
    datasetInput <- reactive({
        switch(input$dataset,
               "School Children H&W" = list(heightweight, "ageYear", "heightIn"),
               "pressure" = list(pressure, "temperature", "pressure"),
               "US Population Age" = list(uspopage, "AgeGroup", "Thousands"))
    })
    
    # Return the requested smoothing lm, glm, gam, loess, rlm
    smoothInput <- reactive({
        switch(input$smoothing,
               "Linear" = "lm",
               "Locally Weighted" = "loess",
               "Generalized Linear Model" = "glm",
               "Generalized Additive Model" = "gam",
               "Robust Linear Model" = "rlm")
    })

        output$distPlot <- renderPlot({
        dset <- datasetInput()
        smoo <- smoothInput()
        ggp <- ggplot(dset[[1]], aes_string(x=dset[[2]], y=dset[[3]])) + geom_point()
        ggp + stat_smooth(method = smoo[[1]], formula = y ~ x, size = 1)
    })
}

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            selectInput("dataset", "Choose a dataset:", choices = c("School Children H&W", "pressure", "US Population Age")),
            selectInput("smoothing", "Choose a smooth:", choices = c("Linear", "Locally Weighted", "Generalized Linear Model", "Generalized Additive Model", "Robust Linear Model"))
        ),
        mainPanel(plotOutput("distPlot"))
    )
)

shinyApp(ui = ui, server = server)