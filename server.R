library(shiny)
library(ggplot2)

dataset <- read.csv("data/diabetesReg.csv", header = TRUE, stringsAsFactors=TRUE)

BMI <- function (ht, wt) wt/ht^2
BMIRisk <- function(ht,wt) {
        BMI <- BMI(ht, wt)
        risk <- 0
        
        if(BMI >= 30 ) risk <- 2.518
        else if(BMI >= 27.5) risk <- 1.97
        else if(BMI >= 25) risk <- 0.699
        
        risk
        
}

# http://www.bmi-calculator.net/metric-bmi-calculator.php
BMIClassification <- function(ht,wt) {
        BMI <- BMI(ht, wt)
        classification <- 'Normal'
        
        if(BMI >= 40 )  classification <- 'Morbid Obesity'
        else if(BMI >= 35)  classification <- 'Obesity (Class 2)'
        else if(BMI >= 30)  classification <- 'Obesity (Class 1)'
        else if(BMI >= 25)  classification <- 'Overweight'
        else if(BMI >= 18.5)  classification <- 'Normal Weight'
        else classification <- 'Underweight'
        
        classification
}

Height <- function(ht) ht/100

Diabetes <- function(Sex, RxHTN, RxSTR, Age, BMI, FMH, Smoker)
{
        Terms <- 6.322 - Sex - RxHTN - RxSTR - 0.063*Age - BMI - FMH - Smoker
        100 / (1 + exp(Terms))
}


shinyServer(
        
        function(input, output) {
                output$Weight <- renderPrint({input$Wt})
                output$Height <- renderPrint({Height(input$Ht)})
                output$BMI <- renderPrint({round(BMI({Height(input$Ht)}, input$Wt),2)})
                output$BMIClassification <- renderPrint({BMIClassification({Height(input$Ht)}, input$Wt)})
                output$DiabetesRisk <- renderPrint({round(Diabetes(
                        Sex=as.numeric(input$Sex), RxHTN=as.numeric(input$RxHTN), 
                        RxSTR=as.numeric(input$RxSTR), Age=input$Age, BMI=BMIRisk({Height(input$Ht)}, input$Wt),
                        FMH = as.numeric(input$FMH), Smoker = as.numeric(input$Smoker)),2)})
                output$dataTable <- renderDataTable({dataset}, options = list(bsortClasses = TRUE))
               
        }
)