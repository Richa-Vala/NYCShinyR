# UI File
shinyUI(
  dashboardPage( 
    skin = 'green',
    dashboardHeader(
      title = "Instacart Market Basket Exploratory Analysis",
      titleWidth = 450
    ),
    #sidebar panel 
    dashboardSidebar(
      sidebarUserPanel("Richa Vala"),
      sidebarMenu(
        menuItem("Introduction", tabName = "intro", icon = icon("dove")),
        menuItem("Data", tabName = "data", icon = icon("database")),
        menuItem("Exploration/Analysis", tabName = "explore", icon = icon("map")),
        menuItem("Conclusion", tabName = "conc", icon = icon("box-open")),
        menuItem("Author", tabName = "self", icon = icon("user-edit"))
      )
    ),
    dashboardBody(
      tabItems(
        #Intro
        tabItem(
          tabName = 'intro',
          fluidPage(
            box(
              
              tags$div(h2("Goal : To briefly explore the dataset, highlight the patterns and why it is important to Instacart")),
              br(),
              tags$p(
                HTML('<p>Instacart, a grocery ordering and delivery app, allows users to place grocery order through their website or app which are then fulfilled
                     by a personal shopper.In 2017 Instacart open-sourced 3 million grocery orders. This anonymized dataset contains a sample of over 3 million grocery
                     orders from more than 200,00 Instacart users.
                     Instacart’s data science team plays a big part in providing this delightful shopping experience. 
                     Currently they use transactional data to develop models that predict which products a user will buy again, try for the first time, or add to their 
                     cart next during a session.The users are anonymized. There’s no demographics data — no gender, age. Instacart 
                     explained on its blog post that it’s too hard to protect privacy of users if such data is included. In real life, Instacart also
                     does not collect such data, but does use code scripts to analyze and infer gender from usernames.
                     The main purpose of this app is to provide a general overview of Instacart. Through this visualization,exploratory Data analysis was 
                     performed in order to derive insights from customer data.<p>'),
                br(),
                br(),
                tags$p("reference: https://tech.instacart.com/3-million-instacart-orders-open-sourced-d40d29ead6f2"),
                tags$p("reference: https://www.kaggle.com/c/instacart-market-basket-analysis")
                
              ) 
          )
            )
        ),
        
        tabItem(tabName = "explore",
                  tabsetPanel(
                    tabPanel(
                      "What day people order most?",
                      fluidRow(
                        column(8, plotlyOutput("popday", width = "600px", height = "600px"))
                      ),
                      fluidRow(
                        h2("Insight"),
                        "People do more shopping on day 0 and day 1. There is not a significant difference 
                        between other days of the week either."
                      )
                    ),  
                    
                    tabPanel(
                      "Does order volume changes throughout the day?",
                      fluidRow(
                        column(6, plotlyOutput("pophour",width = "600px",height = "600px")),
                        column(4, plotlyOutput("stpart",width = "600px",height = "600px"))
                      ),
                      fluidRow(
                       selectizeInput('partofday', 'Please select time of day:', c("Morning","Afternoon", "Evening"))
                      ),
                      fluidRow(
                        h2("Insight"),
                        "The volume of order increases sharply from early morning and majority of the purchases
                        are made between 9 am and 4 pm."
                      )
                    ),
                   
                   tabPanel(
                      "When do they order again?",
                      fluidRow(
                        column(8, plotlyOutput("orderagain",width = "600px",height = "600px"))
                      ),
                      fluidRow(
                        h2("Insight"),
                        "Generally, the customers place their order either weekly on days 4,7,or 30 i.e.
                         monthly."
                      )
                    ),
                   
                   tabPanel(
                     "How large are each order?",
                     fluidRow(
                       column(6, plotlyOutput("numitems",width = "600px",height = "600px"))
                     ),
                     fluidRow(
                       h2("Insight"),
                       "We can observe from the plot that customers usually order between 4-7 products."
                     )
                   ),
                   
                   tabPanel(
                     "How many reorders and repeat items?",
                     fluidRow(
                       column(6, plotlyOutput("repeatprod1",width = "600px",height = "600px")),
                       column(4, DT::dataTableOutput("repeatprod2",width = "400px",height = "600px"))
                       ),
                     fluidRow(
                       h2("Insight"),
                       "Around 60% are reorders. The highest proportion of 
                       top repeated items are dairy products"
                     )
                   ),
                   
                  
              
                  tabPanel(
                    " What are the best selling products?",
                    fluidRow(
                      column(6, plotlyOutput("best",width = "600px",height = "600px"))
                      ),
                    fluidRow(
                      h2("Insight"),
                      "We can observe that the first top 10 selling products are fresh produce, especially those 
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
                      h2("Insight"),
                      "The fresh fruits and vegetables from the produce department are more popular."
                    )
                  )
                  
          )
        ),
        
        #Conclusion####
        tabItem(tabName = "conc",
                fluidRow(box(
                  h2("Conclusions:"),
                  tags$p("- Most orders are on Saturday and Sunday."),
                  tags$p("- The peak time is between 9 am - 4pm and slowly starts to decrease."),
                  tags$p("- The reordering spikes can be seen mostly at days 4, 7 or 30."),
                  tags$p("- Around 60% are reorders.The highest proportion of 
                            top repeated items are dairy products."),
                  tags$p("- Customers usually order between 4-6 products."),
                  tags$p("- First top 10 selling items are fresh produce."),
                  tags$p("- The fresh fruits and vegetables from the produce department are 
                            more popular."),
                  width = 12),
                  box(
                    h2("Future Analysis:"),
                    tags$p("- A dataset of this size can be further explored to draw out richer insights to help make better informed decisions."),
                    tags$p("- Whether customers buy different products at different times or not."),
                    tags$p("- How many orders were given after how many days and what those  
                              products are?"),
                    tags$p("- When days of the week, the top selling products mostly get purchased?"),
                    tags$p("- Which products are likely to be purchased in a combination of two 
                              or move. ")
                  )
                ),
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
                   box(
                    h2("Richa Vala"),
                    tags$p("My name is Richa Vala. I graduated with a Master of Science in Bioinformatics Engineering 
                    from University of Illinois at Chicago. I have multiple years of experience analyzing sales
                    and marketing data from previous."),
                    (href = 'https://www.linkedin.com/in/richavala'),
                    br(),
                    (img(src = "richavala.jpg",height="50%", width="50%", align="center")),
                    width = 6,
                   height = 500,
                   )
                )
              )  
        
         )
      )
    )
 )
