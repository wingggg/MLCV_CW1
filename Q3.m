clearvars; %clears variables in workspace
Q2

%Q3 stuff
%to reconstruct face n : 
n=1; % face index
omega=A(:,n)'*u;  % omega matrix (weights) for face n
PCA=omega*u'; %Linear combination of eigenfaces according to weights omega
reconstructedFace=avgFace+PCA'; %we reconstruct the face n 
reconError=norm(trainingSet(n)-reconstructedFace);
figure;
showFace(reconstructedFace);

