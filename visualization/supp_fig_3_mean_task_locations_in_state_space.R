rm()
library(tidyverse)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)

df<-read.csv("/hcp_task_trait/figures/hcp_analysis_df_spearman.csv", sep = ",")

df$sub<-as.factor(c(df$sub))
df$cont<-gsub("tom", "ToM", df$cont)
df$cont<-gsub("rel", "relational", df$cont)
df$cont<-gsub("avg", "motor", df$cont)
df$cont<-gsub("0bk", "0-back", df$cont)
df$cont<-gsub("2bk", "2-back", df$cont)
df$cont<-as.factor(c(df$cont))


fig_path <- "/hcp_task_trait/figures/"

#### summarize values by condition ####

my_sum1 <- df %>%
  group_by(cont) %>%
  dplyr::summarise( 
    n=n(),
    mean=mean(as.numeric(corr_g1)),
    sd=sd(as.numeric(corr_g1))
  ) %>%
  mutate( se=sd/sqrt(n))  %>%
  mutate( ic=se * qt((1-0.05)/2 + .5, n-1)) 


my_sum2 <- df %>%
  group_by(cont) %>%
  dplyr::summarise( 
    n=n(),
    mean=mean(as.numeric(corr_g2)),
    sd=sd(as.numeric(corr_g2))
  ) %>%
  mutate( se=sd/sqrt(n))  %>%
  mutate( ic=se * qt((1-0.05)/2 + .5, n-1)) 

my_sum3 <- df %>%
  group_by(cont) %>%
  dplyr::summarise( 
    n=n(),
    mean=mean(as.numeric(corr_g3)),
    sd=sd(as.numeric(corr_g3))
  ) %>%
  mutate( se=sd/sqrt(n))  %>%
  mutate( ic=se * qt((1-0.05)/2 + .5, n-1)) 

sumdf<-data.frame(cont=my_sum1$cont,
                  g1_mean=my_sum1$mean, g2_mean=my_sum2$mean, g3_mean=my_sum3$mean,
                  g1_sd=my_sum1$sd, g2_sd=my_sum2$sd, g3_sd=my_sum3$sd,
                  g1_se=my_sum1$se, g2_se=my_sum2$se, g3_se=my_sum3$se)


my_pal<- c( "orchid1","maroon", "dodgerblue2", "#E31A1C", "green4", "#6A3D9A", "#FF7F00", "black",
                 "gold1", "skyblue2", "palegreen2", "#FDBF6F", "gray70", "darkturquoise", "darkorange4", "brown") 

d1_d2<-ggplot(sumdf) +  
  geom_point(aes(x= g1_mean, y=g2_mean, group = cont, color=cont), size=.7)+ 
  scale_x_continuous(name = "D1", limits = c(-.4, .4), breaks = c(-.4, -.2, 0, .2, .4),
                     labels = c("-.4", "", "0", "", ".4"))+
  scale_y_continuous(name = "D2", limits = c(-.4, .4), breaks = c(-.4, -.2, 0, .2, .4),
                     labels = c("-.4", "", "0", "", ".4"))+
  scale_colour_manual(values=my_pal[1:13])+
  geom_segment(aes(x = g1_mean, xend = g1_mean, y= g2_mean-g2_sd, yend= g2_mean+g2_sd, color=cont), linewidth=0.5 )+
  geom_segment(aes(y = g2_mean, yend= g2_mean, x= g1_mean-g1_sd, xend= g1_mean+g1_sd, color=cont), linewidth=0.5 )+
  theme_classic()+
  theme(text = element_text(size= 9, color= "black", family= "sans"), 
        axis.text = element_text(size= 9, color= "black", family= "sans", hjust = 0.5),
        axis.text.y = element_text(angle = 90, hjust = 0.5), legend.title = element_blank(),
        legend.text = element_text(size=8), legend.key = element_rect(fill = "white", color = "white"),
        legend.position = "bottom")+
  guides(color=guide_legend(nrow=2,byrow=TRUE)) 

  
d1_d3<-ggplot(sumdf) +  
  geom_point(aes(x= g1_mean, y=g3_mean, group = cont, color=cont), size=.7)+ 
  scale_x_continuous(name = "D1", limits = c(-.4, .4), breaks = c(-.4, -.2, 0, .2, .4),
                     labels = c("-.4", "", "0", "", ".4"))+
  scale_y_continuous(name = "D3", limits = c(-.4, .4), breaks = c(-.4, -.2, 0, .2, .4),
                     labels = c("-.4", "", "0", "", ".4"))+
  scale_colour_manual(values=my_pal[1:13])+
  geom_segment(aes(x = g1_mean, xend = g1_mean, y= g3_mean-g3_sd, yend= g3_mean+g3_sd, color=cont), linewidth=0.5 )+
  geom_segment(aes(y = g3_mean, yend= g3_mean, x= g1_mean-g1_sd, xend= g1_mean+g1_sd, color=cont), linewidth=0.5 )+
  theme_classic()+
  theme(text = element_text(size= 9, color= "black", family= "sans"), 
        axis.text = element_text(size= 9, color= "black", family= "sans", hjust = 0.5),
        axis.text.y = element_text(angle = 90, hjust = 0.5), legend.title = element_blank(),
        legend.text = element_text(size=8), legend.key = element_rect(fill = "white", color = "white"),
        legend.position = "bottom")+
  guides(color=guide_legend(nrow=2,byrow=TRUE)) 


d2_d3<-ggplot(sumdf) +  
  geom_point(aes(x= g2_mean, y=g3_mean, group = cont, color=cont), size=.7)+ 
  scale_x_continuous(name = "D2", limits = c(-.4, .4), breaks = c(-.4, -.2, 0, .2, .4),
                     labels = c("-.4", "", "0", "", ".4"))+
  scale_y_continuous(name = "D3", limits = c(-.4, .4), breaks = c(-.4, -.2, 0, .2, .4),
                     labels = c("-.4", "", "0", "", ".4"))+
  scale_colour_manual(values=my_pal[1:13])+
  geom_segment(aes(x = g2_mean, xend = g2_mean, y= g3_mean-g3_sd, yend= g3_mean+g3_sd, color=cont), linewidth=0.5 )+
  geom_segment(aes(y = g3_mean, yend= g3_mean, x= g2_mean-g2_sd, xend= g2_mean+g2_sd, color=cont), linewidth=0.5 )+
  theme_classic()+
  theme(text = element_text(size= 9, color= "black", family= "sans"), 
        axis.text = element_text(size= 9, color= "black", family= "sans", hjust = 0.5),
        axis.text.y = element_text(angle = 90, hjust = 0.5,), legend.title = element_blank(),
        legend.text = element_text(size=8), legend.key = element_rect(fill = "white", color = "white"),
        legend.position = "bottom")+
  guides(color=guide_legend(nrow=2,byrow=TRUE)) 

ggsave(
  paste0(fig_path, "revised_paper_supp_mean_locations.svg"),
  plot = ggarrange(d1_d2, d1_d3, d2_d3, ncol = 3,legend = "bottom", common.legend = T),
  device = NULL,
  path = NULL,
  scale = 1,
  width = 5.5,
  height = 2.5,
  units = c("in"),
  dpi = 300,
  limitsize = TRUE,
  bg = NULL)
