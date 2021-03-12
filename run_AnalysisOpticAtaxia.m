%Analysis of Patient D.A. Motion Tracking Optic Ataxia Assessment
%Patient DA is first row, rest are control group

clear
%Parameters
conditionNames = {'RHFREE','RHPER','LHFREE','LHPER'};
sNames = {
  'DA',
  'AL10',
  'NH06',
  'CT07',
  'EH09',
  'AW07',
  'UB03',
  'BT07',
  'VH11',
  'RN07',
  'RS24',
  'SMS05'};
age = [67,
  62,
  62,
  64,
  69,
  63,
  66,
  71,
  64,
  66,
  59,
  75];
mean(age(2:end))
std(age(2:end))
min(age(2:end))
max(age(2:end))
[h,p,ci,stats] = ttest(age(2:end),age(1))


%Read data
rawData = [];
fN = fullfile('data','rawData.mat');
rfN = fullfile('data','FREEPER_Database.xlsx');
if ~exist(fN) %if first time
  for s = 1:size(sNames)
    for condition = 1:4
      tmpName = sprintf('%s_%s',sNames{s},conditionNames{condition});
      [~,~,rawData{s,condition}] = xlsread(rfN,tmpName);
    end
  end
  save(fN,'rawData');
else
  load(fN); %else load data
end
thisVarStr = 'ANGerr';
data = getData(thisVarStr,rawData,sNames);

%% Now check trialDistributions: 
checkTrials

%% Drop AL10 for lots of no responses on both sides of space (> D.A. ...)
%reset parameters and 'rawData' to avoid confusion later
conditionNames = {'RHFREE','RHPER','LHFREE','LHPER'};
sNames = {
  'DA',
  'NH06',
  'CT07',
  'EH09',
  'AW07',
  'UB03',
  'BT07',
  'VH11',
  'RN07',
  'RS24',
  'SMS05'}; %without AL10!!
age = [67,
  62,
  64,
  69,
  63,
  66,
  71,
  64,
  66,
  59,
  75]; %without AL10!!
mean(age(2:end))
std(age(2:end))
min(age(2:end))
max(age(2:end))
[h,p,ci,stats] = ttest(age(2:end),age(1)) %p reported in the paper reflects 
%the full control group age comparison earlier (but p still >.05; p = 0.476).

%% reRead data
rawData = [];
fN = fullfile('data','data.mat');
rfN = fullfile('data','FREEPER_Database.xlsx');
if ~exist(fN) %if first time
  for s = 1:size(sNames)
    for condition = 1:4
      tmpName = sprintf('%s_%s',sNames{s},conditionNames{condition});
      [~,~,rawData{s,condition}] = xlsread(rfN,tmpName);
    end
  end
  save(fN,'rawData');
else
  load(fN); %else load data
end
disp('done writing rawData to data.mat')


%% ==== ANALYSIS ==== %%

%% ---- ANGerr ---- %%
thisVarStr = 'ANGerr';
data = getData(thisVarStr,rawData,sNames);
stats = doCrawford(thisVarStr,data,conditionNames)




