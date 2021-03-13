%% ==== check trial distributions & initial examination of dataset (AL10) ==== %%

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
