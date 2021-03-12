#explore DA's data again... 22/01/2021

library(ggplot2)
library(tidyverse)

rm(list = ls()) # clears environment
cat("\f") # clears console
dev.off() # clears graphics device
graphics.off() #clear plots


#---- Setup ----#
# wd <- "/imaging/ek03/MVB/SMT/MVB/R"
wd = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(wd)

rawDir = "csv"
outImageDir = 'images'
dir.create(outImageDir)


#---- Load Data ----#
rawD <- read.csv(file.path(rawDir,'UEA_dat.csv'), header=TRUE,sep=",")
df = rawD

#test plot
p = ggplot(df, aes(x = target, y = movement.time))
p <- p + geom_point(shape = 21, size = 3, colour = "indianred2", fill = "lightpink", stroke = 2)
p

#---- plot mean DA and controls ----#
by_patient_hand_target_view <- df %>% group_by(PAT, HAND, target, VIEW, PPT)

#ABSOLUTE ERROR
d <- by_patient_hand_target_view %>% summarise(ABSERR = mean(ABSERR, na.rm = TRUE),.groups = "keep")
#check labels
#  d %>% group_keys()
#  d %>% group_indices()
#  d %>% group_vars()
ggplot(d) +
  geom_point( aes(x = target, y = ABSERR, colour = PAT)) +
  geom_line( aes(x = target, y = ABSERR, group = PPT, colour = PAT)) +
  facet_grid(VIEW ~ HAND) +
  scale_x_continuous(n.breaks = 7)

#ABSOLUTE ERROR
d <- by_patient_hand_target_view %>% summarise(ABSERR = mean(ABSERR, na.rm = TRUE),.groups = "keep")
#check labels
#  d %>% group_keys()
#  d %>% group_indices()
#  d %>% group_vars()
ggplot(d) +
  geom_point( aes(x = target, y = ABSERR, colour = PAT)) +
  geom_line( aes(x = target, y = ABSERR, group = PPT, colour = PAT)) +
  facet_grid(VIEW ~ HAND) +
  scale_x_continuous(n.breaks = 7)

#ANGULAR ERROR
d <- by_patient_hand_target_view %>% summarise(ANGerr = mean(ANGerr, na.rm = TRUE),.groups = "keep")
#check labels
#  d %>% group_keys()
#  d %>% group_indices()
#  d %>% group_vars()
ggplot(d) +
  geom_point( aes(x = target, y = ANGerr, colour = PAT)) +
  geom_line( aes(x = target, y = ANGerr, group = PPT, colour = PAT)) +
  facet_grid(VIEW ~ HAND) +
  scale_x_continuous(n.breaks = 7)

