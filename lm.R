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

#### ---- lm
null_model <- lm(abs_point_dif ~ 1, data = box)

season <- lm(abs_point_dif ~ season, data = box)
anova(null_model, season)
## 2  12262 905159  5    1873.8 5.0769 0.0001186 ***

# Season improves the model

attendance <- lm(abs_point_dif ~ season + attendance, data = box)
anova(null_model, season, attendance)
## 3  12261 904280  1    878.74 11.9146 0.0005588 ***

fga <- lm(abs_point_dif ~ season + attendance + fga, data = box)
anova(null_model, season, attendance, fga)
## 4  12260 904176  1    103.62  1.4050 0.2359049

fg3a <- lm(abs_point_dif ~ season + attendance + fg3a, data = box)
anova(null_model, season, attendance, fg3a)
## 4  12260 904065  1    214.96  2.9151 0.0877776 .  

fta <- lm(abs_point_dif ~ season + attendance + fta, data = box)
anova(null_model, season, attendance, fta)
## 4  12260 894522  1    9758.3 133.7432 < 2.2e-16 ***

orb <- lm(abs_point_dif ~ season + attendance + fta + orb, data = box)
anova(null_model, season, attendance, fta, orb)
## 5  12259 894052  1     469.9   6.4433 0.0111491 *  

drb <- lm(abs_point_dif ~ season + attendance + fta + orb + drb, data = box)
anova(null_model, season, attendance, fta, orb, drb)
## 6  12258 893776  1     275.8   3.7824 0.0518181 . 

stl <- lm(abs_point_dif ~ season + attendance + fta + orb + stl, data = box)
anova(null_model, season, attendance, fta, orb, stl)
## 6  12258 892319  1    1732.7  23.8025 1.081e-06 ***

blk <- lm(abs_point_dif ~ season + attendance + fta + orb + stl + blk, data = box)
anova(null_model, season, attendance, fta, orb, stl, blk)
## 7  12257 891916  1     403.5   5.5447 0.0185523 *

tov <- lm(abs_point_dif ~ season + attendance + fta + orb + stl + blk + tov, data = box)
anova(null_model, season, attendance, fta, orb, stl, blk, tov)
## 8  12256 891307  1     609.0   8.3741 0.0038128 ** 

pf <- lm(abs_point_dif ~ season + attendance + fta + orb + stl + blk + tov + pf, data = box)
anova(null_model, season, attendance, fta, orb, stl, blk, tov, pf)
## 9  12255 882343  1    8963.7 124.4977 < 2.2e-16 ***

# Final model
final_model <- lm(abs_point_dif ~ season + attendance + fta + orb + stl + blk + tov + pf, data = box)
anova(null_model, season, attendance, fta, orb, stl, blk, tov, final_model)

summary(final_model)

# Venue
venue <- lm(abs_point_dif ~ season + attendance + fta + orb + stl + blk + tov + pf + venue, data = box)
anova(null_model, season, attendance, fta, orb, stl, blk, tov, final_model, venue)

anova(null_model, venue)
summary(venue)

# Table
table_venue <- tidy(venue)

names(table_venue) <- c("Coefficient", "Estimated value", "SE", "t", "p")

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
  mutate_at(vars(t), list(~ round(., 2)))

# Export
write.table(table_venue, file = "lm.txt", sep = ",", quote = FALSE, row.names = F)

# Point difference per season per venue
tapply(box$points, list(box$venue, box$season), mean)