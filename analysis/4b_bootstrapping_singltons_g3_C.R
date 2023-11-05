rm()

library(ggplot2)
library(tidyr)
library(dplyr)
library(boot)
library(bigsnpr)


df<-read.csv("/hcp_task_trait/figures/hcp_analysis_df_spearman.csv", sep = ",")

df$sub<-as.factor(c(df$sub))
df$cont<-gsub("tom", "ToM", df$cont)
df$cont<-gsub("rel", "relational", df$cont)
df$cont<-gsub("avg", "motor", df$cont)
df$cont<-gsub("0bk", "0back", df$cont)
df$cont<-gsub("2bk", "2back", df$cont)


fig_path <- "/hcp_task_trait/figures/"

set.seed(42)
n_iter= 1000
resamp_size = round(seq_log(25, 442, 13),0)

#Conscientiousness interaction of biggest + and - values

trait<-"Conscientiousness"
corr<- "g3"

#specify conditions of interest and make a new data frame
bootdf1<-df[which(df$cont=="0back"),]
bootdf2<-df[which(df$cont== "motor"),]

bootdf<-merge(bootdf1, bootdf2, by= "sub", suffixes = c(paste0(".", bootdf1$cont[1]),
                                                        paste0( ".", bootdf2$cont[1])))
bootdf<-bootdf[complete.cases(bootdf),]

#get a list of unique family IDs in the subsetted dataframe
families<-unique(bootdf$Family_ID.0back)

resamplesubs<-list()
resampledf<-list()
spearmancor_g3_C_0back_motor<-data.frame()

for (r in 1:length(resamp_size)){
  for (n in 1:n_iter){
    #for each iteration create a resampling pool of sub IDs, by sampling only one ID from each family
    resamplepool<-vector() 
    for (f in 1:length(families)){
      sampled_ID<- sample(as.character(bootdf[which(bootdf$Family_ID.0back==families[f]),]$sub), 1)
      resamplepool<-c(resamplepool,  sampled_ID)
    }
    # resample subs (with replacement) from within the resample pool
    resamplesubs[[n]]<-sample(resamplepool, size = resamp_size[r], replace = T)
    newdf<-data.frame()
    for (b in 1: length(resamplesubs[[n]])){
      newdf<-rbind(newdf, bootdf[which(bootdf$sub==resamplesubs[[n]][b]),])
    }
    # calculate spearman correlation between the difference between 2 tasks specifies, and trait of interest
    resampledf[[n]]<-newdf
    cortest<-cor.test(c(resampledf[[n]]$corr_g3.0back -resampledf[[n]]$corr_g3.motor),
                      resampledf[[n]]$Conscientiousness.0back)
    
    spearmancor_g3_C_0back_motor<-rbind(spearmancor_g3_C_0back_motor,
                                        cbind("g3", "Conscientiousness", "0back_motor", nrow(resampledf[[n]]),
                                              cortest$estimate, cortest$p.value))
  }
  
}


#save results from all iterations and all sample sizes to a csv file
write.csv(spearmancor_g3_C_0back_motor, "/hcp_task_trait/figures/spearmancor_g3_C_unrelated_0back_motor_check.csv", row.names = F)
