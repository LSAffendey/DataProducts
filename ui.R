library(shiny)

#http://http://reference.medscape.com/calculator/diabetes-risk-score-type-2
shinyUI(shinyUI(fluidPage(
        navbarPage("Diabetes Risk Score (Type 2) and BMI Calculator",
                   
        tabPanel("Calculator",
            sidebarPanel(
                h4('Kindly provide the followings:'),
                radioButtons('Sex', 'Gender', c('Male'=0,'Female'=-0.879)),
                radioButtons('RxHTN', 'Are you on hypertension medications?', c('No'=0,'Yes'=1.222)),
                radioButtons('RxSTR', 'Are you on any steriod medications?', c('No'=0,'Yes'=2.191)),
                numericInput('Age', 'Age', 50, min = 0, step = 1),
                numericInput('Ht', 'Height (cm)', 190, min=50, step=0.5),
                numericInput('Wt', 'Weight (kg)', 100, min=10, step=0.5),
                radioButtons('FMH', 'Any of your family have a history of diabetes?',
                             c('No first degree family members with diabetes'=0,
                               'Parent OR sibling with diabetes'=0.728,
                               'Parent AND sibling with diabetes'=0.753)),
                radioButtons('Smoker', 'Are you a smoker?',
                             c('Non-smoker'=0,
                               'Used to smoke'=-0.218,
                               'Smoker'=0.855))
            ),
            mainPanel(
                        h4('With a height of (meter)'),
                        verbatimTextOutput('Height'),
                        h4('and a weight of (kilogram)'),
                        verbatimTextOutput('Weight'),
                        h4('your BMI is:'),
                        verbatimTextOutput('BMI'),
                        h4('and your BMI classification is:'),
                        verbatimTextOutput('BMIClassification'),
                        h4('Your Diabetes Risk Factor percentage is:'),
                        verbatimTextOutput('DiabetesRisk')
                    
            )
        ), # end main page panel
        
          tabPanel(p("Malaysia National Diabetes Registry Vol. 1 2009-2012"),
                   
                   mainPanel(
                                h4('Table'), 
                                dataTableOutput("dataTable")
                                
                   ) # end mainPanel
                  
          ), # end tab 1
          
          tabPanel(p("About"),
                   mainPanel(
                   h4('This is an App developed as a project for Data Science MOOC. This simple Shiny App is for calculating the Diabetes Risk Score and BMI.  
                      The outputs are the percentage of risks of diabetes type 2 and the classification of BMI. Simply enter the information required to get your score. 
                      This App also includes the Malaysian National Diabetes Registry Vol. 1 2009-2012 data.')
                   )
           ) # end tab 2        
                        

))))