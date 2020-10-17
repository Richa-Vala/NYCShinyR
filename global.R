library(knitr)
library(tidyr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyverse)
library(plotly)
library(shinydashboard)
library(DT)
      
#orders <- readr::read_csv("archive/tr_order_products__prior.csv")
products <- readr::read_csv("archive/products.csv")
aisles <- readr::read_csv("archive/aisles.csv")
department <- readr::read_csv("archive/departments.csv")
#ordprod <- readr::read_csv("archive/order_products__train.csv")

tr_orders <- readr::read_csv("archive/tr_orders.csv")
tr_orderproducts_prior <- readr::read_csv("archive/tr_order_products__prior.csv")

order_products_train <- readr::read_csv("archive/order_products__train.csv")


# products <- readr::read_csv("archive/products.csv")
# aisles <- readr::read_csv("aisles.csv")
# department <- readr::read_csv("departments.csv")
