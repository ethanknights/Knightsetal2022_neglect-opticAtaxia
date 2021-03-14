
%Adapt the plots from runCrawford.m, to plot the DIFFERENCE between
%conditions

function plotBDST(taskX,taskY,nC)

mC = taskX.controlMean - taskY.controlMean;
mC = mC';
sC = taskX.controlStd	 - taskY.controlStd;
sC = sC';
patientScores = taskX.patientScores - taskY.patientScores;
patientScores = patientScores';

allControls = taskX.allControls - taskY.allControls;
%allControls = allControls;


nCond=length(mC);%each column is a variable
[c,d]=size(patientScores);%each column is a variable

% check nCond matches for patient + control Data
if(d~=nCond)
  error('MisMatch N Conditions');
end

%Giving up. can't use the difference to give accurate controlserrorbars
%  to estimate
% t=zeros(nCond,1);
% df=zeros(nCond,1);
% p=zeros(nCond,3);  %% has each condition on diff row
% CI=zeros(nCond,4); %% each condition on diff. row, 1st 2 num 95%, 2nd two 99% CI
% 
% % run crawford independently for each condition of data
% for i=1:nCond
%   [~,~,~,CI(i,:)]=crawford_tCI(patientScores(i),mC(i),sC(i),nC); %% USE BDST.exe FOR INFERENCE
% end
% 
% % and plot the results with a nice error bar plot
% 
% CI2=abs(CI-repmat(mC',1,4));
% 
% close all
% figure('position',[100,100,1200,1200])
% 
% 
% %Crawford cuttoff errorbar
% errorbar(1:nCond,mC,CI2(:,1),'Color',[0 0 0],'LineWidth',4,'LineStyle','none')
% hold on
% line(1:nCond,mC,'Color',[0 0 0],'LineWidth',4,'LineStyle','--')
% 
% %all control lines
% for controlN = 1:length(allControls)
%   hold on
%   line(1:nCond,allControls(controlN,:),'Color',[0.75 0.75 0.75],'LineWidth',1,'LineStyle','--')
% end
% 
% %Patient circle markers
% hold on
% plot(1:nCond,patientScores,'o','MarkerSize',18,'LineWidth',4, ...
%   'Color',[1 0 1])
% 
% 
% % output
% stats=[];
% stats.t=t';
% stats.df=df;
% stats.p=p';
% stats.CI=CI;

%Error bars still wrong if doing manually
% close all
% figure('position',[100,100,1200,1200])
%
%
% for t = 1:nCond
%   tmp_patientScores = patientScores(t)
%   tmp_mC = mC(t)
%   tmp_sC = sC(t)
%   tmp_allControls = allControls(:,t)
%   
%   tmp_stderror(t) = std( tmp_allControls ) / sqrt( length( tmp_allControls ))
%   tmp_stderror_POS(t) = tmp_mC + tmp_stderror(t)
%   tmp_stderror_NEG(t) = tmp_mC - tmp_stderror(t)
% end
% 
% % errorbar(1:nCond,mC,tmp_stderror_NEG,tmp_stderror_POS, ...
% %   'Color',[0 0 0],'LineWidth',4,'LineStyle','none')
%
% 
% %all control lines
% for controlN = 1:length(allControls)
%   hold on
%   line(1:nCond,allControls(controlN,:),'Color',[0.75 0.75 0.75],'LineWidth',1,'LineStyle','--')
% end
% 
% %Patient circle markers
% hold on
% plot(1:nCond,patientScores,'o','MarkerSize',18,'LineWidth',4, ...
%   'Color',[1 0 1])


% Just plot all control dots and D.A dots
close all
figure('position',[100,100,1200,1200])


%all control lines
for controlN = 1:length(allControls)
  plot(1:nCond,allControls(controlN,:), ...
    '-o','Color',[0.75 0.75 0.75], ...
    'LineWidth',2,'LineStyle','--', ...
    'MarkerSize',18,'MarkerFaceColor',[0.75 0.75 0.75],'MarkerEdgeColor',[0.5 0.5 0.5])
    hold on
end


%Patient circle markers
plot(1:nCond,patientScores, ...
  '-o','Color',[1 0 1], ...
  'LineWidth',2,'LineStyle','--', ...
  'MarkerSize',18,'MarkerFaceColor',[1 0 1],'MarkerEdgeColor',[0.9 0 0.9])
  
end


