nSubs = 11; %we are about to drop AL11 

%% ==== trials analysed ==== %%
for c = 1:4
  disp(conditionNames{c})
  disp('mean')
  disp(mean(mean(data.nTrials(:,:,c))))
  disp('std')
  disp(std(std(data.nTrials(:,:,c))))
  disp('min')
  disp(min(min(data.nTrials(:,:,c))))
  disp('max')
  disp(max(max(data.nTrials(:,:,c))))
end

%crawford t-test
for c = 1:4
  disp(conditionNames{c})
  patientScore = sum(data.nTrials(1,:,c))
  for controlN = 2:nSubs
    cc(controlN) = sum(data.nTrials(controlN,:,c));
  end
  controlMean = mean(cc)
  controlStd = std(cc)

  out = runCrawford(patientScore,controlMean,controlStd,nSubs,0);
  fprintf('p value (two-tailed) = %s\n', num2str(out.p(2)))
end


%% ==== other distributions ==== %%
fN = fullfile('data','trialDistributions','trialDistributions.xlsx');



%% nTrialsCollected
sheetName = 'nTrialsCollected';
[~,~,rawD] = xlsread(fN,sheetName);
tmpD = cell2mat(rawD(2:end,2:end))
tmpH = rawD(1,2:end)'; %1 is partiicpant

tmpD(2,:) = []; %drop AL11 as we do in main analysis

tmp = mean(mean(tmpD));
fprintf('total mean trials = %s\n', num2str(tmp) )

tmp = mean(mean(tmpD(:,1:14)));
fprintf('total mean trials for free vision only = %s std = %s\n', num2str(tmp), num2str(std(std(tmpD(:,1:14)))) )
tmp = mean(mean(tmpD(:,15:28)));
fprintf('total mean trials for peri vision only = %s std = %s\n', num2str(tmp), num2str(std(std(tmpD(:,15:28)))) )

%total trials collected
nTrialsTotalDist = tmpD;
nTrialsTotal = sum(nTrialsTotalDist,2);
nTrials = sum(nTrialsTotal);



%% nEye
sheetName = 'nEyeErrors';

[~,~,rawD] = xlsread(fN,sheetName);
tmpD = cell2mat(rawD(2:end,2:end));
tmpH = rawD(1,2:end)'; %1 is partiicpant

tmpD(2,:) = []; %drop AL11 as we do in main analysis

tmp = sum(sum(tmpD))
fprintf('total n eye error trials = %s\n', num2str( tmp * (100 / nTrials)) )

%crawford t-test
conditionRefs = [1,7;8,14];
for c = 1:2
  if c == 1; disp(tmpH{1}); elseif c == 2; disp(tmpH{8}); end
  patientScore = sum(tmpD(1,conditionRefs(c,1) : conditionRefs(c,2)))
  for controlN = 2:nSubs
    cc(controlN) = sum(tmpD(controlN,conditionRefs(c,1) : conditionRefs(c,2)));
  end
  controlMean = mean(cc)
  controlStd = std(cc)

  out = runCrawford(patientScore,controlMean,controlStd,nSubs,0);
  fprintf('p value (two-tailed) = %s\n', num2str(out.p(2)))
end

%% nKinematicErrors
sheetName = 'nHandError';

[~,~,rawD] = xlsread(fN,sheetName);
tmpD = cell2mat(rawD(2:end,2:end));
tmpH = rawD(1,2:end)'; %1 is partiicpant

tmpD(2,:) = []; %drop AL11 as we do in main analysis

tmp = sum(sum(tmpD))
fprintf('total n HandErrors trials = %s\n', num2str( tmp * (100 / nTrials)) )

%% nNoResponse
sheetName = 'nNoResponses';

[~,~,rawD] = xlsread(fN,sheetName);
tmpD = cell2mat(rawD(2:end,2:end));
tmpH = rawD(1,2:end)'; %1 is partiicpant

tmpD(2,:) = []; %drop AL11 as we do in main analysis

tmp = sum(sum(tmpD))
fprintf('total n noResponse trials = %s\n', num2str( tmp * (100 / nTrials)) )



