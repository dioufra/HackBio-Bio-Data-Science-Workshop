#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(shinyWidgets)
library(plyr)
library(ggplot2)
library(reshape2)
library(tidyverse)




######################################################### DATA PREPOCESSING##############################################################

##### load the data
df <- read.table(file = "C:/Users/DELL/Documents/HackBio/Bio-Data Science/stage03/GSE210399_complete_data_matrix.txt",
                 header = TRUE, sep = "\t", check.names = FALSE)


#inspect the data
head(df)


#remove the X column
df <- df[-2]

# Extract cell lines names
cell_lines <- c("MCF7", "LetR1", "LetR3")

# List of the genes
genes <- df$ID
genes


# Select the columns of interest
new_data <- df %>% 
   select(ID:`MCF7-S0-5-86`)


# Reshape the data to long format
new_data <- new_data %>% 
  gather(`Cell Line`, `Expression Level`, -ID)


# Rename the variables
new_data$`Cell Line` <- replace(new_data$`Cell Line`, startsWith(new_data$`Cell Line`, 'LetR1'), 'LetR1')
new_data$`Cell Line` <- replace(new_data$`Cell Line`, startsWith(new_data$`Cell Line`, 'LetR3'), 'LetR3')
new_data$`Cell Line` <- replace(new_data$`Cell Line`, startsWith(new_data$`Cell Line`, 'MCF7'), 'MCF7')

# new_data
# unique(new_data$`Cell Line`)


##################################################### WEB APPLICATION ####################################################################

# Define UI for application
ui <- fluidPage(

    # Application title
    headerPanel("My Application"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          
            # Gene input list
            selectizeInput(inputId = "genes",
                           label = h3("Genes:"),
                           choices = NULL  ,
                           options = list(placeholder = "Type of gene", maxOptions = 1000) ),
            
            h5("*Type your gene of interest (only first 1000 genes displayed)"),
            
            # Cell lines input list
            pickerInput(inputId = "cell_lines",
                        label = "",
                        choices = cell_lines,
                        options = pickerOptions(actionsBox = TRUE, title = "Cell Lines",  size = 10, maxOptions = 3, liveSearch = TRUE),
                        multiple = TRUE)
        ),

        # Show a plot gene expression accross cell line
        mainPanel(titlePanel("Gene Expression"),
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
    # update the choice 
    updateSelectizeInput(session, "genes", choices = genes, server = TRUE)
    updatePickerInput(session, "cell_lines", choices = cell_lines)
    
    
    # reactive expression
    data <- reactive({
      
      dat <- new_data[new_data$ID == input$genes & new_data$`Cell Line` %in% input$cell_lines,]
      
      })
    
    # output
    output$distPlot <- renderPlot({
      # generate a plot based on input values
      ggplot(data = data(), aes(x = `Cell Line`, y = `Expression Level`, fill = `Cell Line`)) +
        geom_boxplot() 
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
