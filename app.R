
#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(kableExtra)

heist_df <- read_csv('data/heist.csv')
zombie_df <- read_csv('data/zombie.csv')

# because readr changes them automatically
# just as much work as base since base requires me to add in the Levels column
colnames(heist_df) <- c('Level', 'FE', 'EXP', 'FE ', 'EXP ', 'WP')
colnames(zombie_df) <- c('Level', 'FE', 'EXP', 'FE ', 'EXP ', 'WP', 'TP')  

# Define UI for random distribution app ----
ui <- fluidPage(
  
  # App title ----
  #titlePanel("Tabsets"),
  
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Tabset w/ plot, summary, and table ----
    tabsetPanel(type = "tabs",
                tabPanel("Heist", tableOutput("heist_table")),
                tabPanel("Zombies", tableOutput("zombie_table"))
    )
    
  )
)

# Define server logic for random distribution app ----
server <- function(input, output) {
  
  # heist table
  output[['heist_table']] <- function(){
    heist_df |>
      kbl(
        format.args = list(big.mark = ","),
        caption = 'Heist Event Rewards'
      ) |>
      add_header_above(c(" " = 1, "Level Reward" = 2, "Cumulative Reward" = 3)) |>
      kable_styling(
        full_width = FALSE,
        bootstrap_options = c('striped', 'hover', 'condended'),
        fixed_thead = TRUE) |>
      scroll_box(height = "500px")
  }
  
  # zombie table
  output[['zombie_table']] <- function(){
    zombie_df |>
      kbl(
        format.args = list(big.mark = ","),
        caption = 'Zombie Event Rewards'
      ) |>
      add_header_above(c(" " = 1, "Level Reward" = 2, "Cumulative Reward" = 4)) |>
      kable_styling(
        full_width = FALSE,
        bootstrap_options = c('striped', 'hover', 'condended'),
        fixed_thead = TRUE) |>
      footnote(
        general = 'Each wave you gain TP equal to the wave you completed, e.g. Wave 8 gives you 8 TP.'
      ) |>
      scroll_box(height = "500px")
  }
  
}

# Create Shiny app ----
shinyApp(ui, server)



