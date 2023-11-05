cd /hcp_s1200/Task/Language/complete
find -maxdepth 1 -type d -printf '%f\n' > "/hcp_task_trait/data/language_sublist.csv"

cd /hcp_s1200/Task/Emotion/complete
find -maxdepth 1 -type d -printf '%f\n' > "/hcp_task_trait/data/emotion_sublist.csv"

cd /hcp_s1200/Task/Gambling/complete
find -maxdepth 1 -type d -printf '%f\n' > "/hcp_task_trait/data/gambling_sublist.csv"

cd /hcp_s1200/Task/Social/complete
find -maxdepth 1 -type d -printf '%f\n' > "/hcp_task_trait/data/social_sublist.csv"

cd /hcp_s1200/Task/Relational/complete
find -maxdepth 1 -type d -printf '%f\n' > "/hcp_task_trait/data/relational_sublist.csv"

cd /hcp_s1200/Task/Motor/complete
find -maxdepth 1 -type d -printf '%f\n' > "/hcp_task_trait/data/motor_sublist.csv"

cd /hcp_s1200/Task/WM/complete
find -maxdepth 1 -type d -printf '%f\n' > "/hcp_task_trait/data/WM_sublist.csv"



