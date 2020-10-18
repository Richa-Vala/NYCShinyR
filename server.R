function(input, output) {
  
  output$popday = renderPlotly({
    
    
    g <- ggplot(data = tr_orders,aes(x=as.factor(order_dow)))
    g+geom_bar(color="darkolivegreen3",fill="white")+labs(title="What day of week people order most?",
                                            x="Day of Week",
                                            y="count")
    
  })
  
  
  output$pophour = renderPlotly({
    
    tr_orders %>% 
      filter(parts_of_day == input$partofday) %>%
      ggplot(.,aes(x=order_hour_of_day)) + 
      geom_bar(color = "darkolivegreen3",fill="white") + 
      labs(title= "What hour of day people order most?",
           x="Hour of the day",
           y="count")
  })
  
  output$stpart = renderPlotly({
      
      g <- tr_orders %>% ggplot(.,aes(x=as.factor(order_dow)))
      g+geom_bar(aes(fill=parts_of_day),position = "dodge")+
        scale_fill_brewer(palette="Spectral")+labs(title= "What hour of day people order most?",
                                                   x="Day of Week",
                                                   y="count")
     
  })
  
  output$orderagain = renderPlotly({
    
    df_freq = tr_orders %>% ggplot(aes(x=days_since_prior_order))
    df_freq+geom_histogram(stat = "count",color ="darkolivegreen3",fill="white")+
      labs(title="When do they order again",
           x="days_since_prior_order",
           y="count")
  })
  
  output$repeatprod1 = renderPlotly({
    
    df <- order_products_train %>% 
      group_by(reordered) %>% 
      summarise(n_reorder = n())
    
    g <- ggplot(df, aes(x=as.factor(reordered),y=n_reorder))
    g+geom_col(color="darkolivegreen3",fill="white")+labs(title="Repeat Items In Users Cart",
                                            x="reordered",
                                            y="count")
  })
  
  test <- order_products_train %>% 
    group_by(reordered) %>% 
    summarise(n_reorder = n()) %>%
    mutate(ratio = n_reorder/sum(n_reorder))
  
  output$repeatprod2 = renderPlotly({
  g <- ggplot(test, aes(x=as.factor(reordered,y=ratio)))
  g+geom_col(color="darkolivegreen3",fill="white")+labs(title="Repeat Items In Users Cart",
                                          x="reordered",
                                          y="proportion")
  
  })
  
  df_num = order_products_train %>% 
    group_by(order_id) %>% 
    summarise(cart_items = last(add_to_cart_order))
  
  output$numitems = renderPlotly({
    g <- ggplot(df_num, aes(x=cart_items))
    g+geom_histogram(binwidth = 4,color="darkolivegreen3",fill="white")+labs(title="How many items per order ",
                                                                             x="cart_items",
                                                                             y="count")
   })
  
  df <- order_products_train %>% group_by(.,product_id)%>%summarise(.,n_items = n()) %>%top_n(.,10,n_items)%>%
    left_join(select(products,product_id,product_name),by="product_id") %>%
    arrange(desc(n_items))  
  
  output$best = renderPlotly({
  df%>%ggplot(aes(x=reorder(product_name,-n_items),y=n_items))+
    geom_bar(stat="identity",color="darkolivegreen3",fill="white") + 
    theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())
  
  })
  
  output$da1 = renderPlotly({ 
    all_csvs <- tr_orderproducts_prior %>% 
      left_join(tr_orders, by = "order_id") %>% 
      left_join(products, by = "product_id") %>% 
      left_join(department, by = "department_id") %>%
      left_join(aisles,by = "aisle_id") 
    
    all_csvs %>%
      group_by(department, aisle) %>% 
      count() %>% 
      ungroup() %>%
      arrange(desc(n)) %>% 
      head(10) %>% 
      ggplot(aes(reorder(aisle, n), y = n, 
                 fill = reorder(department, desc(n)))) +
      geom_bar(stat = "identity", col = "black") +
      labs(x = NULL, y = "count", fill = "Department",
           caption = "Aisles") +scale_fill_manual(values=c("bisque","aliceblue", "darkseagreen1", "azure3","darkgoldenrod2"))+
      theme(axis.text.x=element_text(angle=90, hjust=1),
            axis.title.x = element_blank())
  })
  
 output$da = renderPlotly({ 
   all_csvs <- tr_orderproducts_prior %>% 
     left_join(tr_orders, by = "order_id") %>% 
     left_join(products, by = "product_id") %>% 
     left_join(department, by = "department_id") %>%
     left_join(aisles,by = "aisle_id") 
   
  all_csvs %>% filter(department == input$department) %>%
    group_by(department, aisle) %>% 
    count() %>% 
    ungroup() %>%
    arrange(desc(n)) %>% 
    head(10) %>% 
    ggplot(aes(reorder(aisle, n), y = n, 
               fill = reorder(department, desc(n)))) +
    geom_bar(stat = "identity", col = "black") +
    labs(x = NULL, y = "count", fill = "Department",
         caption = "Aisles") +scale_fill_manual(values=c("bisque","aliceblue", "darkseagreen1", "azure3","darkgoldenrod2"))+
    theme(axis.text.x=element_text(angle=90, hjust=1),
          axis.title.x = element_blank())
 })
  
  
  output$order1 = DT::renderDataTable({
    
    head(tr_orders)
      })
  
  output$product1 = DT::renderDataTable({
    
    head(products)
  })
    
  output$aisles1 = DT::renderDataTable({
    
    head(aisles)
  })
  
  output$department1 = DT::renderDataTable({
    
    head(department)
  })
  
  output$train1 = DT::renderDataTable({
    
    head(order_products_train)
  })
  
  #close tab for shinyServer                       
}