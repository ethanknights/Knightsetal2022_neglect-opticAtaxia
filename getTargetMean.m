function [targetStack,targetMean,targetStd] = getTargetMean(data,target,variable)

data2 = data(2:end,:); %Remove header first for simplicity with mat2cell

%create index for current target
tmpIndex = cell2mat(data(2:end,1));
idx = (find(tmpIndex == target)); 

%Read data
targetStack = cell2mat(data2(idx,variable));
targetMean = mean(targetStack);
targetStd = std(targetStack);

end

