# Meteorite visuatlization - UI File
shinyUI(
  dashboardPage(
    #header + skin + sidebar panel#### 
    skin = 'yellow',
    dashboardHeader(
      title = "Instacart"
    ),
    #sidebar panel 
    dashboardSidebar(
      sidebarUserPanel("Richa Vala",
                       image = "https://content.fortune.com/wp-content/uploads/2015/01/instacart-web1.jpg?resize=1200,600"),
      sidebarMenu(
        menuItem("Introduction", tabName = "intro", icon = icon("dove")),
        menuItem("Exploration/Analysis", tabName = "explore", icon = icon("map")),
        # selectizeInput('popular',"Popular day", choices = c("aaaa","bbbb")),
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
              background = 'light-blue',
              h2('Exploratory Data Analysis and Visualization - Which products will an Instacart consumer purchase again?'),
              h3('Market Basket Analysis is one of the key techniques used by large retailers to uncover associations between items.'),
              tags$p("It works by looking for combinations of items that occur together frequently in transactions."),#plotlyOutput("lineplot"),
              h3('Facts about Plastic Pollution We Absolutely Need to Know: '),
              tags$p("To put it another way, it allows retailers to identify relationships between the items that people buy."),
              tags$p("Instacart lets you shop from local grocery stores online, then sends a “personal shopper” to fulfill and deliver your order to you the same day"),
              tags$p("Unlike other grocery delivery services, the company doesn’t stockpile fresh produce in a massive warehouse."),
              tags$p("Instead, their shoppers shop at major grocery stores in your area like Kroger, Shaw’s, and Costco through its website,"),
              tags$p("and then sends your order to one of its part-time employees.This personal shopper goes to the store,"),
              tags$p("picks up everything on your list, and then drives it to you in their own car. Think of it as the Uber of grocery delivery!"),
              # img(src=""
              #     ,width="50%"),
              h3('experience while partnering with iconic retailers to offer more selection and value to customers,” said Apoorva Mehta, Founder and CEO of Instacart.'),
              #tags$iframe(src="https://www.youtube.com/embed/ju_2NuK5O-E",
              #           width="653",height="367"),
              h3('Variables of Dataset:'),
              #tags$p(', Population, Coastal Population, Economic Development, Continent, Geographical Feature, GDP Per Capita, Plastic Waste Generation, Plastic Waste Per Capita, Mismanaged Plastic Generation, Mismanaged Plastic Per Capita, Mismanaged Plastic Share, Inadequately Managed Plastic Waste Share(Highest Risk), 2008-2010 Average GDP Per Capita Growth Rate, 3 Years GDP Growing Status'),
              #tags$p("Note: Mismanaged waste: Material that is either littered or inadequately disposed (the sum of littered and inadequately disposed waste), which could eventually enter the ocean via inland waterways, wastewater outflows, and transport by wind or tides and has much higher risk of entering the ocean and contaminating the environment."),
              # tags$p("      Inadequately managed waste: Waste is not formally managed and includes disposal in dumps or open, uncontrolled landfills, where it is not fully contained. Inadequately managed waste has high risk of polluting rivers and oceans. This does not include 'littered' plastic waste, which is approximately 2% of total waste."),
              h3('Goal of the analysis: Discovering relationships between features of countries and plastic pollution.'),
              tags$p('<- Click items on the side bar to explore'),
              width = 12
            )
          )
        ),
        #Explore####
        tabItem(tabName = "explore",
                  tabsetPanel(
                    tabPanel(
                      "Popular Day of Week",
                      fluidRow(
                        column(8, plotlyOutput("popday", width = "600px", height = "600px"))
                      ),
                      fluidRow(
                        h2("Summary"),
                        "To be filled"
                      )
                    ),  
                    
                    tabPanel(
                      "Popular hour of Week",
                      fluidRow(
                        column(8, plotlyOutput("pophour",width = "600px",height = "600px"))
                      ),
                      fluidRow(
                        selectizeInput('partofday', 'Please select time of day:', c("Morning","Afternoon", "Evening"))
                      )
                    )
                    # tabPanel("Table",
                    #          fluidRow(
                    #            DT::dataTableOutput('table')
                    #            )
                    # )
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