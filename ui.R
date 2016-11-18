#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("European Union(EU) - Economic Indicators"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      helpText("Please select Economic Indicators from below to add the EU GDP plot on the right"),
      checkboxInput("showExport", "Show/Hide Exports (US$)", value = FALSE),
      checkboxInput("showImport", "Show/Hide Imports (US$)", value = FALSE),
      checkboxInput("showExpense", "Show/Hide Expenses(US$)", value = FALSE)
    ), 
      
    
    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("plot1"),
        h5("Plot of the EU Economic Indicators from 2000 to 2015")
        
    )
  )
))
