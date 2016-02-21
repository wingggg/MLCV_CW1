function [ J ] = doQ3( ) %M as argument
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

load('face.mat') %load given data
validationPC=0.1; %percentage of data to be used as validation data
%M=468; %the largest M eigenvalues will be picked. 

[Train, Test] = crossvalind('HoldOut', size(X,2), validationPC); %produce crossvalidation indices for training and test sets
trainingSet=X(:,Train); %create training set from X according to indices
testSet=X(:,Test); % same for test set
N=size(trainingSet,2);  %N is the number of the images of the training set.

avgFace=mean(trainingSet,2);  %Average face. Just average out all images in the training set
A=trainingSet-repmat(avgFace,1,N); %matrix of phi values. phi(n)=face n - avgFace

S=(1/N)*A'*A; %As asked in Q2 of spec. S is now a NxN matrix
[V,D]=eig(S);  %V are the eigenvectors, D are the corresponding eigenvalues (in a diagonal matrix)
eigenvalues=diag(D); %put eigenvalues in a single column vector



U=A*V; %to extract same eigenvectors as in Q1
U=normc(U);
% u=U(:,1:M); %top M eigenvectors

% for i=1:M
%     subplot(floor(M/2),M/floor(M/2),i);
%     showFace(u(:,i));
% end

%Q3 stuff
%to reconstruct face n : 
n=20; % face index

% for n=1:N
%     omega=trainingSet(:,n)'*u;  % omega matrix (weights) for face n
%     PCA=omega*u'; %Linear combination of eigenfaces according to weights omega
%     reconstructedFace=avgFace+PCA'; %we reconstruct the face n      
% end

% J=sum(eigenvalues(M+1:end)); % J reconstr error as in lectures, not sure if right 
% figure;
% showFace(reconstructedFace);


%%%%%%%%%% DIFFERENT VALUES OF M'S
Ms=[10,50,100,400];
i=1;
for M=Ms(1:4)
    u=U(:,1:M); %top M eigenvectors
    omega=trainingSet(:,n)'*u;  % omega matrix (weights) for face n
    PCA=omega*u'; %Linear combination of eigenfaces according to weights omega
    reconstructedFace=avgFace+PCA'; %we reconstruct the face n
%     figure;
    subplot(1,4,i);
    showFace(reconstructedFace);
    i=i+1;
end
%%%%%%%%%%


end

