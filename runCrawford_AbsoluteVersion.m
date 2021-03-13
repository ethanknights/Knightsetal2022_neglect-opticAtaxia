%load data.mat
%copy this:
%stats=runCrawford(patientScores,controlMean,controlSd,nC,1);

function stats=runCrawford_AbsoluteVersion(patientScores,controlMean,controlSd,nC, ...
  plotFig,allControls)

% structure of input
mC=controlMean;%mean
sC=controlSd;%STD

nCond=length(controlMean);%each column is a variable
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
  [t(i),df(i),p(i,:),CI(i,:)]=crawford_tCI(patientScores(i),mC(i),sC(i),nC);
end

% and plot the results with a nice error bar plot
if(plotFig)
  
  CI2=abs(CI-repmat(mC',1,4));
  
  close all
  figure('position',[100,100,1200,1200])
  
  
  %Crawford cuttoff errorbar
  %CHANGES HERE - Cap Error bar neg value at 0 if its negative value
  %ERRORBAR(X,Y,NEG,POS)
  
  for i = 1:nCond
  
    NEG = mC(i) - CI2(i,1);
    POS = mC(i) + CI2(i,1);
    
    if NEG < 0
      NEG0 = 0 - mC(i);
      errorbar(i,mC(i),NEG0,POS,'Color',[0 0 0],'LineWidth',4,'LineStyle','none')
      hold on
    else
      errorbar(i,mC(i),NEG ,POS,'Color',[0 0 0],'LineWidth',4,'LineStyle','none')
      hold on
    end
    
  end
    
 
%     
%   errorbar(1:nCond,mC,CI2(:,1),'Color',[0 0 0],'LineWidth',4,'LineStyle','none')
%   hold on
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