
thisVarStr = {'M1X','M1Y'};

%% read in end X/y positions
[dataX,tmpH] = getData(thisVarStr{1},rawData,sNames);
[dataY,tmpH] = getData(thisVarStr{1},rawData,sNames);

%% Home positions (to minus for every sub: RH then LH)
home = [-9.3,	124.6, -10.7, 123.7; ... %DA: RH-X RH-Y LH-X LH-Y
];


for conditions = 1:4
  
  currConditionName = conditionNames{conditions};
  
  
  %% patient DA
  subjectLoc = 1;
  
  raw_Xcoords = [];
  raw_Ycoords = [];
  raw_Xcoords = dataX.targetStack(subjectLoc,:,conditions);
  raw_Ycoords = dataX.targetStack(subjectLoc,:,conditions);
      
  if      conditions == 1 || conditions == 2 %RH
    for t = 1:7
      
      Xcoords(:,t) = home(subjectLoc,1) - raw_Xcoords{t};
      
    end

    
  elseif  conditions == 3 || conditions == 4 %LH
    
  end
  
  
end
