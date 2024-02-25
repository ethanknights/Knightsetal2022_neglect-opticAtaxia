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

format_df_collapse_space <- function(df) {
  # collapse side of space
  df$leftSpace = rowMeans(x = df[,1:3])
  df$rightSpace = rowMeans(x = df[,5:7])
  colnames(df)[colnames(df) == "V4"] <- "Centre"
  df <- df[, c("leftSpace", "Centre", "rightSpace")]
  
  return(df)}


format_df_add_patient_labels <- function(df) {
  # add patient_label columns
  df <- df %>%
    mutate(
      subjName = ifelse(row_number() == 1, "EB", paste("Control", 1:12, sep = "")),
      patient_label = ifelse(row_number() == 1, "Patient", "Control")
    )
  
  return(df)}


format_df_to_long <- function(df) {
  # long conversion
  df <- df %>%
    pivot_longer(cols = c("leftSpace", "Centre", "rightSpace"),
                 names_to = "full_condition_name",
                 values_to = "mean")
  order_levels <- c("leftSpace", "Centre", "rightSpace")
  df$full_condition_name <- factor(df$full_condition_name, levels = order_levels)
  return(df)
}


do_line_plot <- function(df_summary, descript_str, y_lim_lo = NULL, y_lim_hi = NULL) {

  p <- ggplot() +
    geom_line(data = df_summary[df_summary$patient_label == "Control", ], 
              aes(x = full_condition_name, y = mean, linetype = patient_label, group = subjName),
              size = 0.8, alpha = 0.8, color = "cyan") +
    geom_line(data = df_summary[df_summary$patient_label == "Patient", ], 
              aes(x = full_condition_name, y = mean, linetype = patient_label, group = subjName),
              size = 0.8, alpha = 0.8, color = "magenta") +
    geom_point(data = df_summary[df_summary$patient_label == "Control", ], 
               aes(x = full_condition_name, y = mean, colour = patient_label, group = subjName),
               size = 8, alpha = 0.8, shape = 21, fill = "cyan", color = "black") +
    geom_point(data = df_summary[df_summary$patient_label == "Patient", ], 
               aes(x = full_condition_name, y = mean, colour = patient_label, group = subjName),
               size = 8, alpha = 0.8, shape = 21, fill = "magenta", color = "black") +
    scale_linetype_manual(values = c("dashed", "solid")) +
    scale_x_discrete(guide = guide_axis(angle = 60)) +
    theme(panel.background = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"), 
          legend.position = "none")
  if (!is.null(y_lim_lo) && !is.null(y_lim_hi)) {
    p <- p + scale_y_continuous(limits = c(y_lim_lo, y_lim_hi))
  }
  
  image_output_path = file.path(outImageDir, paste0(descript_str, '.png'))
  print(image_output_path)
  ggsave(filename = image_output_path,
         plot = p,
         width = 15,  #width = cmwidth,
         height = 9,  #height = cmheight,
         units = 'cm',
         dpi = 300,
         limitsize = TRUE)
  return(p)}


# Script Setup
rootOutDir <- file.path('..','results')
outImageDir <- 'images'
listVarStr = c('pointingError_ABSOLUTE','reactiontime','movementtime')
listVarAxisBounds_y <- list(
  pointingError_ABSOLUTE = c(-20, 20),
  reactiontime = c(-500, 500),
  movementtime = c(-500, 500)
)
# listTargetStr = c('-28','-17','-11','0','11','17','28','Left','Right')
# listConditionStr <- c('LHFREE','LHPER','RHFREE','RHPER')

# main - Create plots
for (currVar in 1:length(listVarStr)) {
  # currVar = 1  # debug
  currVarStr = listVarStr[currVar]
  
  #read data
  df_LHFREE = read.csv(file.path(rootOutDir,currVarStr,'csv','LHFREE.csv'), header = FALSE)
  df_LHPER = read.csv(file.path(rootOutDir,currVarStr,'csv','LHPER.csv'), header = FALSE)
  df_RHFREE = read.csv(file.path(rootOutDir,currVarStr,'csv','RHFREE.csv'), header = FALSE)
  df_RHPER = read.csv(file.path(rootOutDir,currVarStr,'csv','RHPER.csv'), header = FALSE)
  
  # prepare for ggplot2
  ## collapse space
  df_LHFREE <- format_df_collapse_space(df_LHFREE)
  df_LHPER <- format_df_collapse_space(df_LHPER)
  df_RHFREE <- format_df_collapse_space(df_RHFREE)
  df_RHPER <- format_df_collapse_space(df_RHPER)
  
  ## condition comparison df's
  df_vision_LH  = df_LHPER - df_LHFREE
  df_vision_RH  = df_RHPER - df_RHFREE
  df_hand_FREE  = df_LHFREE - df_RHFREE
  df_hand_PER   = df_LHPER - df_RHPER
  
  ## patient labels
  df_vision_LH <- format_df_add_patient_labels(df_vision_LH)
  df_vision_RH <- format_df_add_patient_labels(df_vision_RH)
  df_hand_FREE <- format_df_add_patient_labels(df_hand_FREE)
  df_hand_PER <- format_df_add_patient_labels(df_hand_PER)
  
  ## long conversion
  df_vision_LH <- format_df_to_long(df_vision_LH)
  df_vision_RH <- format_df_to_long(df_vision_RH)
  df_hand_FREE <- format_df_to_long(df_hand_FREE)
  df_hand_PER <- format_df_to_long(df_hand_PER)


  # plot
  p <- do_line_plot(df_vision_LH, paste0(currVarStr,'_vision_LH'), # Modify me
                    listVarAxisBounds_y[[currVarStr]][1], listVarAxisBounds_y[[currVarStr]][2]); p
  p <- do_line_plot(df_vision_RH, paste0(currVarStr,'_vision_RH'), # Modify me
                    listVarAxisBounds_y[[currVarStr]][1], listVarAxisBounds_y[[currVarStr]][2]); p
  p <- do_line_plot(df_hand_FREE, paste0(currVarStr,'_hand_FREE'), # Modify me
                    listVarAxisBounds_y[[currVarStr]][1], listVarAxisBounds_y[[currVarStr]][2]); p
  p <- do_line_plot(df_hand_PER, paste0(currVarStr,'_hand_PER'), # Modify me
                    listVarAxisBounds_y[[currVarStr]][1], listVarAxisBounds_y[[currVarStr]][2]); p

}
