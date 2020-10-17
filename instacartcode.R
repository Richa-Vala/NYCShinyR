library(knitr)
library(tidyr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(lubridate)
library(plyr)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)

# “The Instacart Online Grocery Shopping Dataset 2017”, Accessed from Kaggle
# https://www.kaggle.com/c/instacart-market-basket-analysis/discussion
 
# Load the .csv files into dataframes         
orders <- readr::read_csv("orders.csv")
tr_orders <- readr::read_csv("tr_orders.csv")

# order_products_prior <- readr::read_csv("order_products__prior.csv")
tr_orderproducts_prior <- readr::read_csv("tr_order_products__prior.csv")

order_products_train <- readr::read_csv("order_products__train.csv")
  
products <- readr::read_csv("products.csv")
aisles <- readr::read_csv("aisles.csv")
department <- readr::read_csv("departments.csv")

# Look at the datasets
head(tr_orders)
dim(tr_orders)
glimpse(tr_orders)

head(products)
dim(products)
glimpse(products)

head(aisles)
dim(aisles)
glimpse(aisles)

head(department)
dim(department)
glimpse(department)

head(order_products_train)
dim(order_products_train)
glimpse(order_products_train)

head(tr_orderproducts_prior)
dim(tr_orderproducts_prior)
glimpse(tr_orderproducts_prior)

# Clean the data
# change class of ordprod$reordered - numeric to factor 
# ordprod <- ordprod %>% mutate(reordered = as.factor(reordered))
order_products_train <- order_products_train %>% mutate(reordered = as.factor(reordered))
# orders <- orders%>% mutate(order_dow = as.factor(order_dow))
tr_orders <- tr_orders %>% mutate(order_dow = as.factor(order_dow))
orders <- orders%>% mutate(order_hour_of_day=as.factor(order_hour_of_day))
levels(orders$order_dow)  # sunday is 0, Monday is 1

#Missing Values

sum(is.na(tr_orders))
# #To find all the rows in a data frame with at least one NA::multiple ways
# which(is.na(orders$days_since_prior_order))
# unique(unlist(lapply(orders, function(x) which (is.na(x)))))
# colSums(is.na(orders))
# orders[!complete.cases(orders),]
# visualize missing values using VIM package
# aggr(orders)


###############################################################################################################3

# Summary Statistics
# Original Data

tot_users = orders %>% summarise(.,count_tot = length(unique(user_id)))
tot_users
# Range of order_number
tmp = orders %>% filter(.,order_number != 1)
range = max(tmp$order_number) -min(tmp$order_number)
range
# Every 3-4 days, a user places an order
order_placed = round(365/range)
order_placed  

# Total orders in 2017
tot_order = dim(orders)[1]
tot_order

#### Plots ######

#******with trimmed data******#

# Plot#5 - Popular department name




tmp = products %>% left_join(department)
tmp = tmp %>% left_join(order_products_train)
x = tmp %>% group_by(., by = c(product_id.department_id)) %>% summarise

#To use for Data Table
dt_table <- tr_orders%>%kable(.,)%>%head(.,n=10)
dt_table

# What day people place most orders -- Plot # 2
g <- ggplot(data = tr_orders,aes(x=order_dow))
g+geom_bar(fill="darkolivegreen3")+labs(title="Popular day of week for placing order by users",
                                        x="Day of Week",
                                        y="count")
ggsave("dayofweek.png")



g <- ggplot(data = tr_orders,aes(x=order_hour_of_day))
g+geom_bar(fill="darkolivegreen3")+labs(title="Popular hour of the day for placing order by users",
                                        x="Hour of week",
                                        y="count")
df_hourtable <- tr_orders%>%group_by(.,order_hour_of_day)%>%summarise(hour_count=n())
df_hour<-kable(df_hourtable)

####Number of products per order


g <- ggplot(data = df_num,aes(x=cart_items))
#zoom <- coord_cartesian(xlim=c(0,80)) 
g+geom_histogram(stat = "count", fill="darkolivegreen3") +labs(title="Number of Products per order",
                                      x="Number of orders",
                                      y="count")





##### Best Selling Products - Top 10
df <- order_products_train %>% group_by(.,product_id)%>%summarise(.,n_items = n()) %>%top_n(.,10,n_items)%>%
  left_join(select(products,product_id,product_name),by="product_id") %>%
  arrange(desc(n_items)) 

dt_table <- kable(tmp)  ## for dataTable

df%>%ggplot(aes(x=reorder(product_name,-n_items),y=n_items))+
  geom_bar(stat="identity",fill="red") + 
  theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())




##### Worst Selling Products - Bottom 10 , from tally() , got 7884 sold once 

tmp <- order_products_train %>% 
  group_by(product_id) 

tmp %>%summarize(count = n()) %>% 
  top_n(-10, wt = count) %>%
  left_join(select(products,product_id,product_name),by="product_id") %>%
  arrange(desc(count))

dt_table <- kable(tmp)  ## for dataTable

tmp%>%ggplot(aes(x=reorder(product_name,-count),y=count))+
  geom_bar(stat="identity",fill="red") + 
  theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())

tmp1 <- tmp%>%select(.,2,3)
set.seed(1234)
wordcloud2(word_cloud$product_name, freq=word_cloud$n,min.freq=1,max.words=,size=2,color="random-light",
           random.order = FALSE,scale=c(1.5,0.25),rot.per = 0.35,backgroundColor = "grey")

set.seed(1234)
wordcloud2(tmp1, size = 1, minSize = 1, gridSize =  0,
           fontFamily = 'Segoe UI', fontWeight = 'bold',
           color = 'random-dark', backgroundColor = "white",
           minRotation = -pi/4, maxRotation = pi/4, shuffle = TRUE,
           rotateRatio = 0.4, shape = 'circle', ellipticity = 0.65,
           widgetsize = NULL, figPath = NULL, hoverFunction = NULL)

# doesn't make sense to use bar chart for worst 10
###########################################################

#########  How many orders were ordered previously too ########

#tr_orderproducts <- tr_orderproducts%>%mutate(reordered = as.factor((reordered)))
#levels(tr_orderproducts) <- gsub("0", "no", levels(tr_orderproduct$reordered,c('1'="yes", '0'="no"))

reorder <- order_products_train%>% group_by(reordered) %>% summarize(count = n())%>%mutate(reordered = as.factor(reordered))%>%mutate(ration = count/sum(count))
reorder
g <- ggplot(tr_orderproducts,aes(x=reordered,y=count,fill-reordered))+geom_bar(stat="identity")    #######solve the error
g+labs(title="Number of orders people ordered again",x="reordered",y="count")

#About 59% of ordered products are previously ordered by customers. The plot below shows the products that are usually most reordered by probability.
                                                                                 

                           




