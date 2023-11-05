rm()

library(ggplot2)
library(tidyr)
library(ggrepel)
library(gridExtra)
library(MetBrewer)
library(dplyr)

grads<-read.csv('margulies_grads.csv', sep= ',', header = FALSE)
colnames(grads)<-gsub("V", "g", colnames(grads))
task_contrasts<-read.csv('/hcp_task_trait/data/contrast_names.csv', sep= ',', header = TRUE)
tasks<-colnames(task_contrasts)

 
 hcp_all_corrs<-data.frame()
 for (t in 1:length(tasks)){
   sublist<-read.csv(paste0('/hcp_task_trait/data/', tasks[t], '_sublist.csv'), sep= ',', header = TRUE)
   cont<-droplevels(as.factor(task_contrasts[,tasks[t]]), "")
   corrs<-data.frame()
   for (i in 1:length(sublist[,1])){
     for (c in 1:length(levels(cont))){
      df<-read.csv(paste0('/hcp_task_trait/data/cifti_csvs/', tasks[t], '/',
                           sublist[i,],'_cope',c, '.csv'), sep= ',', header = FALSE)
       corrs<-rbind(corrs, cbind(sublist[i,], tasks[t], task_contrasts[c,t],
                                 cor(grads$g1, df$V1, use="everything", method="spearman"),
                                 cor(grads$g2, df$V1, use="everything", method="spearman"),
                                 cor(grads$g3, df$V1, use="everything", method="spearman")))
     } 
     rm(df)
   }
   colnames(corrs)<-c('sub', 'task', 'cont', 'corr_g1', 'corr_g2', 'corr_g3')
   write.csv(corrs, paste0("/hcp_task_trait/data/cifti_grad_corrs/", tasks[t], "_grad_corrs_spearman.csv"), 
            row.names = FALSE)
   hcp_all_corrs<-rbind(hcp_all_corrs, corrs)
   rm(corrs)
 }
 
 hcp_all_corrs$cont<- tolower(hcp_all_corrs$cont)
 
 write.csv(hcp_all_corrs, "/hcp_task_trait/data/hcp_all_corrs_spearman.csv",
           row.names = FALSE)
 

### add head motion

# move to next section to use the already-written file directly

# task_list<-read.csv('/hcp_task_trait/data/HCPMovement/TasksToDownload.txt', header = F)[,1]
# sub_list<-read.csv('/hcp_task_trait/data/HCPMovement/SubjectsToDownload.txt', header = F)[,1]
# 
# movement_df<-data_frame()
# 
# for (s in 1:length(sub_list)){
#   subdf<-data.frame()
#   for (t in 1:length(task_list)){
#     subfile<-paste0('/hcp_task_trait/data/HCPMovement/', sub_list[s],
#                     '-', task_list[t], '-RelMeanRMS.txt')
#     subline<-c(sub_list[s], task_list[t] )
#     if (file.exists(subfile)) {
#       subline<-c(subline, read.csv(subfile, header = F)[1,1])
#     } else {
#       subline<-c(subline, NA)
#     }
#     subdf<-rbind(subdf, subline)
#     colnames(subdf)<- c("sub", "task", "motion")
#   }
#   movement_df<-rbind(movement_df, subdf)
# }
# 


movement_df<-read.csv('/hcp_task_trait/data/hcp_headmotion_df.csv',
                      sep= ',', header = TRUE)

movement_df$task<- gsub("tfMRI_", "",  movement_df$task)
movement_df$task<- gsub("_LR", "",  movement_df$task)
movement_df$task<- gsub("_RL", "",  movement_df$task)
movement_df$task<-tolower(movement_df$task)


movement_df_avg <- movement_df %>%
  group_by(sub, task) %>%
  summarize( 
    motion=mean(as.numeric(motion)),
  )


                            

write.csv(movement_df_avg, "/hcp_task_trait/data/hcp_headmotion_avg_df.csv", row.names = FALSE)




### create analysis df


hcp_all_corrs<-read.csv(  "/hcp_task_trait/data/hcp_all_corrs_spearman.csv", header= T)

analysisdf <- hcp_all_corrs[which(hcp_all_corrs$cont=="faces" | hcp_all_corrs$cont=="shapes" |
                                       hcp_all_corrs$cont=="rel" |hcp_all_corrs$cont=="match" |
                                       hcp_all_corrs$cont=="story" |hcp_all_corrs$cont=="math" |
                                       hcp_all_corrs$cont=="punish" |hcp_all_corrs$cont=="reward"|
                                       hcp_all_corrs$cont=="random" |hcp_all_corrs$cont=="tom"|
                                       hcp_all_corrs$cont=="avg"|
                                       hcp_all_corrs$cont=="0bk" |hcp_all_corrs$cont=="2bk"),] 


HCP_beh<-read.csv('/hcp_task_trait/data/unrestricted_hardigirl_HCP.csv', sep= ',', header = TRUE)
HCP_myvars<- subset(HCP_beh, select = c('Subject' , 'Gender', 'NEOFAC_N', 'NEOFAC_O', 'NEOFAC_C', 'NEOFAC_E', 'NEOFAC_A'))
colnames(HCP_myvars)<-c('sub' ,  'Gender', 'Neuroticism', 'Openness', 'Conscientiousness', 'Extraversion', 'Agreeableness')

restricted_df<-read.csv("/hcp_task_trait/data/HCPData.csv", sep = ",")
HCP_Mother_ID<- subset(restricted_df, select = c('Subject' , 'Mother_ID'))
HCP_Father_ID<- subset(restricted_df, select = c('Subject' , 'Father_ID'))
HCP_Family_ID<- subset(restricted_df, select = c('Subject' , 'Family_ID'))
HCP_zygosity<- subset(restricted_df, select = c('Subject' , 'ZygositySR'))
HCP_Age<- subset(restricted_df, select = c('Subject' , 'Age_in_Yrs'))


colnames(HCP_Age)<-c('sub' ,  'Age')
colnames(HCP_Mother_ID)<-c('sub' ,  'Mother_ID')
colnames(HCP_Father_ID)<-c('sub' ,  'Father_ID')
colnames(HCP_Family_ID)<-c('sub' ,  'Family_ID')
colnames(HCP_zygosity)<-c('sub' ,  'Zygosity')


newanalysisdf<- merge(analysisdf, HCP_myvars, by= "sub")  
newanalysisdf<- merge(newanalysisdf, HCP_Age, by= "sub")  
newanalysisdf<- merge(newanalysisdf, HCP_Mother_ID, by= "sub")  
newanalysisdf<- merge(newanalysisdf, HCP_Father_ID, by= "sub")  
newanalysisdf<- merge(newanalysisdf, HCP_Family_ID, by= "sub")  
newanalysisdf<- merge(newanalysisdf, HCP_zygosity, by= "sub")  


newanalysisdf<- merge(newanalysisdf, movement_df_avg, by= c("sub", "task"))  

write.csv(newanalysisdf, "/hcp_task_trait/data/hcp_analysis_df_spearman.csv",
          row.names = FALSE)

write.csv(newanalysisdf, "/hcp_task_trait/figures/hcp_analysis_df_spearman.csv",
          row.names = FALSE)

 
