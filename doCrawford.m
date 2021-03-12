function [stats] = doCrawford(thisVarStr,data,conditionNames,outImageDir,axisVal)
%% Crawford on the seven targets per condition



fprintf('Crawford Stats for variable:\n%s \n================\n', thisVarStr)

for c = 1:4
  

  currConditionName = conditionNames{c};
  fprintf('Current Condition: %s\n',currConditionName)
  
  controlMean = mean(data.targetMean(2:end,:,c));
  for t = 1:7
    fprintf('Control Mean for Target %s: %s\n',num2str(t),num2str(controlMean(t)))
  end
  
  controlStd = std(data.targetMean(2:end,:,c));
  for t = 1:7
    fprintf('Control Std for Target %s: %s\n',num2str(t),num2str(controlStd(t)))
  end
  
  patientScores = data.targetMean(1,:,c);
  for t = 1:7
    fprintf('Patient Score for Target %s: %s\n',num2str(t),num2str(patientScores(t)))
  end
  
  nC = size(patientScores,2);
  for t = 1:7
    fprintf('Control Group N for Target %s: %s\n',num2str(t),num2str(nC))
  end
  
  allControls = data.targetMean(2:end,:,c); %only for plotting 
  
  
  close all
  figure('position',[100,100,1200,1200])

  %% Crawford ttest
  stats{c}= runCrawford(patientScores,controlMean,controlStd,nC, ...
    1,axisVal,thisVarStr,allControls); %for plot, use 0 for no plot
  
  %% save plot
  title(currConditionName);
  %outName = fullfile(outImageDir,[thisVarStr,'_',currConditionName,'.eps']);
  outName = fullfile(outImageDir,[thisVarStr,'_',currConditionName]);
  cmdStr = sprintf('export_fig %s.tiff -transparent',outName)
  %cmdStr = sprintf('export_fig %s',outName)
  eval(cmdStr);
  
  h=gcf;
  savefig(h,[outName,'.fig']);
  
  %% print stats
  disp('two tailed p (per target):')
  disp(stats{c}.p(2,:)) %2 is two-tailed

  %disp('one tailed p (per target):')
  %disp(stats{c}.p(1,:)) %1 is two-tailed

  disp('point estimate of abnormality (per target):')
  disp(stats{c}.p(3,:)) %% point estimate of abnormality (see paper)

  disp('df, tvalue, (per target):')
  disp([stats{c}.df(:),stats{c}.t(:)])

  disp('CI (per target) 1:2 is 95% CI% CI-3:4 is 99%:')
  disp([stats{c}.CI(:,1),stats{c}.CI(:,2),stats{c}.CI(:,3),stats{c}.CI(:,4)]) 


end
    
end