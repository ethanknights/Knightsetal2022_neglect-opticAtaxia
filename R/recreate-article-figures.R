# Recreate article figures in R for consistency with bimanual experiment.
# (No matlab license!)
library(ggplot2)
library(dplyr)
library(tidyr)

rm(list = ls()) # clears environment
cat("\f") # clears console
dev.off() # clears graphics device
graphics.off() #clear plots

#---- Setup ----#
wd = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(wd)


do_line_plot <- function(df_summary, descript_str) {
  
  p <- ggplot(data = df_summary, aes(x = full_condition_name, y = mean, colour = patient_label, group = subjName)) +
    geom_point(size = 4, alpha = 0.8, shape = 21, aes(fill = patient_label)) +
    geom_point(size = 4, alpha = 0.8, shape = 21, colour = "black", stroke = 0.6) +
    geom_line(size = 0.8, alpha = 0.8, aes(linetype = patient_label)) +
    scale_color_manual(values = c("magenta", "cyan")) +
    scale_fill_manual(values = c("magenta", "cyan")) +
    scale_linetype_manual(values = c("solid", "dashed")) +
    scale_x_discrete(guide = guide_axis(angle = 60)) +
    theme(panel.background = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), 
          legend.position = "none")
  
  ggsave(filename = file.path(outImageDir, paste0('lineplot', descript_str, '.png')),
         plot = p,
         width = 15,  #width = cmwidth,
         height = 9,  #height = cmheight,
         units = 'cm',
         dpi = 300,
         limitsize = TRUE)
  return(p)}


format_df <- function(df) {
  # collapse side of space
  df$leftSpace = rowMeans(x = df[,1:3])
  df$rightSpace = rowMeans(x = df[,5:7])
  colnames(df)[colnames(df) == "V4"] <- "Centre"
  df <- df[, c("leftSpace", "Centre", "rightSpace")]
  
  # add patient_label columns
  df <- df %>%
    mutate(
      subjName = ifelse(row_number() == 1, "EB", paste("Control", 1:12, sep = "")),
      patient_label = ifelse(row_number() == 1, "Patient", "Control")
    )
  
  # long conversion
  df <- df %>%
    pivot_longer(cols = c("leftSpace", "Centre", "rightSpace"),
                 names_to = "full_condition_name",
                 values_to = "mean")
  
  return(df)}

rootOutDir <- file.path('..','results')
outImageDir <- 'images'
listVarStr = c('pointingError_ABSOLUTE','reactiontime','movementtime')
# listTargetStr = c('-28','-17','-11','0','11','17','28','Left','Right')
# listConditionStr <- c('LHFREE','LHPER','RHFREE','RHPER')


#for (currVar in 1:length(listVarStr)) {
  currVar = 1 
  currVarStr = listVarStr[currVar]
  
  #read data
  df_LHFREE = read.csv(file.path(rootOutDir,currVarStr,'csv','LHFREE.csv'), header = FALSE)
  df_LHPER = read.csv(file.path(rootOutDir,currVarStr,'csv','LHPER.csv'), header = FALSE)
  df_RHFREE = read.csv(file.path(rootOutDir,currVarStr,'csv','RHFREE.csv'), header = FALSE)
  df_RHPER = read.csv(file.path(rootOutDir,currVarStr,'csv','RHPER.csv'), header = FALSE)
  
  # prepare for ggplot2
  df_LHFREE <- format_df(df_LHFREE)
  df_LHPER <- format_df(df_LHPER)
  df_RHFREE <- format_df(df_RHFREE)
  df_RHPER <- format_df(df_RHPER)

  # Condition Comparisons
  df_vision_LH  = df_LHPER - df_LHFREE
  df_vision_RH  = df_RHPER - df_RHFREE
  
  df_hand_FREE  = df_LHFREE - df_RHFREE
  df_hand_PER   = df_LHPER - df_RHPER
  
  curr_df_summary <- df_summary %>% select(subjName, patient_label, full_condition_name, mean = descript_str_DV)
  p <- do_line_plot(curr_df_summary, currVarStr); p
  p <- p + labs(title = 'Mean Pointing Error by Condition and Patient'); p
  
  
#  }
