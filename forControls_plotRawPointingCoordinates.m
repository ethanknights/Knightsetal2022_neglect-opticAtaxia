%% modified version of plotRawPointingCoordinates.m
%% Plot endpoints for every control individually (rather than collapse each sub for 1 mean dot)

%addpath('/imaging/ek03/toolbox/cbrewer')
close all

nSubs = 11; %D.A is sub 1, controls 2:11

%% Run main deficit tests
outDir = fullfile('results','forControls_rawPointingEndpointCoordinates');
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
cmap = lbmap(7,'RedBlue');
markerSizes = 900;
targetX = [-250,-150,-100,0,100,150,250];
targetY = [225,225,225,225,225,225,225];

for s = 2:11
  
  for conditions = 1:4
    
    currConditionName = conditionNames{conditions};
    
    h = figure('position',[100,100,1200,1200])
    %set(h,'WindowStyle','docked') % debugging
    
    subLoc = s;
    
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
    
    %% plot subjects targets
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
      scatter(targetX(t),targetY(t),1000,'black','o')
    end
    setPlotParameters
    
    %% save plot
    outName = fullfile(outDir,['control_',sNames{s},'_',currConditionName]);
    cmdStr = sprintf('export_fig %s.png',outName) %-transparent not working
    eval(cmdStr);
    
  end
end
close all