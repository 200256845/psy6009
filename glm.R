# Packages
library(here)
library(tidyverse)
library(ggplot2)
library(broom)
library(tidyr)
library(dplyr)

# Read in the data (total_box_scores_glm_lm.csv)
box <- read.csv(here("data", "processed", "total_box_scores_glm_lm.csv"), row.names = "X")

# Check the data
table(box$season)

#### ---- glm
null_model <- glm(home_win ~ 1, data = box, family = binomial(link = "logit"))
season <- glm(home_win ~ season, data = box, family = binomial(link = "logit"))

anova(null_model, season, test = "LR")
## 2     12262      16729  5   33.735 2.688e-06 ***

# Season improves the model

# Time to find the best fit model through a statistical approach
# Lets add one predictor variable at a time and see if it improves the fit of the model

attendance <- glm(home_win ~ season + attendance, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, test = "LR")
## 3     12261      16707  1   21.803 3.021e-06 ***

fga <- glm(home_win ~ season + attendance + fga, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, fga, test = "LR")
## 4     12260      16707  1    0.524    0.4692 

fg3a <- glm(home_win ~ season + attendance + fg3a, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, fg3a, test = "LR")
## 4     12260      16704  1    2.963   0.08521 .  

fta <- glm(home_win ~ season + attendance + fta, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, fta, test = "LR")
## 4     12260      16706  1    1.214    0.2705  

orb <- glm(home_win ~ season + attendance + orb, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, orb, test = "LR")
## 4     12260      16707  1    0.047    0.8286

drb <- glm(home_win ~ season + attendance + drb, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, drb, test = "LR")
## 4     12260      16706  1    1.275    0.2588  

stl <- glm(home_win ~ season + attendance + stl, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, stl, test = "LR")
## 4     12260      16704  1    3.283   0.06998 .  

blk <- glm(home_win ~ season + attendance + blk, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, blk, test = "LR")
## 4     12260      16707  1    0.060    0.8073  

tov <- glm(home_win ~ season + attendance + tov, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, tov, test = "LR")
## 4     12260      16698  1    9.647  0.001896 ** 

pf <- glm(home_win ~ season + attendance + tov + pf, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, tov, pf, test = "LR")
## 5     12259      16698  1    0.103  0.748749  

# Final model
final_model <- glm(home_win ~ season + attendance + tov, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, final_model, test = "LR")

summary(final_model)

# Venue
venue <- glm(home_win ~ season + attendance + tov + venue, data = box, family = binomial(link = "logit"))
anova(null_model, season, attendance, final_model, venue, test = "LR")

summary(venue)

#### ---- lm table

table_venue <- tidy(venue)

names(table_venue) <- c("Coefficient", "Estimated value", "SE", "z", "p")

table_venue$Coefficient[table_venue$Coefficient=="season2017-18"] <- "2017-18"
table_venue$Coefficient[table_venue$Coefficient=="season2018-19"] <- "2018-19"
table_venue$Coefficient[table_venue$Coefficient=="season2019-20"] <- "2019-20"
table_venue$Coefficient[table_venue$Coefficient=="season2019-21"] <- "2019-21"
table_venue$Coefficient[table_venue$Coefficient=="season2020-21"] <- "2020-21"

table_venue <- table_venue %>% 
  mutate_at(vars(p, `Estimated value`, SE), list(~ round(., 5)))

table_venue <- table_venue %>% 
  mutate_at(vars(p), list(~ round(., 3)))

table_venue <- table_venue %>% 
  mutate_at(vars(z), list(~ round(., 2)))

# Export
write.table(table_venue, file = "glm.txt", sep = ",", quote = FALSE, row.names = F)