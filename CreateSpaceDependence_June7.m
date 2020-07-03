clear all; close all; clc


F1 = importdata('../MaxFreq1.csv');
F2 = importdata('../MaxFreq2.csv');
        
in = 1; out = 1; nRem =20;      
load(['../P',num2str(in),'.mat'],'P1');
load(['../Stress/Remaining_',num2str(nRem),'_DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
        
  ND = find(DK);
a = 0.3; b = 1.5; c = 2.1;
P1 = P1(ND,:);
Nxy = 100;
ac = zeros(Nxy,Nxy); M = [];
for i = 1:100
    i
    for j = 1:100
        Pn = [-a + i/(Nxy/2)*a, -b + j/(Nxy/2)*b, 0]';
       
        dd = sqrt( (P1(:,1)-Pn(1)).^2 + (P1(:,2)-Pn(2)).^2 + (P1(:,3)-Pn(3)).^2);
        n1 = find(dd < 0.05);
        n = 1 + poissrnd(length(n1)*10); if (n>140); n=140; end
        x = -a + i/(Nxy/2)*a; 
        y = -b + j/(Nxy/2)*b;
        if (x^2/a^2 + y^2/b^2 < 1)
            ac1(i,j) = F1(round(n/2));
            ac2(i,j) = F2(round(n/2));
        else
             ac1(i,j) = -50;
             ac2(i,j) = -50;
        end

    end
end
figure; imagesc(ac1); colormap hot;  colorbar; caxis([-50 300]); goodplot;
figure; imagesc(ac2); colormap jet;  colorbar; caxis([-50 300]); goodplot;
