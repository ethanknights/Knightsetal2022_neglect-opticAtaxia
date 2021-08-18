
%addpath('/imaging/ek03/toolbox/cbrewer')
close all

nSubs = 11; %D.A is sub 1, controls 2:11


%% Run main deficit tests
outDir = fullfile('results','rawPointingEndpointCoordinates');
try
  rmdir(outDir,'s');
catch
  %NOOP
end
mkdir(outDir)



%% read X/Y positions
[M1X,tmpH] = getData('M1X',rawData,sNames); %end
[sX,tmpH] = getData('sX',rawData,sNames);   %start

[M1Y,tmpH] = getData('M1Y',rawData,sNames);
[sY,tmpH] = getData('sY',rawData,sNames);

%% plot parameters
%cmap=cbrewer('seq', 'Reds', 7);
cmap = lbmap(7);
markerSizes = 900;
targetX = [-250,-150,-100,0,100,150,250];
targetY = [225,225,225,225,225,225,225];

%% Patient first
for conditions = 1:4
  
  currConditionName = conditionNames{conditions};
  
  h = figure('position',[100,100,1200,1200])
  %set(h,'WindowStyle','docked') % debugging
  
  subLoc = 1
  
  mx = [];
  sx =[];
  mx = {M1X.targetStack{subLoc,:,conditions}};
  sx = {sX.targetStack{subLoc,:,conditions}};
  
  my = [];
  sy =[];
  my = {M1Y.targetStack{subLoc,:,conditions}};
  sy = {sY.targetStack{subLoc,:,conditions}};
  
  tmpX = [];
  tmpY = [];
  for t = 1:7
    assert(length(mx{t}) == length(sx{t}))
    tmpX{t} = mx{t} - sx{t};
    
    assert(length(my{t}) == length(sy{t}))
    tmpY{t} = my{t} - sy{t};
  end
  
  %% plot DA's targets
  clf
  for t=1:7
    %%plot
    scatter(tmpX{t},tmpY{t},markerSizes,...
      'MarkerFaceColor',cmap(t,:), ...
      'MarkerEdgeColor',[0 0 0],...
      'MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,...
      'LineWidth',4)
    hold on
    %%plot target references
    scatter(targetX(t),targetY(t),1000,'black','x','LineWidth',10)
  end
  setPlotParameters
  
  %% save plot
  pause(0.5)
  outName = fullfile(outDir,['patient_',currConditionName]);
  cmdStr = sprintf('export_fig %s.png',outName) %-transparent not working
  eval(cmdStr);
  
end

close all

%% Repeat with control group
for conditions = 1:4
  
  currConditionName = conditionNames{conditions};
  
  h = figure('position',[100,100,1200,1200])
  %set(h,'WindowStyle','docked') % debugging
  tmpX = [];
  tmpY = [];
  
  for subLoc = 2:11
    
    mx = [];
    sx =[];
    mx = {M1X.targetStack{subLoc,:,conditions}};
    sx = {sX.targetStack{subLoc,:,conditions}};
    
    my = [];
    sy =[];
    my = {M1Y.targetStack{subLoc,:,conditions}};
    sy = {sY.targetStack{subLoc,:,conditions}};
    
    
    for t = 1:7
      assert(length(mx{t}) == length(sx{t}))
      tmpX(subLoc-1,t) = mean(mx{t} - sx{t}); %%!!take mean here for controls!!
      %variabilityX{subLoc-1,t} = std(mx{t} - sx{t}); %%!! also get controls variability!!
      
      assert(length(my{t}) == length(sy{t}))
      tmpY(subLoc-1,t) = mean(my{t} - sy{t}); %%!!take mean here for controls!!
      %variabilityY{subLoc-1,t} = std(my{t} - sy{t}); %%!! also get controls variability!!
    end
    
  end
  
  %% plot mean of each control (target size as a function of variability?)
  clf
  for t=1:7
    %%plot
    scatter(tmpX(:,t),tmpY(:,t),markerSizes,...
      'MarkerFaceColor',cmap(t,:), ...
      'MarkerEdgeColor',[0 0 0],...
      'MarkerFaceAlpha',0.75,'MarkerEdgeAlpha',0.75,...
      'LineWidth',4)
    hold on
    %%plot target references
    scatter(targetX(t),targetY(t),1000,'black','x','LineWidth',10)
  end
  setPlotParameters

  %% save plot
  pause(0.5)
  outName = fullfile(outDir,['controlGroupMeans_',currConditionName]);
  cmdStr = sprintf('export_fig %s.png',outName) %-transparent not working
  eval(cmdStr);
  
end

