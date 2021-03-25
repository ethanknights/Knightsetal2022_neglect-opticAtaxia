%% --- repeat general analysis but absolute the error values --- %%
%just switches getData() with getData_AbsoluteVersion()
%Also add '_ABSOLUTE' to thisVarStr so files are stored in new directories
%This is NOT for pointingError_Absolute - That's handled in wrapper_pointingError

listVarStrs = { 'ANGerr', ...
                'XError', ... %delete spaces later, so not 'X Error ' etc
                'YError'}; 
listAxisVal_allTargets_y_ttest = {  [-2 5], ...
                                    [-35 35], ...
                                    [-50 50]};
listAxisVal_sideOfSpace_y_ttest = { [-2 5], ...
                                    [-20 20], ...
                                    [-35 35]};
listAxisVal_allTargets_y_BDST = {   [-5 5], ...
                                    [-35 35], ...
                                    [-50 50]};
listAxisVal_sideOfSpace_y_BDST = {  [-5 5], ...
                                    [-20 20], ...
                                    [-35 35]};



for v = 1:length(listVarStrs)
  
  thisVarStr = listVarStrs{v};
  axisVal_allTargets_y_ttest = listAxisVal_allTargets_y_ttest{v};
  axisVal_sideOfSpace_y_ttest = listAxisVal_sideOfSpace_y_ttest{v};
  
  axisVal_allTargets_y_BDST = listAxisVal_allTargets_y_BDST{v};
  axisVal_sideOfSpace_y_BDST = listAxisVal_sideOfSpace_y_BDST{v};
  

  [data,tmpH] = getData_AbsoluteVersion(thisVarStr,rawData,sNames); %change!

  thisVarStr = [thisVarStr,'_ABSOLUTE']; %change
  
  outDir = fullfile('results',thisVarStr); 
  try
    rmdir(outDir,'s');
  catch
    %NOOP
  end
  mkdir(outDir)
  
  diary(fullfile(outDir,[thisVarStr,'_inputForCrawford-SingleBayes_ES.txt']));
  stats = doCrawfordTtest_allTargets(thisVarStr,data,conditionNames,outDir,axisVal_allTargets_y_ttest);
  stats = doCrawfordTtest_sideOfSpace(thisVarStr,data,conditionNames,outDir,axisVal_sideOfSpace_y_ttest);
  diary OFF

  diary(fullfile(outDir,[thisVarStr,'_inputForCrawford-DissocsBayes_ES.txt']));
  plotBDST_allTargets(thisVarStr,data,conditionNames,outDir,axisVal_allTargets_y_BDST);
  plotBDST_sideOfSpace(thisVarStr,data,conditionNames,outDir,axisVal_sideOfSpace_y_BDST);
  diary OFF
end
