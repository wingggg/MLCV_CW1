%script for Q4 

clearvars;

load('face.mat') %load given data
tic
validationPC=0.1; %percentage of data to be used as validation data
M=300; %the largest M eigenvalues will be picked. 

[Train, Test] = crossvalind('HoldOut', size(X,2), validationPC); %produce crossvalidation indices for training and test sets
trainingSet=X(:,Train); %create training set from X according to indices
testSet=X(:,Test); % same for test set

trainingLabels=l(:,Train); %labels vector for training set. 1 to 1 equivalence
testLabels=l(:,Test);

N=size(trainingSet,2);  %N is the number of the images of the training set.

avgFace=mean(trainingSet,2);  %Average face. Just average out all images in the training set
A=trainingSet-repmat(avgFace,1,N); %matrix of phi values. phi(n)=face n - avgFace

S=(1/N)*A'*A; %As asked in Q2 of spec. S is now a NxN matrix
[V,D]=eig(S);  %V are the eigenvectors, D are the corresponding eigenvalues (in a diagonal matrix)
eigenvalues=diag(D); %put eigenvalues in a single column vector

U=A*V; %to extract same eigenvectors as in Q1
U=normc(U);
u=U(:,1:M); %top M eigenvectors


predictedLabels=[];
nnImages=[];
confusionMatrix=zeros(size(testSet,2)); %initialise confusion matrix of size #testLabels x #testLabels
for j=1:size(testSet,2)    %for each test image
    testImage=testSet(:,j);  
    phi=testImage-avgFace;  
    omegaTest=phi'*u;   %find its omegas

    norms=zeros(size(trainingSet,2),2);  %initialise matrix of norms of size #trainingImages x 2
    for i=1:size(trainingSet,2) % for each training image
        norms(i,1)=norm(omegaTest-(A(:,i)'*u));  %calculate the L2 norm between omega and omegas of all training images
        norms(i,2)=trainingLabels(i);  %attach the corresponding training data labels next to all these L2 norms
    end
    [~,I]=min(norms(:,1)); %find index of minimum norm
    NN=trainingLabels(I); %that minimum norm is the nearest neighbour
    nnImages=[nnImages trainingSet(:,I)]; %store the NN image for this test image
    predictedLabels=[predictedLabels NN]; %store predicted label
    

end
successes=(predictedLabels==testLabels);
percentageAccuracy=sum(successes)/size(testLabels,2);
CM=confusionmat(testLabels,predictedLabels);


%WRITE RESULTS

toc
fileID = fopen('CW1_Q4Results.txt','a');
fprintf(fileID,'Using NN classification\n');
fprintf(fileID,'Test set is %d%% of train data\n',validationPC*100);
fprintf(fileID,'M: %d \n',M);
fprintf(fileID,'Accuracy: %f%% \n',percentageAccuracy*100);

fmt=[repmat('%d ',1,52) '\n'];
fprintf(fileID,'Confusion Matrix:\n');
fprintf(fileID,fmt,CM');
fprintf(fileID,'\n');
fprintf(fileID,'Time duration: %f seconds\n',toc);
fprintf(fileID,'===============================================\n');
fclose(fileID);
 

figure;

title('Success Case');
for i=1:length(testLabels)
    if successes(i)==1
        subplot(1,2,1);
        showFace(testSet(:,i));
        xlabel(['Class ',num2str(testLabels(i))]);
        subplot(1,2,2);
        showFace(nnImages(:,i));
        xlabel(['Class  ',num2str(predictedLabels(i))]);
        break;
    end
end
successFig=gcf;
figure;
title('Failure Case')
for i=1:length(testLabels)
    if successes(i)==0
        subplot(1,2,1);
        showFace(testSet(:,i));
        xlabel(['Class ',num2str(testLabels(i))]);
        subplot(1,2,2);
        showFace(nnImages(:,i));
        xlabel(['Class  ',num2str(predictedLabels(i))]);
        break;
    end
end
failFig=gcf;

%SAVE FIGURES
saveas(successFig,'succFig.png');
saveas(failFig,'failFig.png');



