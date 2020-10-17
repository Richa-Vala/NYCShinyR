# Meteorite visuatlization - UI File
shinyUI(
  dashboardPage(
    #header + skin + sidebar panel#### 
    skin = 'green',
    dashboardHeader(
      title = "Instacart Marke Basket Analysis",
      titleWidth = 450
    ),
    #sidebar panel 
    dashboardSidebar(
      sidebarUserPanel("Richa Vala",
                       image = "https://content.fortune.com/wp-content/uploads/2015/01/instacart-web1.jpg?resize=1200,600"),
      sidebarMenu(
        menuItem("Introduction", tabName = "intro", icon = icon("dove")),
        menuItem("Exploration/Analysis", tabName = "explore", icon = icon("map")),
        menuItem("Conclusion", tabName = "conc", icon = icon("box-open")),
        menuItem("Data", tabName = "data", icon = icon("database")),
        menuItem("Author", tabName = "self", icon = icon("user-graduate"))
      )
    ),
    
    #Introduction####
    dashboardBody(
      tabItems(
        #Intro
        tabItem(
          tabName = 'intro',
          fluidPage(
            box(
              tags$div(h1("Goal : To briefly explore the dataset, highlight the patternsand why it is important to Instacart")),
              tags$p(
                HTML('<p> Market Basket Analysis is one of the key techniques used by large retailers to uncover associations between items.
                     Instacart, a grocery ordering and delivery app, allows users to place grocery order through their website or app which are then fulfilled
                     by a personal shopper.In 2017 Instacart open-sourced 3 million grocery orders. This anonymized dataset contains a sample of over 3 million grocery
                     orders from more than 200,00 Instacart users. Instacart’s data science team plays a big part in providing this delightful shopping experience. 
                     Currently they use transactional data to develop models that predict which products a user will buy again, try for the first time, or add to their 
                     cart next during a session.The users are anonymized. There’s no demographics data — no gender, age. Instacart 
                     explained on its blog post that it’s too hard to protect privacy of users if such data is included. In real life, Instacart also
                     does not collect such data, but does use code scripts to analyze and infer gender from usernames.</p>'),
                
                tags$p("reference: https://tech.instacart.com/3-million-instacart-orders-open-sourced-d40d29ead6f2"),
                tags$p("reference: https://www.kaggle.com/c/instacart-market-basket-analysis")
                
              ) 
          )
            )
        ),
        #Explore####
        tabItem(tabName = "explore",
                  tabsetPanel(
                    tabPanel(
                      "When people order most?",
                      fluidRow(
                        column(8, plotlyOutput("popday", width = "600px", height = "600px"))
                      ),
                      fluidRow(
                        h2("Summary"),
                        "To be filled"
                      )
                    ),  
                    
                    tabPanel(
                      "What day people order most?",
                      fluidRow(
                        column(8, plotlyOutput("pophour",width = "600px",height = "600px"))
                      ),
                      fluidRow(
                        selectizeInput('partofday', 'Please select time of day:', c("Morning","Afternoon", "Evening"))
                      ),
                      fluidRow(
                        h2("Summary"),
                        "To be filled"
                      )
                    ),
                   
                   tabPanel(
                      "When do they order again?",
                      fluidRow(
                        column(8, plotlyOutput("orderagain",width = "600px",height = "600px"))
                      ),
                      fluidRow(
                        h2("Summary"),
                        "To be filled"
                      )
                    ),
                   
                   tabPanel(
                     "What is the proportion of the repeat products users prefer?",
                     fluidRow(
                       column(6, plotlyOutput("repeatprod1",width = "600px",height = "600px")),
                       column(4, plotlyOutput("repeatprod2",width = "600px",height = "600px"))
                       ),
                     fluidRow(
                       h2("Summary"),
                       "To be filled"
                     )
                   )
              )                 
        ),
        #Conclusion####
        tabItem(tabName = "conc",
                fluidRow(box(
                  background = 'light-blue',
                  h2("Conclusions"),
                  tags$p("- To be filled"),
                  tags$p("To be filled "),
                  tags$p("To be filled "),
                  tags$p("To be filled "),
                  tags$p("To be filled"),
                  width = 12)
                )
        ),
        #dataset####
        tabItem(tabName = "data",
                fluidRow(
                    DT::dataTableOutput("table")
                )
                # tags$p("https://www.kaggle.com/c/instacart-market-basket-analysis/data")
        ),
        #self-intro####
        tabItem(tabName = "self",
                fluidRow(
                  column(4,
                         img(src="./richavala.jpg",
                             width=500,
                             height=600)
                  ),
                  column(8,box(
                    background = 'blue',
                    h2("Richa Vala"),
                    tags$p("To be filled "),
                    tags$a(href = 'https://www.linkedin.com/in/richavala/'),
                    width = 6,
                    height = 600)))
        )
      )
    )
  )
)