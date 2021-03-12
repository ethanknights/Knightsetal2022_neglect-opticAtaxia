%load data.mat
%copy this:
%stats=runCrawford(patientScores,controlMean,controlSd,nC,1);

function stats=runCrawford(patientScores,controlMean,controlSd,nC,plotFig)

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
    figure,
    errorbar(1:nCond,mC,CI2(:,1),'Color',[0 0 0],'LineWidth',2)%makes square
    hold, plot(1:nCond,patientScores,'ro','MarkerSize',12,'LineWidth',2);%makes triangle
    xlabel('Target Position (° from midline)')
    ylabel('Constant X Error (mm)')
    axis([0 8 -35 35]);
    xticklabels({[],'-28','-17','-11','0','11','17','28'});
    end

% output
stats=[];
stats.t=t';
stats.df=df;
stats.p=p';
stats.CI=CI;