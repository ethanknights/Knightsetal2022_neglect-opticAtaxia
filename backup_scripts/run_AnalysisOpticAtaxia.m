%Analysis of Patient D.A. Motion Tracking Optic Ataxia Assessment
%Patient DA is first row, rest are control group

clear
clf
close all
%Parameters
conditionNames = {'RHFREE','RHPER','LHFREE','LHPER';'Right Hand Free Vision','Right Hand Peripheral Vision','Left Hand Free Vision','Left Hand Peripheral Vision'};
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

%Read data
if exist('rawData_opticAtaxia.mat') == 0 %if first time
    for s = 1:size(sNames)
        for condition = 1:4
        tmpName = sprintf('%s_%s',sNames{s},conditionNames{condition});
        [~,~,rawData{s,condition}] = xlsread('FREEPER_Database.xlsx',tmpName);
        end
    end
    save('rawData_opticAtaxia','rawData');
else 
    load('rawData_opticAtaxia.mat'); %else load data
end

%Get data for seven targets per condition
variable = 30; %X Error
for s = 1:size(sNames)
    for condition = 1:4
        tmpData = rawData{s,condition};
            for target = 1:7
                [targetStack{s,target,condition},targetMean(s,target,condition),targetStd(s,target,condition)] = getTargetMean(tmpData,target,variable);
        end
    end
end
%Store data in structure
data.targetStackXErr = targetStack;
data.targetMeanXErr = targetMean;
data.targetStd = targetStd;

disp('done storing raw data')

%Crawford on the seven targets per condition 
%create function tomorrow
controlMean = mean(data.targetMeanXErr(2:end,:,1));
controlStd = std(data.targetMeanXErr(2:end,:,1));
patientScores = data.targetMeanXErr(1,:,1);
nC = size(patientScores,2);
stats{1}=runCrawford(patientScores,controlMean,controlStd,nC,1);
title(conditionNames{2,1}); %Right Hand Free Vision

controlMean = mean(data.targetMeanXErr(2:end,:,2));
controlStd = std(data.targetMeanXErr(2:end,:,2));
patientScores = data.targetMeanXErr(1,:,2);
nC = size(patientScores,2);
stats{2}=runCrawford(patientScores,controlMean,controlStd,nC,2);
title(conditionNames{2,2}); %Right Hand Peripheral Vision

controlMean = mean(data.targetMeanXErr(2:end,:,3));
controlStd = std(data.targetMeanXErr(2:end,:,3));
patientScores = data.targetMeanXErr(1,:,3);
nC = size(patientScores,2);
stats{3}=runCrawford(patientScores,controlMean,controlStd,nC,3);
title(conditionNames{2,3}); %Left Hand Free Vision

controlMean = mean(data.targetMeanXErr(2:end,:,4));
controlStd = std(data.targetMeanXErr(2:end,:,4));
patientScores = data.targetMeanXErr(1,:,4);
nC = size(patientScores,2);
stats{4}=runCrawford(patientScores,controlMean,controlStd,nC,4);
title(conditionNames{2,4}); %Left Hand Peripheral Vision

disp('p values for RH Free:');
disp(stats{1}.p(1,:))

disp('p values for RH Per:');
disp(stats{2}.p(1,:))

disp('p values for LH Free:');
disp(stats{3}.p(1,:))

disp('p values for LH Per:');
disp(stats{4}.p(1,:))