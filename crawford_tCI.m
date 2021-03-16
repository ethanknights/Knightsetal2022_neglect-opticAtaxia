%% Written by Fraser Smith
% Adapted to this project by Ethan Knights

function [t,df,p,CI]=crawford_tCI(patientScores,controlMean,controlSd,nC)

% control data needs to be a vector of control scores
% patient score is the patient's score :)
% computes crawford T, p and CI (95 + 99 %)

% uses standard error as Crawford defines it
% to derive the CI

%define control data data (N, mean and SD)
%nC=Ncontrols(1,1);  %% nControls
mC=controlMean;%mean
sC=controlSd;%STD

% FORMULA taken from Crawford & Garthwaite, 2002, Neuropsychologia
t=(patientScores-mC)/(sC*sqrt((nC+1)/nC));
df=nC-1; 


p(2)=2*(1-tcdf(abs(t),df));  %% two tailed
p(1)=p(2)/2;  %% one tailed
p(3)=p(1).*100;  %% point estimate of abnormality (see paper)


% derive CI - 
% the general formula from Howell (Stat Meth for Psych)

% X%CI = Xbar +- critT(alpha/2)*stderror
% test(1)=1.463+(2.262*(0.34/sqrt(10))); test from howell
% test(2)=1.463-(2.262*(0.34/sqrt(10)));

critT(1)=tinv(.025,df);  %% .025 here gives .05 total
critT(2)=tinv(.005,df);
critT=abs(critT);
 
sX=(sC*sqrt((nC+1)/nC));  %% standard error from t formula

% CI-1:2 is 95% CI
CI(1)=mC+critT(1).*sX;
CI(2)=mC-critT(1).*sX;

% CI-3:4 is 99% CI
CI(3)=mC+critT(2).*sX;
CI(4)=mC-critT(2).*sX;

