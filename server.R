function(input, output) {
  
  output$popday = renderPlotly({
    
    
    g <- ggplot(data = tr_orders,aes(x=as.factor(order_dow)))
    g+geom_bar(color="darkolivegreen3",fill="white")+labs(title="When people order most?",
                                            x="Day of Week",
                                            y="count")
    
  })
  
  
  output$pophour = renderPlotly({
    
    tr_orders %>% 
      filter(parts_of_day == input$partofday) %>%
      ggplot(.,aes(x=order_hour_of_day)) + 
      geom_bar(color = "darkolivegreen3",fill="white") + 
      labs(title= "Which day people order most?",
           x="Hour of week",
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
      summarise(n_reorder = n()) %>%
      mutate(ratio = n_reorder/sum(n_reorder))
    
    g <- ggplot(df, aes(x=reordered,y=n_reorder))
    g+geom_col(color="darkolivegreen3",fill="white")+labs(title="Repeat Items In Users Cart",
                                            x="reordered",
                                            y="count")
  })
  
  df <- order_products_train %>% 
    group_by(reordered) %>% 
    summarise(n_reorder = n()) %>%
    mutate(ratio = n_reorder/sum(n_reorder))
  
  output$repeatprod2 = renderPlotly({
  g <- ggplot(df, aes(x=reordered,y=ratio))
  g+geom_col(color="darkolivegreen3",fill="white")+labs(title="Repeat Items In Users Cart",
                                          x="reordered",
                                          y="proportion")
  
  })
  
  output$table = DT::renderDataTable({
    
    tr_orders %>% 
      group_by(.,order_hour_of_day) %>%
      summarise(hour_count=n()) %>% 
      datatable()
  })
  #close tab for shinyServer                       
}