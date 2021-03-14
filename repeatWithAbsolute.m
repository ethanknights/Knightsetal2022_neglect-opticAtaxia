%% --- repeat but absolute the error values --- %%

listVarStrs = {'ANGerr'}
listAxisVal_allTargets_y = {[-1 5]};
listAxisVal_sideOfSpace_y = {[-1 5]};


for v = 1:length(listVarStrs)
  
  thisVarStr = listVarStrs{v};
  axisVal_allTargets_y = listAxisVal_allTargets_y{v};
  axisVal_sideOfSpace_y = listAxisVal_sideOfSpace_y{v};

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
  stats = doCrawfordTtest_allTargets(thisVarStr,data,conditionNames,outDir,axisVal_allTargets_y); %change
  stats = doCrawfordTtest_sideOfSpace(thisVarStr,data,conditionNames,outDir,axisVal_sideOfSpace_y); %change
  % [h] = combinePlots(thisVarStr,outImageDir,axisVal) %doesnt work, subplot too tempormetnal
  diary OFF
  

%   diary(fullfile(outDir,[thisVarStr,'_inputForCrawford-DissocsBayes_ES.txt']));
%   plotBDST_allTargets(thisVarStr,data,conditionNames,outDir,axisVal_allTargets_y);
% %   plotBDST_sideOfSpace(thisVarStr,data,conditionNames,outDir,axisVal_sideOfSpace_y);
%   diary OFF


end
