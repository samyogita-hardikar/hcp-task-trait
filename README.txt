These analyses were performed using data from the Human Connectome Project (Van Essen et al., 2013), and functional connectivity gradient maps from Margulies et. al. (2016).

Task maps and other variables from HCP are available for download at: https://www.humanconnectome.org/study/hcp-young-adult/data-releases

Task Map Specifics:
Session Type: "3T MRI"
Processing Level: "Analysis"
Modalities: "Task Analysis"
Smoothing: "Surface 2mm"

Connectivity Gradients (Margulies et al., 2016) are available for download at: https://www.neuroconnlab.org/data/

Directory structure for analysis and visualization

hck_task_trait    
  |-hcp_s1200
    |-Task
      |-Emotion
      |-Gambling
      |-Language
      |-Motor
      |-Relational
      |-Social
      |-WM
  |-data
    |-cifti_csvs
      |-Emotion
      |-Gambling
      |-Language
      |-Motor
      |-Relational
      |-Social
      |-WM
    |-cifti_grad_corrs
    |-cifti_map_corrs
    |-HCPMovement 	
  |-scripts
  |-results
  |-figures


References:

Van Essen, D. C. et al. The WU-Minn Human Connectome Project: An Overview. Neuroimage 80, 62 (2013)

Margulies, D. S. et al. Situating the default-mode network along a principal gradient of macroscale cortical organization. Proc. Natl. Acad. Sci. U. S. A. 113, 12574–12579 (2016).
