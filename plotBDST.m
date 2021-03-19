
%Plot the DIFFERENCE between conditions
%
%important - setup so that taskY - taskX.
%Thus if taskX is the 'good' condition (RH, Free vision)
%And taskY is 'bad' (LH, Per vision)
%Then taskY - taskX = how bad is the 'impairment'
%i.e. higher positive score shows greater impairment
%e.g. for Per - Free, higher positive score = greater peripheral impairment

function plotBDST(taskX,taskY,nC)

mC = taskY.controlMean - taskX.controlMean;
mC = mC';
sC = taskY.controlStd	 - taskX.controlStd;
sC = sC';
patientScores = taskY.patientScores - taskX.patientScores;
patientScores = patientScores';

allControls = taskY.allControls - taskX.allControls;
%allControls = allControls;


nCond=length(mC);%each column is a variable
[c,d]=size(patientScores);%each column is a variable

% check nCond matches for patient + control Data
if(d~=nCond)
  error('MisMatch N Conditions');
end


% Just plot all control dots and D.A dots
close all
figure('position',[100,100,1200,1200])


%all control lines
for controlN = 1:length(allControls)
  plot(1:nCond,allControls(controlN,:), ...
    '-o','Color',[0    0.8314    0.9608], ...
    'LineWidth',2,'LineStyle','--', ...
    'MarkerSize',18,'MarkerFaceColor',[0    0.8314    0.9608],'MarkerEdgeColor',[0.0745    0.6235    1.0000])
    hold on
end


%Patient circle markers
plot(1:nCond,patientScores, ...
  '-o','Color',[1 0 1], ...
  'LineWidth',2,'LineStyle','--', ...
  'MarkerSize',18,'MarkerFaceColor',[0.9 0 0.9],'MarkerEdgeColor',[0 0 0])
  
end


