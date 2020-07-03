clear all; close all; clc

in = 1; out = 1; nRem = 20;

load(['../P',num2str(in),'.mat'],'P1');
load(['../Remove_Spread/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remove_Spread/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
ND = find(DK);
a = 0.3; b = 1.5; c = 2.1;
P1 = P1(ND,:);

ac = zeros(100,100); M = [];
for i = 1:100
    i
    for j = 1:100
        Pn = [-a + i/50*a, -b + j/50*b, 0]';
       
        dd = sqrt( (P1(:,1)-Pn(1)).^2 + (P1(:,2)-Pn(2)).^2 + (P1(:,3)-Pn(3)).^2);
        n1 = find(dd < 0.05);
        ac(i,j) = length(n1);
        if (length(n1) > 0)
            M = [M;  length(n1)];
        end
    end
end
mean(M)
figure; imagesc(ac); colormap = 'hot'; colorbar; caxis([0 25]); goodplot;
