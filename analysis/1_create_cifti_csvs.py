import numpy as np
import nibabel as nib


#to repress the warning about pixdim
nib.imageglobals.logger.setLevel(40)


sub= np.genfromtxt('/hcp_task_trait/data/motor_sublist.csv', dtype='<U8', skip_header= 1) 
contrasts=['cope1', 'cope2', 'cope3', 'cope4', 'cope5', 'cope6', 'cope7', 'cope8', 'cope9', 'cope10', 'cope11', 'cope12', 'cope13', 'cope14', 'cope15', 'cope16', 'cope17', 'cope18', 'cope19', 'cope20', 'cope21', 'cope22', 'cope23', 'cope24', 'cope25', 'cope26']
filename= '/hcp_s1200/Task/Motor/complete/%s/MNINonLinear/Results/tfMRI_MOTOR/tfMRI_MOTOR_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/%s.feat/zstat1.dtseries.nii'      
outfile = '/hcp_task_trait/data/cifti_csvs/motor/%s_%s.csv'

for s in sub:
    for c in contrasts:
        img=nib.load(filename%(s, c))
        img_data=img.get_fdata()
        np.savetxt(outfile%(s, c), img_data, delimiter='\n') 
        

sub= np.genfromtxt('/hcp_task_trait/data/WM_sublist.csv', dtype='<U8', skip_header= 1) 
contrasts=['cope1', 'cope2', 'cope3', 'cope4', 'cope5', 'cope6', 'cope7', 'cope8', 'cope9', 'cope10', 'cope11', 'cope12', 'cope13', 'cope14', 'cope15', 'cope16', 'cope17', 'cope18', 'cope19', 'cope20', 'cope21', 'cope22', 'cope23', 'cope24', 'cope25', 'cope26', 'cope27', 'cope28', 'cope29', 'cope30']
filename= '/hcp_s1200/Task/WM/complete/%s/MNINonLinear/Results/tfMRI_WM/tfMRI_WM_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/%s.feat/zstat1.dtseries.nii'      
outfile = '/hcp_task_trait/data/cifti_csvs/wm/%s_%s.csv'

for s in sub:
    for c in contrasts:
        img=nib.load(filename%(s, c))
        img_data=img.get_fdata()
        np.savetxt(outfile%(s, c), img_data, delimiter='\n') 
        


sub= np.genfromtxt('/hcp_task_trait/data/emotion_sublist.csv', dtype='<U8', skip_header= 1) 
contrasts=['cope1', 'cope2', 'cope3', 'cope4', 'cope5', 'cope6']
filename= '/hcp_s1200/Task/Emotion/complete/%s/MNINonLinear/Results/tfMRI_EMOTION/tfMRI_EMOTION_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/%s.feat/zstat1.dtseries.nii'      
outfile = '/hcp_task_trait/data/cifti_csvs/emotion/%s_%s.csv'

for s in sub:
    for c in contrasts:
        img=nib.load(filename%(s, c))
        img_data=img.get_fdata()
        np.savetxt(outfile%(s, c), img_data, delimiter='\n') 
        

sub= np.genfromtxt('/hcp_task_trait/data/social_sublist.csv', dtype='<U8', skip_header= 1) 
contrasts=['cope1', 'cope2', 'cope3', 'cope4', 'cope5', 'cope6']
filename= '/hcp_s1200/Task/Social/complete/%s/MNINonLinear/Results/tfMRI_SOCIAL/tfMRI_SOCIAL_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/%s.feat/zstat1.dtseries.nii'      
outfile = '/hcp_task_trait/data/cifti_csvs/social/%s_%s.csv'

for s in sub:
    for c in contrasts:
        img=nib.load(filename%(s, c))
        img_data=img.get_fdata()
        np.savetxt(outfile%(s, c), img_data, delimiter='\n') 
        

sub= np.genfromtxt('/hcp_task_trait/data/gambling_sublist.csv', dtype='<U8', skip_header= 1) 
contrasts=['cope1', 'cope2', 'cope3', 'cope4', 'cope5', 'cope6']
filename= '/hcp_s1200/Task/Gambling/complete/%s/MNINonLinear/Results/tfMRI_GAMBLING/tfMRI_GAMBLING_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/%s.feat/zstat1.dtseries.nii'      
outfile = '/hcp_task_trait/data/cifti_csvs/gambling/%s_%s.csv'

for s in sub:
    for c in contrasts:
        img=nib.load(filename%(s, c))
        img_data=img.get_fdata()
        np.savetxt(outfile%(s, c), img_data, delimiter='\n') 
        

sub= np.genfromtxt('/hcp_task_trait/data/language_sublist.csv', dtype='<U8', skip_header= 1) 
contrasts=['cope1', 'cope2', 'cope3', 'cope4', 'cope5', 'cope6']
filename= '/hcp_s1200/Task/Language/complete/%s/MNINonLinear/Results/tfMRI_LANGUAGE/tfMRI_LANGUAGE_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/%s.feat/zstat1.dtseries.nii'      
outfile = '/hcp_task_trait/data/cifti_csvs/language/%s_%s.csv'

for s in sub:
    for c in contrasts:
        img=nib.load(filename%(s, c))
        img_data=img.get_fdata()
        np.savetxt(outfile%(s, c), img_data, delimiter='\n') 
        
sub= np.genfromtxt('/hcp_task_trait/data/relational_sublist.csv', dtype='<U8', skip_header= 1) 
contrasts=['cope1', 'cope2', 'cope3', 'cope4', 'cope5', 'cope6']
filename= '/hcp_s1200/Task/Relational/complete/%s/MNINonLinear/Results/tfMRI_RELATIONAL/tfMRI_RELATIONAL_hp200_s2_level2_MSMAll.feat/GrayordinatesStats/%s.feat/zstat1.dtseries.nii'      
outfile = '/hcp_task_trait/data/cifti_csvs/relational/%s_%s.csv'

for s in sub:
    for c in contrasts:
        img=nib.load(filename%(s, c))
        img_data=img.get_fdata()
        np.savetxt(outfile%(s, c), img_data, delimiter='\n') 
        

