clear all; close all; clc
in = 2; out = 1; nRem = 40;

load(['../P',num2str(in),'.mat'],'P1');
load(['../Remove_Random/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remove_Random/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');

ND = find(DK);
figure
h = histogram(UK(ND)); hold on
ylim([0.1 10000])
set(gca,'YScale','log')
h.BinEdges = [0:1:40];
h.FaceColor = [0.0 0.0 0.7];
h.EdgeColor = [0.1 0.1 0.5];
h.LineWidth = 4;
goodplot

load(['../Remove_Spread/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remove_Spread/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');

ND = find(DK);
h = histogram(UK(ND));
ylim([0.1 10000])
set(gca,'YScale','log')
h.BinEdges = [0:1:40];
h.FaceColor = [0.0 0.7 0.0];
h.EdgeColor = [0.1 0.5 0.1];
h.LineWidth = 4;
goodplot


load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');

ND = find(DK);
h = histogram(UK(ND));
ylim([0.1 10000])
set(gca,'YScale','log')
h.BinEdges = [0:1:40];
h.FaceColor = [0.7 0.0 0.0];
h.EdgeColor = [0.5 0.1 0.1];
h.LineWidth = 4;
goodplot
