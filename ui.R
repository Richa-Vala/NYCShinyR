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
      sidebarUserPanel("Richa Vala"
                       ),
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
              #image = "https://content.fortune.com/wp-content/uploads/2015/01/instacart-web1.jpg?resize=1200,600"
              tags$div(h2("Goal : To briefly explore the dataset, highlight the patterns and why it is important to Instacart")),
              br(),
              tags$p(
                HTML('<p> Market Basket Analysis is one of the key techniques used by large retailers to uncover associations between items.
                     Instacart, a grocery ordering and delivery app, allows users to place grocery order through their website or app which are then fulfilled
                     by a personal shopper.In 2017 Instacart open-sourced 3 million grocery orders. This anonymized dataset contains a sample of over 3 million grocery
                     orders from more than 200,00 Instacart users.
                     Instacart’s data science team plays a big part in providing this delightful shopping experience. 
                     Currently they use transactional data to develop models that predict which products a user will buy again, try for the first time, or add to their 
                     cart next during a session.The users are anonymized. There’s no demographics data — no gender, age. Instacart 
                     explained on its blog post that it’s too hard to protect privacy of users if such data is included. In real life, Instacart also
                     does not collect such data, but does use code scripts to analyze and infer gender from usernames.<p>'),
                br(),
                br(),
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
                      "What day people order most?",
                      fluidRow(
                        column(8, plotlyOutput("popday", width = "600px", height = "600px"))
                      ),
                      fluidRow(
                        h2("Summary"),
                        "To be filled"
                      )
                    ),  
                    
                    tabPanel(
                      "Does order volume change throughout the day?",
                      fluidRow(
                        column(6, plotlyOutput("pophour",width = "600px",height = "600px")),
                        column(4, plotlyOutput("stpart",width = "600px",height = "600px"))
                      ),
                      fluidRow(
                        selectizeInput('partofday', 'Please select time of day:', c("Morning","Afternoon", "Evening"))
                      ),
                      fluidRow(
                        h2("Summary"),
                        "People do more shopping on weekend (assuming 1 for Saturday and 0 for Synday). The 
                        volume of order increases sharply from early morning till 11 am."
                      )
                    ),
                   
                   tabPanel(
                      "When do they order again?",
                      fluidRow(
                        column(8, plotlyOutput("orderagain",width = "600px",height = "600px"))
                      ),
                      fluidRow(
                        h2("Summary"),
                        "Generally, the users place their order at day 5 or at day 30"
                      )
                    ),
                   
                   tabPanel(
                     "What is the count/poportion of the repeat products?",
                     fluidRow(
                       column(6, plotlyOutput("repeatprod1",width = "600px",height = "600px")),
                       column(4, plotlyOutput("repeatprod2",width = "600px",height = "600px"))
                       ),
                     fluidRow(
                       h2("Summary"),
                       "To be filled"
                     )
                   ),
                   
                  tabPanel(
                     "How large are orders?",
                     fluidRow(
                       column(6, plotlyOutput("numitems",width = "600px",height = "600px"))
                       ),
                     fluidRow(
                       h2("Summary"),
                       "To be filled"
                     )
                   ),
              
                  tabPanel(
                    " What are best selling products?",
                    fluidRow(
                      column(6, plotlyOutput("best",width = "600px",height = "600px"))
                      ),
                    fluidRow(
                      h2("Summary"),
                      "Their first top 10 selling items are fresh produce, especially those 
                       which are organic."
                    )
                  ),
                  
                  tabPanel(
                    "What are the top aisles/departments?",
                    fluidRow(
                      column(6, plotlyOutput("da1",width = "600px",height = "600px")),
                      column(6, plotlyOutput("da",width = "600px",height = "600px"))
                    ),
                    fluidRow(
                      selectizeInput('department', 'Please select department to filter:', 
                                     c("produce","dairy eggs", "snacks","beverages","bakery"),
                                     selected=NULL)
                     ),
                    fluidRow(
                      h2("Summary"),
                      "The fresh fruits and vegetables from the produce department are more popular."
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
        #data####
        tabItem(tabName = "data",
                tabsetPanel(
                  tabPanel(
                    "orders",
                    fluidRow(
                      DT::dataTableOutput('order1')
                    )
                  ), 
                 tabPanel(
                  "products",
                  fluidRow(
                      DT::dataTableOutput('product1')
                      )
                 ), 
                  tabPanel(
                    "aisles",
                    fluidRow(
                      DT::dataTableOutput('aisles1')
                    )
                  ),      
                  tabPanel(
                    "departments",
                    fluidRow(
                      DT::dataTableOutput('department1')
                        )
                  ),     
                  tabPanel(
                    "order_products",
                    fluidRow(
                      DT::dataTableOutput('train1')
                        )
                      )
                     
                  )
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