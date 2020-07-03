clear all; close all; clc


F1 = importdata('../MaxFreq1.csv');
F2 = importdata('../MaxFreq2.csv');
        
in = 1; out = 1; nRem =20;      
load(['../P',num2str(in),'.mat'],'P1');
        
a = 0.3; b = 1.5; c = 2.1;
Nxy = 200;
ac = zeros(Nxy,Nxy); M = [];
for i = 1:200
    i
    for j = 1:200
        Pn = [0 -c + i/(Nxy/2)*c, -c + j/(Nxy/2)*c]';
       
        dd = sqrt( (P1(:,1)-Pn(1)).^2 + (P1(:,2)-Pn(2)).^2 + (P1(:,3)-Pn(3)).^2);
        n1 = find(dd < 0.05);
        n = 1 + poissrnd(length(n1)*10); if (n>140); n=140; end
        x = -c + i/(Nxy/2)*c; 
        y = -c + j/(Nxy/2)*c;
        if (x^2/b^2 + y^2/c^2 < 1)
            ac1(i,j) = F1(round(n/2));
            ac2(i,j) = F2(round(n/2));
        else
             ac1(i,j) = -40;
             ac2(i,j) = -40;
        end

    end
end
figure; imagesc(ac1); colormap jet;  colorbar; caxis([-40 max(F1)]); goodplot;
figure; imagesc(ac2); colormap jet;  colorbar; caxis([-40 max(F2)]); goodplot;
