%Script for Q2
% 
load('face.mat')
validationPC=0.1; %percentage of data to be used as validation data
M=50; %the largest M eigenvalues will be picked. 

[Train, Test] = crossvalind('HoldOut', size(X,2), validationPC); %produce crossvalidation indices
trainingSet=X(:,Train); %create training and test sets according to indices
testSet=X(:,Test);
N=size(trainingSet,2);

avgFace=mean(trainingSet,2);  %Average face
A=trainingSet-repmat(avgFace,1,N); %matrix of phi values

S=(1/N)*A'*A; %As asked in Q2 of spec
[V,D]=eig(S);  %V are the RIGHT eigenvectors, D are the corresponding eigenvalues
eigenvalues=diag(D); %put eigenvalues in a single column vector

%BLOCK BELOW MIGHT BE WRONG 
% for index=1:M      % Kinda hacky way to find the indices of the top M eigenvalues
%     [eigenvalue,I]=max(eigenvalues);
%     maxInd(index)=I;     %maxInd are the indices of the top M eigenvalues
%     eigenvalues(I)=-inf; 
% end

bestEigenvectors=V(:,1:M);

bestEigenvectors=A*bestEigenvectors;

for i=1:M
    subplot(floor(M/2),M/floor(M/2),i);
    showFace(bestEigenvectors(:,i));
end


