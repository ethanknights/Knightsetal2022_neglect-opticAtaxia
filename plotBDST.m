
%Adapt the plots from runCrawford.m, to plot the DIFFERENCE between
%conditions

function plotBDST(taskX,taskY,nC)

mC = taskY.controlMean - taskX.controlMean;
mC = mC';
sC = taskY.controlStd	 - taskX.controlStd;
sC = sC';
patientScores = taskY.patientScores - taskX.patientScores;
patientScores = patientScores';

allControls = taskX.allControls - taskY.allControls;
allControls = allControls';


nCond=length(mC);%each column is a variable
[c,d]=size(patientScores);%each column is a variable

% check nCond matches for patient + control Data
if(d~=nCond) 
    error('MisMatch N Conditions');
end

%  to estimate
t=zeros(nCond,1);
df=zeros(nCond,1);
p=zeros(nCond,3);  %% has each condition on diff row
CI=zeros(nCond,4); %% each condition on diff. row, 1st 2 num 95%, 2nd two 99% CI

% run crawford independently for each condition of data
for i=1:nCond  
    [~,~,~,CI(i,:)]=crawford_tCI(patientScores(i),mC(i),sC(i),nC); %% USE BDST.exe FOR INFERENCE
end

% and plot the results with a nice error bar plot
if(plotFig)
     
    CI2=abs(CI-repmat(mC',1,4));
    
    close all
    figure('position',[100,100,1200,1200])

   
    %Crawford cuttoff errorbar
    errorbar(1:nCond,mC,CI2(:,1),'Color',[0 0 0],'LineWidth',4,'LineStyle','none')
    hold on
    line(1:nCond,mC,'Color',[0 0 0],'LineWidth',4,'LineStyle','--')
    
    %all control lines
    for controlN = 1:length(allControls)
      hold on
      line(1:nCond,allControls(controlN,:),'Color',[0.75 0.75 0.75],'LineWidth',1,'LineStyle','--')
    end
    
    %Patient circle markers
    hold on
    plot(1:nCond,patientScores,'o','MarkerSize',18,'LineWidth',4, ...
      'Color',[1 0 1])
    
end

% output
stats=[];
stats.t=t';
stats.df=df;
stats.p=p';
stats.CI=CI;