#explore DA's data again... 22/01/2021


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


#---- plot mean RT of DA and controls ----#
#Check data by target
by_patient_target <- df %>% group_by(PAT, target)

#check labels
#  by_patient_target %>% group_keys()
#  by_patient_target %>% group_indices()
#  by_patient_target %>% group_vars()

by_patient_target %>% summarise(movement.time = mean(movement.time, na.rm = TRUE))

#d <- by_patient_target %>% summarise(movement.time = mean(movement.time, na.rm = TRUE))
d <- by_patient_target %>% summarise(movement.time = mean(movement.time, na.rm = TRUE),.groups = "keep")


p = ggplot(d, aes(x = target, y = movement.time))
p <- p + geom_point(shape = d$PAT, size = 3, colour = "red", fill = "black", stroke = 2)
p






