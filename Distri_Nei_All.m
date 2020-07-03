clear all; close all; clc
in = 2; out = 1; nRem = 6;


UK1 = load(['../../Remove_Random/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
UK1 = UK1.UK;
DK1 = load(['../../Remove_Random/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
DK1 = DK1.DK;
ND1 = find(DK1);

h = histogram(UK1(ND1)); hold on
ylim([0.1 10000])
set(gca,'YScale','log')
h.BinEdges = [0:1:40];
h.FaceColor = [0.0 0.0 0.7];
h.EdgeColor = [0.1 0.1 0.5];
h.LineWidth = 4;
h.FaceAlpha = 0.4;
goodplot

UK1 = load(['../../Remove_Spread/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
UK1 = UK1.UK;
DK1 = load(['../../Remove_Spread/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
DK1 = DK1.DK;
ND1 = find(DK1);

h = histogram(UK1(ND1)); hold on
ylim([0.1 10000])
set(gca,'YScale','log')
h.BinEdges = [0:1:40];
h.FaceColor = [0.0 0.7 0.0];
h.EdgeColor = [0.1 0.5 0.1];
h.LineWidth = 4;
h.FaceAlpha = 0.3;
goodplot

UK1 = load(['../Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
UK1 = UK1.UK;
DK1 = load(['../Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
DK1 = DK1.DK;
ND1 = find(DK1);

h = histogram(UK1(ND1)); hold on
ylim([0.1 10000])
set(gca,'YScale','log')
h.BinEdges = [0:1:40];
h.FaceColor = [0.7 0.0 0.0];
h.EdgeColor = [0.5 0.1 0.1];
h.LineWidth = 4;
h.FaceAlpha = 0.2;
goodplot



Tim1 = load(['../Remaining_',num2str(nRem),'/Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
Tim1 = Tim1.Tim;
Tim2 = load(['../../Remove_Spread/Remaining_',num2str(nRem),'/Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
Tim2 = Tim2.Tim;
Tim3 = load(['../../Remove_Random/Remaining_',num2str(nRem),'/Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
Tim3 = Tim3.Tim;
figure
plot(Tim3/max(Tim3),linspace(length(Tim3)-1,0,length(Tim3)),'LineWidth',3); goodplot
hold on
plot(Tim2/max(Tim2),linspace(length(Tim2)-1,0,length(Tim2)),'LineWidth',3); goodplot
hold on
plot(Tim1/max(Tim1),linspace(length(Tim1)-1,0,length(Tim1)),'LineWidth',3); goodplot
legend('Random','Spread','Stress')

figure
semilogy(Tim3*3,(nRem*1000 + linspace(length(Tim3)-1,0,length(Tim3)))/100000.,'color',[0.1 0.1 0.6],'LineWidth',3); goodplot
hold on
semilogy(Tim2,(nRem*1000 + linspace(length(Tim2)-1,0,length(Tim2)))/100000.,'color',[0.1 0.6 0.1],'LineWidth',3); goodplot
hold on
semilogy(Tim1/10,(nRem*1000 + linspace(length(Tim1)-1,0,length(Tim1)))/100000.,'color',[0.6 0.1 0.1],'LineWidth',3); goodplot
legend('Random','Spread','Stress')
