What is the project?
In short, it is my project for the PSY6009 module at the University of Sheffield.

The project is complete, it includes two custom R-scripts to scrape data from
https://www.basketball-reference.com/, it includes raw data, 
it includes descriptive analyses, it includes a linear regression and it includes
a logistic regression.

The code is shared in a way that allows for the replication of the analyses.  
Moreover, the code allows readers to understand the process fully. 

What is in each folder?
PSY6009-COVID-19-NBA-HA = contains the below folders and .git, .Rproj.user, .gitignore,
.Rhistory, .Rprofile, cor_box_.txt (text of the correlation matrix), data_examination.R
(code for the data examination), descriptive_analyses.R (code for the descriptive analyses),
glm.R (code for the logistic regression), glm.txt (summary table of the logistic regression in txt form),
LICENSE, lm.R (code for the linear regression), lm.txt (summary table of the linear regression),
psy6009_200256845.Rproj, r_packages.txt (citations of the R packages),
README.md, renv.lock, schedule_and_results.R (the first custom R_script to scrape data), 
total_basic_box_scores.R (the second custom R_script to scrape data). 

attic = code that I used to play around with, or code that I do not want to delete as I might need it later on
data = contains two folders (processed and raw) and my codebook
       raw = contains csv files of raw data
             schedule_and_results_2016_2020.csv contains raw schedule and results data
             box_score_urls_2016_2020.csv contains raw box score URLs
             total_basic_box_scores_home.csv contains raw total box scores of home teams
             total_basic_box_scores_away.csv contains raw total box scores of away teams
       processed = contains csv files of processed data
		   box_score_urls_2016_2020.csv contains processed box score URLs
                   schedule_and_results_2016_2020.csv contain processed schedule and results data
                   total_basic_box_scores.csv contains processed total box scores of the home and away teams (of all seasons)
                   total_basic_box_scores_glm_lm.csv contains processed total box scores of the home and away teams (2016-17, 2017-18, 2018-19, 2019-20, 2019-21, 2020-21)
	           	                   
figs = contains graphs that were created during the project 
renv = contains my renv files