%script for Q4 alternate method


clearvars;

load('face.mat') %load given data
tic
validationPC=0.3; %percentage of data to be used as validation data
M=4; %the largest M eigenvalues will be picked. 

classEigenVectors=cell(52,1); %initialise the cell array that will hold the classes
classAvgFaces=zeros(52,1);
classTestSets=cell(52,1);
ii=1;
for i=1:10:520
    data=X(:,i:i+9);
    dataLabels=l(:,i:i+9);
    [Train, Test] = crossvalind('HoldOut', size(data,2), validationPC); %produce crossvalidation indices for training and test sets
    trainingSet=data(:,Train); %create training set from X according to indices
    testSet=data(:,Test); % same for test set

    trainingLabels=dataLabels(:,Train); %labels vector for training set. 1 to 1 equivalence
    testLabels=dataLabels(:,Test);

    N=size(trainingSet,2);  %N is the number of the images of the training set.

    avgFace=mean(trainingSet,2);  %Average face. Just average out all images in the training set
    
    A=trainingSet-repmat(avgFace,1,N); %matrix of phi values. phi(n)=face n - avgFace

    S=(1/N)*A'*A; %As asked in Q2 of spec. S is now a NxN matrix
    [V,D]=eig(S);  %V are the eigenvectors, D are the corresponding eigenvalues (in a diagonal matrix)
    eigenvalues=diag(D); %put eigenvalues in a single column vector

    U=A*V; %to extract same eigenvectors as in Q1
    U=normc(U);
    u=U(:,1:M); %top M eigenvectors
    
    classEigenVectors{ii}=u; %put those M top eigencvectors in this class's cell
    classTestSets{ii}=[testSet' testLabels'];
    classAvgFaces[ii]=avgFace;
    ii=ii+1;
end




