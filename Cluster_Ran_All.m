clear all; close all; clc

in = 1; out = 1; nRem = 10;

load(['../../P',num2str(in),'.mat'],'P1');
load(['../Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
load(['../Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
load(['../Remaining_',num2str(nRem),'/Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
NT = 10500; ND = find(DK);
Le = zeros(sum(DK),1); AA = find(DK); used = zeros(NT,200);
x = P1(:,1); y = P1(:,2); z = P1(:,3);
AllUsed = []; cA = 0;
for i = 1:NT
    Ny = []; 
    if (ismember(AA(i),AllUsed) == 0)
        cA = cA + 1; cn = 0;
        used = [AA(i)];
        Ny = [Ny AK(AA(i),1:UK(AA(i)))];
        while (length(Ny) > 0)
            cn = cn+1;
            Kn = Ny(1);
            used = [used Kn];
            Ny = [Ny AK(Kn,1:UK(Kn))];
            Ny = unique(Ny); Ny = Ny(find(ismember(Ny,used) == 0));
        end
        M{cA} = used;
        AllUsed = [AllUsed used];
    end        
end

hsv(cA);
Dis = zeros(cA,1);
for i = 1:cA
    Dis(i) = length(M{i});
    plot3(x(M{i}),y(M{i}),z(M{i}),'.'); hold on;
end
goodplot

figure
h = histogram(Dis);
ylim([0.1 10000])
set(gca,'YScale','log')
set(gca,'XScale','log')
h.BinEdges = [0:1:10000];
h.FaceColor = [0.0 0.7 0.0];
h.EdgeColor = [0.1 0.5 0.1];
h.LineWidth = 4;
goodplot

figure
h = histfit(Dis,max(Dis),'exponential'); goodplot
% set(gca,'YScale','log')
set(h(1),'facecolor',[0.9 0.99 0.9]); 
set(h(1),'edgecolor',[0.1 0.5 0.1],'LineWidth',4); 
set(h(2),'color',[0.9 0.1 0.0],'LineWidth',4)
goodplot
