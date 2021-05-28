#Test asymmetry of RT Peripheral Vision Effect

library(singcar) #v0.1.3

rm(list = ls()) # clears environment
cat("\f") # clears console
dev.off() # clears graphics device
graphics.off() #clear plots

#---- Setup ----#
wd = dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(wd)

rootOutDir <- file.path('..','results')

listVarStr = c('pointingError_ABSOLUTE','reactiontime','movementtime')
listTargetStr = c('-28','-17','-11','0','11','17','28','Left','Right')

#listConditionStr <- c('LHFREE','LHPER','RHFREE','RHPER')


currVar = 2
  
  currVarStr = listVarStr[currVar]
  
  #read data
  df_LHFREE = read.csv(file.path(rootOutDir,currVarStr,'csv','LHFREE.csv'), header = FALSE)
  df_LHPER = read.csv(file.path(rootOutDir,currVarStr,'csv','LHPER.csv'), header = FALSE)
  df_RHFREE = read.csv(file.path(rootOutDir,currVarStr,'csv','RHFREE.csv'), header = FALSE)
  df_RHPER = read.csv(file.path(rootOutDir,currVarStr,'csv','RHPER.csv'), header = FALSE)
  
  #collapse Side of Space
  df_LHFREE$leftSpace = rowMeans(x = df_LHFREE[,1:3])
  df_LHFREE$rightSpace = rowMeans(x = df_LHFREE[,5:7])
  
  df_LHPER$leftSpace = rowMeans(x = df_LHPER[,1:3])
  df_LHPER$rightSpace = rowMeans(x = df_LHPER[,5:7])
  
  df_RHFREE$leftSpace = rowMeans(x = df_RHFREE[,1:3])
  df_RHFREE$rightSpace = rowMeans(x = df_RHFREE[,5:7])
  
  df_RHPER$leftSpace = rowMeans(x = df_RHPER[,1:3])
  df_RHPER$rightSpace = rowMeans(x = df_RHPER[,5:7])
  
  #======================  Approach 1 - BDT (Left - Centre or Right) patient vs. control ======================#

  #--- do BTD ---#
  df = df_RHPER
  
  # left - centre
  a = df[,8] - df[,4]
  
  BTD <- BTD(case = a[1],controls = a[2:nrow(df)],
                      alternative = c("two.sided"),int_level = 0.95,iter = 10000)
  BTD
  
  # left - right
  a = df[,8] - df[,9]
  
  BTD <- BTD(case = a[1],controls = a[2:nrow(df)],
             alternative = c("two.sided"),int_level = 0.95,iter = 10000)
  BTD
  

  
  
  #======================  Approach 2 - Side of Space BSDT ======================#
    #--- do BSDT ---#
    #- Compare Side of Space -#
  
    #1. Left vs. Centre
    df_a = df_RHPER
    df_b = df_RHPER
    
    currTarget_a = 8 #left space
    currTarget_b = 4 #central space
    
    BSDT_sideOfSpace <- BSDT(case_a = df_a[1,currTarget_a],controls_a = df_a[2:nrow(df),currTarget_a],
                           case_b = df_b[1,currTarget_b],controls_b = df_b[2:nrow(df),currTarget_b],                          
                           alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    BSDT_sideOfSpace
    
    #1. Left vs. Right
    df_a = df_RHPER
    df_b = df_RHPER
    
    currTarget_a = 8 #left space
    currTarget_b = 9 #right space
    
    BSDT_sideOfSpace <- BSDT(case_a = df_a[1,currTarget_a],controls_a = df_a[2:nrow(df),currTarget_a],
                             case_b = df_b[1,currTarget_b],controls_b = df_b[2:nrow(df),currTarget_b],                          
                             alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    BSDT_sideOfSpace
