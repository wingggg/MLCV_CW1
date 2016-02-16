Q2

%Q3 stuff
%to reconstruct face n : 
n=1;
alphas=A(:,n)'*u;
PCA=alphas*u';
reconstructedFace=avgFace+PCA';
figure;
showFace(reconstructedFace);

