# https://population.un.org/wup/
# plots of urban and rural data for africa based on 2018 numbers

year = c(1950,	1955,	1960,	1965,	1970,	1975,	1980,	1985,	1990,	1995,	2000,	2005,	2010,	2015,	2020,	2025,	2030,	2035,	2040,	2045,	2050)
urban = c(32658.96,	41419.22,	53008.43,	66348.58,	
         82637.37,	103198.99, 128615.95,	160721.95,	200111.30,	241824.18,	
         285997.61,	341033.59,	408587.05,	491531.09,	587737.79	,
         698148.94,	824013.80,	966329.89,	1125161.52,	1299953.25,	1488920.05)
rural = c(196011.06,	212575.81,	232133.58,	256122.06,	283821.56,	314699.09,	351396.26,	
          392074.28,	434455.75,	481097.78,	531568.39,	583724.12,	640859.30,	702838.82,	
          764884.40,	824101.15,	879523.70,	930373.81,	975140.22,	1011608.08,	1038636.72)

library(ggplot2)


urban_small = urban/1000
rural_small = rural/1000
df = data.frame(year, urban_small, rural_small)

theme_white = function(base_size = 12, base_family = "") {
  
  theme_grey(base_size = base_size, base_family = base_family) %+replace%
    
    theme(
      # Specify axis options
      axis.line = element_blank(),  
      axis.text.x = element_text(size = base_size*0.8, color = "black", lineheight = 0.9),  
      axis.text.y = element_text(size = base_size*0.8, color = "black", lineheight = 0.9),  
      axis.ticks = element_line(color = "black", size  =  0.2),  
      axis.title.x = element_text(size = base_size, color = "black", margin = margin(0, 10, 0, 0)),  
      axis.title.y = element_text(size = base_size, color = "black", angle = 90, margin = margin(0, 10, 0, 0)),  
      axis.ticks.length = unit(0.3, "lines"),   
      # Specify legend options
      legend.background = element_rect(color = NA, fill = "white"),  
      legend.key = element_rect(color = "black",  fill = "white"),  
      legend.key.size = unit(1.2, "lines"),  
      legend.key.height = NULL,  
      legend.key.width = NULL,      
      legend.text = element_text(size = base_size*0.8, color = "black"),  
      legend.title = element_text(size = base_size*0.8, face = "bold", hjust = 0, color = "black"),  
      legend.position = "right",  
      legend.text.align = NULL,  
      legend.title.align = NULL,  
      legend.direction = "vertical",  
      legend.box = NULL, 
      # Specify panel options
      panel.background = element_rect(fill = "white", color  =  NA),  
      panel.border = element_rect(fill = NA, color = "black"),  
      panel.grid.major = element_line(color = "grey35"),  
      panel.grid.minor = element_line(color = "grey20"),  
      panel.margin = unit(0.5, "lines"),   
      # Specify facetting options
      strip.background = element_rect(fill = "grey30", color = "grey10"),  
      strip.text.x = element_text(size = base_size*0.8, color = "black"),  
      strip.text.y = element_text(size = base_size*0.8, color = "black",angle = -90),  
      # Specify plot options
      plot.background = element_rect(color = "white", fill = "white"),  
      plot.title = element_text(size = base_size*1.2, color = "black"),  
      plot.margin = unit(rep(1, 4), "lines")
      
    )
  
}



ggplot(df, aes(x=year, y=urban_small)) + 
  geom_point(color='purple', size = 3) + 
  geom_point(data = df, aes(x=year, y=rural_small), color = 'pink', size = 3) +
  theme_white() +
  labs(y='', x = '', title = '', caption = '') +
  theme(axis.text=element_text(size=12, color = "white"), axis.title.x = element_text(size=12), axis.title.y = element_text(size=12)) 

  
  
  
  