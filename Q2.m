%Script for Q2
% 
load('face.mat') %load given data
validationPC=0.1; %percentage of data to be used as validation data
M=100; %the largest M eigenvalues will be picked. 

[Train, Test] = crossvalind('HoldOut', size(X,2), validationPC); %produce crossvalidation indices for training and test sets
trainingSet=X(:,Train); %create training set from X according to indices
testSet=X(:,Test); % same for test set
N=size(trainingSet,2);  %N is the number of the images of the training set.

avgFace=mean(trainingSet,2);  %Average face. Just average out all images in the training set
A=trainingSet-repmat(avgFace,1,N); %matrix of phi values. phi(n)=face n - avgFace

S=(1/N)*A'*A; %As asked in Q2 of spec. S is now a NxN matrix
[V,D]=eig(S);  %V are the eigenvectors, D are the corresponding eigenvalues (in a diagonal matrix)
eigenvalues=diag(D); %put eigenvalues in a single column vector

%
% for index=1:M      % Kinda hacky way to find the indices of the top M eigenvalues
%     [eigenvalue,I]=max(eigenvalues);
%     maxInd(index)=I;     %maxInd are the indices of the top M eigenvalues
%     eigenvalues(I)=-inf; 
% end

U=A*V; %to extract same eigenvectors as in Q1
U=normc(U);
u=U(:,1:M); %top M eigenvectors

for i=1:M
    subplot(floor(M/2),M/floor(M/2),i);
    showFace(u(:,i));
end


