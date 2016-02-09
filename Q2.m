%Script for Q2 
% 
load('face.mat')
validationPC=0.1; %percentage of data to be used as validation data

[Train, Test] = crossvalind('HoldOut', size(X,2), validationPC);
trainingSet=X(:,Train);
testSet=X(:,Test);

avgFace=mean(trainingSet,2);
phi=X-avgFace; %this line is wrong must fix the subtraction


