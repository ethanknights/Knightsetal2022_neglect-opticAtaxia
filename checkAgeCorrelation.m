%% is there an age correlation with our key angular error measure?
%% (e.g. should we covary age; Hassan et al. 2021; Crawford et al. 2011)
coef = [];
pval = [];
for c = 1:4
  
  err = mean(data.targetMean(2:end,1:7,c),2); %mean of all targets per sub (for each c)
  [coef(c), pval(c)] = corr(err,age(2:nSubs));
end
coef
pval
plotRegression(err,age(2:end))


%% Results from angular error were:
% conditionNames =
% 
%   1×4 cell array
% 
%     {'RHFREE'}    {'RHPER'}    {'LHFREE'}    {'LHPER'}
%     
% coef =
% 
%     0.1321   -0.6502   -0.1898   -0.2703
% 
% 
% pval =
% 
%     0.7161    0.0418    0.5994    0.4500