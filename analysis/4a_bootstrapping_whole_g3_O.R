rm ()

library(tidyr)
library(dplyr)
library(boot)
library(bigsnpr)



df<-read.csv("/hcp_task_trait/data/hcp_analysis_df_spearman.csv", sep = ",")

df$sub<-as.factor(c(df$sub))
df$cont<-gsub("tom", "ToM", df$cont)
df$cont<-gsub("rel", "relational", df$cont)
df$cont<-gsub("avg", "motor", df$cont)
df$cont<-gsub("0bk", "0back", df$cont)
df$cont<-gsub("2bk", "2back", df$cont)
cont_list<- levels(as.factor(df$cont))

set.seed(42)
n_iter= 1000
resamp_size = round(seq_log(25, 950, 16),0)

#### OpennessS ####

trait<-"Openness"
corr<- "g3"

#Openness interaction of biggest + and - values

bootdf1<-df[which(df$cont=="reward"),]
bootdf2<-df[which(df$cont== "story"),]

bootdf<-merge(bootdf1, bootdf2, by= "sub", suffixes = c(paste0(".", bootdf1$cont[1]),
                                                        paste0( ".", bootdf2$cont[1])))
bootdf<-bootdf[complete.cases(bootdf),]


resamplesubs<-list()
resampledf<-list()
spearmancor_g3_O_reward_story<-data.frame()

for (r in 1:length(resamp_size)){
  for (n in 1:n_iter){
    resamplesubs[[n]]<-sample(unique(bootdf$sub), size = resamp_size[r], replace = T)
    newdf<-data.frame()
    for (b in 1: length(resamplesubs[[n]])){
      newdf<-rbind(newdf, bootdf[which(bootdf$sub==resamplesubs[[n]][b]),])
    }
    resampledf[[n]]<-newdf
    cortest<-cor.test(c(resampledf[[n]]$corr_g3.reward -resampledf[[n]]$corr_g3.story),
                      resampledf[[n]]$Openness.reward)
    
    spearmancor_g3_O_reward_story<-rbind(spearmancor_g3_O_reward_story,
                                        cbind("g3", "Openness", "reward_story", nrow(resampledf[[n]]),
                                              cortest$estimate, cortest$p.value))
  }
  
}



write.csv(spearmancor_g3_O_reward_story, "/hcp_task_trait/figures/spearmancor_g3_O_whole_reward_story_check.csv", row.names = F)


