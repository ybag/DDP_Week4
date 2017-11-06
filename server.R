library(shiny)

# server logic for distribution application
function(input, output) {
  
  # Reactive expression to generate the distribution.

  data <- reactive({
    dist <- switch(input$dist,
                   norm = rnorm,
                   unif = runif,
                   lnorm = rlnorm,
                   exp = rexp,
                   rnorm)
    
    if ((input$dist != "unif") && (input$dist != "exp"))
    {
      dist(input$n,mean = input$m, sd = input$std)
    }
    else
    {
      dist(input$n)
    }
  })
   
  observe( {

   shinyjs::toggleState("std", (input$dist != "unif") && (input$dist != "exp"))
   shinyjs::toggleState("m", (input$dist != "unif") && (input$dist != "exp"))

  })

  
  # Generate a plot of the data. 

  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    m <- input$m
    std <- input$std

    hist(data(), 
         main=paste('r', dist, '(', n, ')', sep=''))
  })
  
  # Generate a data summary 
  output$summary <- renderPrint({
    summary(data())
  })
  
  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(x=data())
  })
  
}
