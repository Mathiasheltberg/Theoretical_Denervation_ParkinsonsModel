clear all; close all; clc
in = 2; out = 1; nRem = 10;

load(['../../P',num2str(in),'.mat'],'P1');
load(['../Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
load(['../Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
load(['../Remaining_',num2str(nRem),'/Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');

ND = find(DK);
figure
h = histogram(UK(ND));
ylim([0.1 10000])
set(gca,'YScale','log')
h.BinEdges = [0:1:40];
h.FaceColor = [0.0 0.0 0.7];
h.EdgeColor = [0.1 0.1 0.5];
h.LineWidth = 4;
goodplot
figure
plot(Tim,10000 + linspace(length(Tim)-1,0,length(Tim)),'LineWidth',3); goodplot

figure
semilogy(Tim,10000 + linspace(length(Tim)-1,0,length(Tim)),'LineWidth',3); goodplot

figure
loglog(Tim,10000 + linspace(length(Tim)-1,0,length(Tim)),'LineWidth',3); goodplot

