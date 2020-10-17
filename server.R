function(input, output) {
  
  output$popday = renderPlotly({
    
    tr_orders %>% 
      ggplot(.,aes(x=order_dow)) + 
      geom_bar(fill="darkolivegreen3") + 
      labs(title="Popular day of week for placing order",
           x="Day of Week",
           y="count")
  })
  
  
  output$pophour = renderPlotly({
    
    tr_orders %>% 
      filter(parts_of_day == input$partofday) %>%
      ggplot(.,aes(x=order_hour_of_day)) + 
      geom_bar(fill="darkolivegreen3") + 
      labs(title="Popular hour of the day for placing order",
           x="Hour of week",
           y="count")
  })
  
  output$table = DT::renderDataTable({
    
    tr_orders %>% 
      group_by(.,order_hour_of_day) %>%
      summarise(hour_count=n()) %>% 
      datatable()
  })
  #close tab for shinyServer                       
}