library(shiny)

# Define UI for random distribution application 
fluidPage(
    
  shinyjs::useShinyjs(),
  # Application title
  titlePanel("Tabsets"),
  
  # Sidebar with controls 
  sidebarLayout(
    sidebarPanel(
      radioButtons("dist", "Distribution type:",
                   c("Normal" = "norm",
                     "Uniform" = "unif",
                     "Log-normal" = "lnorm",
                     "Exponential" = "exp")),
      br(),
      
      sliderInput("n", 
                  "Number of observations:", 
                   value = 500,
                   min = 1, 
                   max = 1000),

      sliderInput("m", 
                  "Mean", 
                   value = 0,
                   min = -100, 
                   max = 100),

      sliderInput("std", 
                  "Standard Deviation", 
                   value = 1,
                   min = 0, 
                   max = 10)


    ),
    
    # Show a tabset that includes a plot, summary, and table view
    mainPanel(
      tabsetPanel(type = "tabs", 
        tabPanel("Plot", plotOutput("plot")), 
        tabPanel("Summary", verbatimTextOutput("summary")), 
        tabPanel("Table", tableOutput("table"))
      )
    )
  )
)
