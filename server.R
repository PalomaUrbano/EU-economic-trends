#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyr)
library(plotly)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot1 <- renderPlot({
    
    mpgInput <- input$sliderMPG
    
    eui <- prepareData()
    plot(eui$year, eui$gdp, pch=15, type="b",lty=1, col="red", 
         ylim = c(0, max(eui$gdp)), 
         yaxt="n", xaxt = "n", ann=FALSE)
         axis(side = 2, at = eui$gdp,labels = round(as.numeric(eui$gdp), digits=2), las=2, cex.axis=0.7, col.axis="blue")
         axis(side = 1, at= as.numeric(eui$year), labels = eui$year, las=2, cex.axis=0.7, col.axis="blue")
         title(main="European Union Economic Trends(2000-2015)",
         ylab ="US Dollars(Billions)", xlab = "Years",
        cex.lab=0.7, cex.main = 1)
         
    if(input$showExport=='TRUE'){
      lines(eui$year, eui$export, pch=9, type="b",lty=1, col="green")
    }
    if(input$showImport =="TRUE"){
      lines(eui$year, eui$import, pch=10, type="b",lty=1, col="blue")
    }
    if(input$showExpense =="TRUE"){
      lines(eui$year, eui$expend, pch=8, type="b",lty=1, col="orange")
    }
    
  })
  
})

prepareData <- function(){

  ed <- read.csv("gdp.csv", header=TRUE)
  names(ed) <- c("Country", "Code", "Indicator", "Ind_code", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015")
  edd<- gather(ed, "year", "gdp", 5:20)
  edd <- select(edd, year, gdp)
  
  ex <- read.csv("export.csv", header=TRUE)
  names(ex) <- c("Country", "Code", "Indicator", "Ind_code", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015")
  exd<- gather(ex, "year", "export", 5:20)
  exd <- select(exd, year, export)
  
  imp <- read.csv("import_gs.csv", header=TRUE)
  names(imp) <- c("Country", "Code", "Indicator", "Ind_code", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015")
  impd<- gather(imp, "year", "import", 5:20)
  impd <- select(impd, year, import)
  
  expend <- read.csv("expend.csv", header=TRUE)
  names(expend) <- c("Country", "Code", "Indicator", "Ind_code", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015")
  expd<- gather(expend, "year", "expend", 5:20)
  expd <- select(expd, year, expend)
  
  eui <- left_join(edd, exd, by="year")
  eui <- left_join(eui, impd, by="year")
  eui <- left_join(eui, expd, by="year")
  eui$gdp <- eui$gdp/1000000000
  eui$export <- eui$export/1000000000
  eui$import <- eui$import/1000000000
  eui$expend <- eui$expend/1000000000
  
  return(eui)
}

