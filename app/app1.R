# The Cumulative Grade Point Average (CGPA) calculator is determined 
# based on the marks entered by the user.
library(shiny)
grades <- function(marks) {
         marks = (marks / 9.5)
         print(marks)
         if (marks <=  7.368421){
             "Please try again!"
         } else if (marks > 7.368421 & marks < 9.368421){
             "Pass! Good Job"
         } else if (marks >= 9.368421){
             "Distinction!! You are genius"
         } 
} 

shinyServer(
    function(input, output) { 
     output$inputValue <- renderPrint({input$marks})
     output$prediction <- renderPrint({grades(input$marks)})
     
    }
)
