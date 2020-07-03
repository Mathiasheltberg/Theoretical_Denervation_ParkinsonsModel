clear all; close all; clc

load('../Msd2.mat')
Nue = [1 3 6 10 13 16 20 25 30 35 40 50 60 70 80 90];

Nue = flip(Nue);
Nue = 100-Nue;
y1 = flip(smooth(Msd2(:,1,1)))./flip(smooth(Msd2(:,4,1)));
y2 = flip(smooth(Msd2(:,1,2)))./flip(smooth(Msd2(:,4,1)));
y3 = flip(smooth(Msd2(:,1,3)))./flip(smooth(Msd2(:,4,1)));
y4 = flip(smooth(Msd2(:,1,4)))./flip(smooth(Msd2(:,4,1)));
figure
plot(Nue',y1,'-*','color',[0.7 0.1 0.1],'LineWidth',3); hold on;
plot(Nue',y2,'-*','color',[0.7 0.7 0.1],'LineWidth',3);
plot(Nue',y3,'-*','color',[0.1 0.7 0.1],'LineWidth',3); goodplot;
plot(Nue',y4,'-*','color',[0.1 0.1 0.7],'LineWidth',3); goodplot;
plot(Nue',smooth(Msd2(:,4,4))./smooth(Msd2(:,4,4)),'--k','LineWidth',3); goodplot;

Nue(6)
xx = [Msd2(9,1,:); Msd2(9,2,:); Msd2(9,3,:)];
xx = squeeze(xx);
xx = xx/Msd2(end,4,1);
figure; b = bar(xx,'LineWidth',3); goodplot
b(1).FaceColor = [0.7 0.1 0.1];
b(2).FaceColor = [0.7 0.7 0.1];
b(3).FaceColor = [0.1 0.7 0.1];
b(4).FaceColor = [0.1 0.1 0.7];