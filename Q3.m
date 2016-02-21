clearvars; %clears variables in workspace


Ms=[10:5:468];
Js=[];
for M=Ms
    Js=[Js;doQ3(M)];
end
figure;
plot(Ms,Js);
title('Reconstruction error against M');
xlabel('M');
ylabel('J');