function(input, output) {
  
  output$popday = renderPlotly({
    
    
    g <- ggplot(data = tr_orders,aes(x=as.factor(order_dow)))
    g+geom_bar(color="darkolivegreen3",fill="white")+labs(title="What Day of Week Users Order Most?",
                                            x="Day of Week",
                                            y="Count")
    
  })
  
  
  output$pophour = renderPlotly({
    
    tr_orders %>% 
      ggplot(.,aes(x=order_hour_of_day)) + 
      geom_bar(color = "darkolivegreen3",fill="white") + 
      labs(title= "What Hour of Day Users Order Most?",
           x="Hour of the day",
           y="Count")
  })
  
  output$stpart = renderPlotly({
      
      g <- tr_orders %>%filter(parts_of_day == input$partofday) %>%ggplot(.,aes(x=as.factor(order_dow)))
      g+geom_bar(aes(fill=parts_of_day),position = "dodge")+
        scale_fill_brewer(palette="Spectral")+labs(title= "Distribution of Purchases by Part of Day",
                                                   x="Day of Week",
                                                   y="Count",fill = "part of day")
      
      #+theme(axis.title.x = element_blank())
  
      #+scale_x_discrete(labels=c("0"="Sat","1"="Sun","2"="Mon","3"="Tue","4"="Wed","5"="Thur","6"="Fri"))
     
  })
  
  output$orderagain = renderPlotly({
    
    df_freq = tr_orders %>% ggplot(aes(x=days_since_prior_order))
    df_freq+geom_histogram(binwidth = 1.5,color ="darkolivegreen3",fill="white")+
      labs(title="When Do Users Order Again",
           x="Days_since_prior_order",
           y="Frequency")
  })
  
  df_num = order_products_train %>% 
    group_by(order_id) %>% 
    summarise(cart_items = last(add_to_cart_order))
  
  output$numitems = renderPlotly({
    g <- ggplot(df_num, aes(x=cart_items))
    g+geom_histogram(binwidth = 4,color="darkolivegreen3",fill="white")+labs(title="Number of Products Per Order ",
                                                                             x="Number of Products",
                                                                             y="Frequency")
  })
  
  output$repeatprod1 = renderPlotly({
    
    df <- order_products_train %>% 
      group_by(reordered) %>% 
      summarise(n_reorder = n())%>%
      mutate(ratio = round(n_reorder/sum(n_reorder),2))
    
    g <- ggplot(df, aes(x=as.factor(reordered),y=ratio))
    g+geom_col(color="darkolivegreen3",fill="white")+labs(title="Distribution of Reorders",
                                            x="Reordered",
                                            y="Proportion")
  })
  #### Table for repeat items
  df_repeat = all_csvs %>% 
    group_by(product_name) %>% 
    summarize(proportion = round(mean(reordered),3), 
              count = n()) %>% 
    filter(count > 40) %>% 
    arrange(desc(proportion)) %>% 
    select(product_name, proportion) %>% 
    head(10) 
  
  output$repeatprod2 = DT::renderDataTable({
    
    df_repeat
  })
  
  
  df <- order_products_train %>% group_by(.,product_id)%>%summarise(.,n_items = n()) %>%top_n(.,10,n_items)%>%
    left_join(select(products,product_id,product_name),by="product_id") %>%
    arrange(desc(n_items))

  output$best = renderPlotly({
    df%>%ggplot(aes(x=reorder(product_name,-n_items),y=n_items))+
      geom_bar(stat="identity",color="darkolivegreen3",fill="white") + 
      theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())+labs(title="Best Selling Products",
                                                                                             x="Product Name",
                                                                                             y="Count")
    
  })

  output$da1 = renderPlotly({ 
  
    all_csvs %>%
      group_by(department, aisle) %>% 
      count() %>% 
      ungroup() %>%
      arrange(desc(n)) %>% 
      head(10) %>% 
      ggplot(aes(reorder(aisle, n), y = n, 
                 fill = reorder(department, desc(n)))) +
      geom_bar(stat = "identity", col = "black") +
      labs(title="Most Common Departments and Aisles",x = NULL, y = "count", fill = "Department",
           caption = "Aisles") +scale_fill_manual(values=c("bisque","aliceblue", "darkseagreen1", "azure3","darkgoldenrod2"))+
      theme(axis.text.x=element_text(angle=90, hjust=1),
            axis.title.x = element_blank())
  })
  
 output$da = renderPlotly({ 
  #with filter
   
  all_csvs %>% filter(department == input$department) %>%
    group_by(department, aisle) %>% 
    count() %>% 
    ungroup() %>%
    arrange(desc(n)) %>% 
    head(10) %>% 
    ggplot(aes(reorder(aisle, n), y = n, 
               fill = reorder(department, desc(n)))) +
    geom_bar(stat = "identity", col = "black") +
    labs(x = "Aisles", y = "count", fill = "Department",
         caption = "Aisles") +scale_fill_manual(values=c("bisque","aliceblue", "darkseagreen1", "azure3","darkgoldenrod2"))+
    theme(axis.text.x=element_text(angle=90, hjust=1),
          axis.title.x = element_blank())
 })
  
  ### Data Table
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