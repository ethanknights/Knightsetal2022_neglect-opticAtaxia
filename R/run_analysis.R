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


for (currVar in 1:length(listVarStr)) {
  
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
  
  
  #======================  BTD  ======================#
  #--- init ---#
  outT_LHFREE <- as.data.frame(matrix(nrow = 9, ncol = 9))
  outT_LHPER <- as.data.frame(matrix(nrow = 9, ncol = 9))
  outT_RHFREE <- as.data.frame(matrix(nrow = 9, ncol = 9))
  outT_RHPER <- as.data.frame(matrix(nrow = 9, ncol = 9))
  
  for (currTarget in 1:ncol(df_LHFREE)) {
    
    #--- do BTD ---#
    df = df_LHFREE
    BTD_LHFREE <- BTD(case = df[1,currTarget],controls = df[2:nrow(df),currTarget],
                      alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    
    df = df_LHPER
    BTD_LHPER <- BTD(case = df[1,currTarget],controls = df[2:nrow(df),currTarget],
                     alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    
    df = df_RHFREE
    BTD_RHFREE <- BTD(case = df[1,currTarget],controls = df[2:nrow(df),currTarget],
                      alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    
    df = df_RHPER
    BTD_RHPER <- BTD(case = df[1,currTarget],controls = df[2:nrow(df),currTarget],
                     alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    
    #--- store in table ---#
    outT_LHFREE[currTarget,1] <- 'Left'
    outT_LHFREE[currTarget,2] <- 'Free'
    outT_LHFREE[currTarget,3] <- listTargetStr[currTarget]
    outT_LHFREE[currTarget,4] <- round(BTD_LHFREE$p.value, digits = 3)
    outT_LHFREE[currTarget,5] <- round(BTD_LHFREE$estimate[1], digits = 2)
    outT_LHFREE[currTarget,6] <- round(BTD_LHFREE$interval[2], digits = 2)
    outT_LHFREE[currTarget,7] <- round(BTD_LHFREE$interval[3], digits = 2)
    outT_LHFREE[currTarget,8] <- round(BTD_LHFREE$estimate[2], digits = 2)
    outT_LHFREE[currTarget,9] <- round(BTD_LHFREE$interval[4], digits = 2)
    outT_LHFREE[currTarget,10] <- round(BTD_LHFREE$interval[5], digits = 2)
    
    outT_LHPER[currTarget,1] <- 'Left'
    outT_LHPER[currTarget,2] <- 'Peripheral'
    outT_LHPER[currTarget,3] <- listTargetStr[currTarget]
    outT_LHPER[currTarget,4] <- round(BTD_LHPER$p.value, digits = 3)
    outT_LHPER[currTarget,5] <- round(BTD_LHPER$estimate[1], digits = 2)
    outT_LHPER[currTarget,6] <- round(BTD_LHPER$interval[2], digits = 2)
    outT_LHPER[currTarget,7] <- round(BTD_LHPER$interval[3], digits = 2)
    outT_LHPER[currTarget,8] <- round(BTD_LHPER$estimate[2], digits = 2)
    outT_LHPER[currTarget,9] <- round(BTD_LHPER$interval[4], digits = 2)
    outT_LHPER[currTarget,10] <- round(BTD_LHPER$interval[5], digits = 2)
    
    outT_RHFREE[currTarget,1] <- 'Right'
    outT_RHFREE[currTarget,2] <- 'Free'
    outT_RHFREE[currTarget,3] <- listTargetStr[currTarget]
    outT_RHFREE[currTarget,4] <- round(BTD_RHFREE$p.value, digits = 3)
    outT_RHFREE[currTarget,5] <- round(BTD_RHFREE$estimate[1], digits = 2)
    outT_RHFREE[currTarget,6] <- round(BTD_RHFREE$interval[2], digits = 2)
    outT_RHFREE[currTarget,7] <- round(BTD_RHFREE$interval[3], digits = 2)
    outT_RHFREE[currTarget,8] <- round(BTD_RHFREE$estimate[2], digits = 2)
    outT_RHFREE[currTarget,9] <- round(BTD_RHFREE$interval[4], digits = 2)
    outT_RHFREE[currTarget,10] <- round(BTD_RHFREE$interval[5], digits = 2)
    
    outT_RHPER[currTarget,1] <- 'Right'
    outT_RHPER[currTarget,2] <- 'Peripheral'
    outT_RHPER[currTarget,3] <- listTargetStr[currTarget]
    outT_RHPER[currTarget,4] <- round(BTD_RHPER$p.value, digits = 3)
    outT_RHPER[currTarget,5] <- round(BTD_RHPER$estimate[1], digits = 2)
    outT_RHPER[currTarget,6] <- round(BTD_RHPER$interval[2], digits = 2)
    outT_RHPER[currTarget,7] <- round(BTD_RHPER$interval[3], digits = 2)
    outT_RHPER[currTarget,8] <- round(BTD_RHPER$estimate[2], digits = 2)
    outT_RHPER[currTarget,9] <- round(BTD_RHPER$interval[4], digits = 2)
    outT_RHPER[currTarget,10] <- round(BTD_RHPER$interval[5], digits = 2)
  }  
  
  #--- format BTD Table ---#
  outT_BTD = rbind(outT_LHFREE,outT_LHPER,outT_RHFREE,outT_RHPER)
  colnames(outT_BTD) <- c("Hand","Vision", "Target", 'p', 'Z-CC', 'CI Low.', 'CI Upp.', 'Prop. below case (%)', 'CI Low.', 'CI Upp.' )
  #0 to "<.001"
  idx = outT_BTD == 0; idx[1:nrow(idx),3] = FALSE #dont replace target 0
  outT_BTD[idx] = "<.001"
  #only 1 condition header
  outT_BTD[2:18,1] = ""
  outT_BTD[20:36,1] = ""
  outT_BTD[2:9,2] = ""
  outT_BTD[11:18,2] = ""
  outT_BTD[20:27,2] = ""
  outT_BTD[29:36,2] = ""
  
  #--- write BTD ---#
  write.csv(outT_BTD,file.path(rootOutDir,currVarStr,'csv','Table_BTD.csv'),row.names=FALSE)
  
  
  
  
  
  #======================  BSDT  ======================#
  #--- init ---#
  outT_Vision_LH <- as.data.frame(matrix(nrow = 9, ncol = 9))
  outT_Vision_RH <- as.data.frame(matrix(nrow = 9, ncol = 9))
  outT_Hand_FREE <- as.data.frame(matrix(nrow = 9, ncol = 9))
  outT_Hand_PER <- as.data.frame(matrix(nrow = 9, ncol = 9))
  
  for (currTarget in 1:ncol(df_LHFREE)) {
    
    #--- do BSDT ---#
    #- Compare Vision -#
    df_a = df_LHFREE
    df_b = df_LHPER
    BSDT_Vision_LH <- BSDT(case_a = df_a[1,currTarget],controls_a = df_a[2:nrow(df),currTarget],
                           case_b = df_b[1,currTarget],controls_b = df_b[2:nrow(df),currTarget],                          
                           alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    
    df_a = df_RHFREE
    df_b = df_RHPER
    BSDT_Vision_RH <- BSDT(case_a = df_a[1,currTarget],controls_a = df_a[2:nrow(df),currTarget],
                           case_b = df_b[1,currTarget],controls_b = df_b[2:nrow(df),currTarget],                          
                           alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    
    #- Compare Hand -#    
    df_a = df_LHFREE
    df_b = df_RHFREE
    BSDT_Hand_FREE <- BSDT(case_a = df_a[1,currTarget],controls_a = df_a[2:nrow(df),currTarget],
                           case_b = df_b[1,currTarget],controls_b = df_b[2:nrow(df),currTarget],                          
                           alternative = c("two.sided"),int_level = 0.95,iter = 10000)
    
    df_a = df_LHPER
    df_b = df_RHPER
    BSDT_Hand_PER <- BSDT(case_a = df_a[1,currTarget],controls_a = df_a[2:nrow(df),currTarget],
                           case_b = df_b[1,currTarget],controls_b = df_b[2:nrow(df),currTarget],                          
                           alternative = c("two.sided"),int_level = 0.95,iter = 10000)
  
    #--- store in table ---#
    outT_Vision_LH[currTarget,1] <- 'Vision'
    outT_Vision_LH[currTarget,2] <- 'Left Hand'
    outT_Vision_LH[currTarget,3] <- listTargetStr[currTarget]
    outT_Vision_LH[currTarget,4] <- round(BSDT_Vision_LH$p.value, digits = 3)
    outT_Vision_LH[currTarget,5] <- round(BSDT_Vision_LH$estimate[3], digits = 2)
    outT_Vision_LH[currTarget,6] <- round(BSDT_Vision_LH$interval[2], digits = 2)
    outT_Vision_LH[currTarget,7] <- round(BSDT_Vision_LH$interval[3], digits = 2)
    outT_Vision_LH[currTarget,8] <- round(BSDT_Vision_LH$estimate[4], digits = 2)
    outT_Vision_LH[currTarget,9] <- round(BSDT_Vision_LH$interval[4], digits = 2)
    outT_Vision_LH[currTarget,10] <- round(BSDT_Vision_LH$interval[5], digits = 2)
    
    outT_Vision_RH[currTarget,1] <- 'Vision'
    outT_Vision_RH[currTarget,2] <- 'Right Hand'
    outT_Vision_RH[currTarget,3] <- listTargetStr[currTarget]
    outT_Vision_RH[currTarget,4] <- round(BSDT_Vision_RH$p.value, digits = 3)
    outT_Vision_RH[currTarget,5] <- round(BSDT_Vision_RH$estimate[3], digits = 2)
    outT_Vision_RH[currTarget,6] <- round(BSDT_Vision_RH$interval[2], digits = 2)
    outT_Vision_RH[currTarget,7] <- round(BSDT_Vision_RH$interval[3], digits = 2)
    outT_Vision_RH[currTarget,8] <- round(BSDT_Vision_RH$estimate[4], digits = 2)
    outT_Vision_RH[currTarget,9] <- round(BSDT_Vision_RH$interval[4], digits = 2)
    outT_Vision_RH[currTarget,10] <- round(BSDT_Vision_RH$interval[5], digits = 2)
    
    outT_Hand_FREE[currTarget,1] <- 'Hand'
    outT_Hand_FREE[currTarget,2] <- 'Free'
    outT_Hand_FREE[currTarget,3] <- listTargetStr[currTarget]
    outT_Hand_FREE[currTarget,4] <- round(BSDT_Hand_FREE$p.value, digits = 3)
    outT_Hand_FREE[currTarget,5] <- round(BSDT_Hand_FREE$estimate[3], digits = 2)
    outT_Hand_FREE[currTarget,6] <- round(BSDT_Hand_FREE$interval[2], digits = 2)
    outT_Hand_FREE[currTarget,7] <- round(BSDT_Hand_FREE$interval[3], digits = 2)
    outT_Hand_FREE[currTarget,8] <- round(BSDT_Hand_FREE$estimate[4], digits = 2)
    outT_Hand_FREE[currTarget,9] <- round(BSDT_Hand_FREE$interval[4], digits = 2)
    outT_Hand_FREE[currTarget,10] <- round(BSDT_Hand_FREE$interval[5], digits = 2)
    
    outT_Hand_PER[currTarget,1] <- 'Hand'
    outT_Hand_PER[currTarget,2] <- 'Peripheral'
    outT_Hand_PER[currTarget,3] <- listTargetStr[currTarget]
    outT_Hand_PER[currTarget,4] <- round(BSDT_Hand_PER$p.value, digits = 3)
    outT_Hand_PER[currTarget,5] <- round(BSDT_Hand_PER$estimate[3], digits = 2)
    outT_Hand_PER[currTarget,6] <- round(BSDT_Hand_PER$interval[2], digits = 2)
    outT_Hand_PER[currTarget,7] <- round(BSDT_Hand_PER$interval[3], digits = 2)
    outT_Hand_PER[currTarget,8] <- round(BSDT_Hand_PER$estimate[4], digits = 2)
    outT_Hand_PER[currTarget,9] <- round(BSDT_Hand_PER$interval[4], digits = 2)
    outT_Hand_PER[currTarget,10] <- round(BSDT_Hand_PER$interval[5], digits = 2)
  }
  
  
  #--- format BTD Table ---#
  outT_BSDT = rbind(outT_Vision_LH,outT_Vision_RH,outT_Hand_FREE,outT_Hand_PER)
  colnames(outT_BSDT) <- c("Difference Comparison","Condition", "Target", 'p', 'Z-DCC', 'CI Low.', 'CI Upp.', 'Prop. below case (%)', 'CI Low.', 'CI Upp.' )
  #0 to "<.001"
  idx = outT_BSDT == 0; idx[1:nrow(idx),3] = FALSE #dont replace target 0
  outT_BSDT[idx] = "<.001"
  #only 1 condition header
  outT_BSDT[2:18,1] = ""
  outT_BSDT[20:36,1] = ""
  outT_BSDT[2:9,2] = ""
  outT_BSDT[11:18,2] = ""
  outT_BSDT[20:27,2] = ""
  outT_BSDT[29:36,2] = ""
  
  #--- write BSDT ---#
  write.csv(outT_BSDT,file.path(rootOutDir,currVarStr,'csv','Table_BSDT.csv'),row.names=FALSE)

  
}


          
                           