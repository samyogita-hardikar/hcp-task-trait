rm()

library(ggplot2)
library(tidyr)
library(dplyr)
library(colorway)


df<-read.csv("/hcp_task_trait/figures/hcp_analysis_df_spearman.csv", sep = ",")

df$sub<-as.factor(c(df$sub))
df$cont<-gsub("tom", "ToM", df$cont)
df$cont<-gsub("rel", "relational", df$cont)
df$cont<-gsub("avg", "motor", df$cont)
df$cont<-gsub("0bk", "0back", df$cont)
df$cont<-gsub("2bk", "2back", df$cont)
cont_list<- levels(as.factor(df$cont))


fig_path <- "/hcp_task_trait/figures/"


#my_pal created from most distinguishable colours from cols25()
my_pal<- c( "orchid1","maroon", "dodgerblue2", "#E31A1C", "green4", "#6A3D9A", "#FF7F00", "black",
            "gold1", "skyblue2", "palegreen2", "#FDBF6F", "gray70", "darkturquoise", "darkorange4", "brown") 
cont_list<- levels(as.factor(df$cont))



trait<-"Openness"
corr<- "g3"

c1<-"reward"
c2<-"story"


spearmancor_g3_O_c1_c2<-read.csv(paste0("/hcp_task_trait/figures/spearmancor_g3_O_unrelated_",
                                        c1, "_", c2, "_check.csv"), sep = ",")

spearmancor_g3_O_sum <- spearmancor_g3_O_c1_c2 %>%
  group_by(as.factor(V3), as.numeric(V4)) %>%
  summarise( 
    n=n(),
    mean=mean(as.numeric(V5)),
    sd=sd(as.numeric(V5)),
    ic.min95= quantile(as.numeric(V5), 0.025),
    ic.max95= quantile(as.numeric(V5), 0.975),
    ic.min99= quantile(as.numeric(V5), 0.005),
    ic.max99= quantile(as.numeric(V5), 0.995),
    ic.min= min(as.numeric(V5)),
    ic.max= max(as.numeric(V5))
  ) %>%
  mutate( se=sd/sqrt(n)) %>%
  mutate( ic_mean=se * qt((1-0.05)/2 + .5, n-1))%>%
  mutate(settling_pt95 = `as.numeric(V4)`[which(sign(ic.min95)==sign(ic.max95))][1])%>%
  mutate(settling_pt99 = `as.numeric(V4)`[which(sign(ic.min99)==sign(ic.max99))][1])%>%
  mutate(settling_pt100 = `as.numeric(V4)`[which(sign(ic.min)==sign(ic.max))][1])


p_boot<-ggplot(spearmancor_g3_O_sum, aes(x= as.factor(spearmancor_g3_O_sum$`as.numeric(V4)`),
                                         y= spearmancor_g3_O_sum$mean, 
                                         group=spearmancor_g3_O_sum$`as.factor(V3)`))+
  geom_ribbon(aes(x= as.factor(spearmancor_g3_O_sum$`as.numeric(V4)`), 
                  ymin= spearmancor_g3_O_sum$ic.min, ymax= spearmancor_g3_O_sum$ic.max,
                  fill = spearmancor_g3_O_sum$`as.factor(V3)`), alpha=0.2)+
  geom_ribbon(aes(x= as.factor(spearmancor_g3_O_sum$`as.numeric(V4)`), 
                  ymin= spearmancor_g3_O_sum$ic.min99, ymax= spearmancor_g3_O_sum$ic.max99,
                  fill = spearmancor_g3_O_sum$`as.factor(V3)`), alpha=0.3)+
  geom_ribbon(aes(x= as.factor(spearmancor_g3_O_sum$`as.numeric(V4)`),
                  ymin= spearmancor_g3_O_sum$ic.min95, ymax= spearmancor_g3_O_sum$ic.max95,
                  fill = spearmancor_g3_O_sum$`as.factor(V3)`), alpha=0.4)+
  geom_line(linewidth=0.3,  color= "black" )+
  geom_hline(aes(yintercept = 0), linetype= "dashed", linewidth=0.2)+
  #scale_fill_manual(values= color_sum(my_pal[which(cont_list==c1)], my_pal[which(cont_list==c2)]))+ 
  scale_fill_manual(values="#66E0D6")+  # for grad 3 open
  
  guides(alpha= "none", fill= "none")+
  scale_x_discrete(name= "Sample Size", breaks=levels(as.factor(spearmancor_g3_O_sum$`as.numeric(V4)`)),
                   labels= c("25",  "",  "",  "",  "",  "",  "105", "", 
                             "", "", "", "", "442"))+
  scale_y_continuous(name= NULL, breaks=c(-1, -0.5, 0, 0.5, 1), labels= c("-1", "", "0", "", "1"),
                     limits= c(-1, 1))+
  geom_vline(aes(xintercept = as.factor(settling_pt95)), linetype="aa",
             color = "darkgreen", linewidth=0.3)+
  geom_vline(aes(xintercept = as.factor(settling_pt99)), linetype="44",
             color = "darkgreen", linewidth=0.3)+
  geom_vline(aes(xintercept = as.factor(settling_pt100)), linetype="13",
             color = "darkgreen", linewidth=0.3)+
  theme_classic()+
  theme(plot.title = element_text(size = 9),
        axis.title = element_text(size = 9), axis.ticks.x = element_line(),
        axis.text = element_text(size = 9, colour = "black", family = "sans"), axis.text.y = element_text(hjust = 0.5),
        axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust = 1),
        axis.line.x = element_line())


ggsave(
  paste0(fig_path, "revised_paper_fig_3_", corr, "_", trait, "_",
         c1, "-", c2, "_spearman_boot_unrelated_check.svg"),
  plot = p_boot,
  device = NULL,
  path = NULL,
  scale = 1,
  width = 1.5,
  height = 1.5,
  units = c("in"),
  dpi = 300,
  limitsize = TRUE,
  bg = NULL)