clear all; close all; clc

in = 2; out = 1; nRem = 20;

load(['../P',num2str(in),'.mat'],'P1');
load(['../Remove_Random/Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
load(['../Remove_Random/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remove_Random/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');

NT = nRem*1000;
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

figure
hsv(cA);
Dis = zeros(cA,1);
for i = 1:cA
    Dis(i) = length(M{i});
    plot3(x(M{i}),y(M{i}),z(M{i}),'.'); hold on;
end
goodplot

% figure
% h = histogram(Dis); hold on
% ylim([0.1 10000])
% set(gca,'YScale','log')
% set(gca,'XScale','log')
% h.BinEdges = [0:1:10000];
% h.FaceColor = [0.0 0.0 0.7];
% h.EdgeColor = [0.1 0.1 0.5];
% h.LineWidth = 3;
% h.FaceAlpha = 0.1;
% h.EdgeAlpha = 0.8;
% goodplot

load(['../Remove_Spread/Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
load(['../Remove_Spread/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remove_Spread/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');

Le = zeros(sum(DK),1); AA = find(DK); used = zeros(NT,2000);
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
figure
hsv(cA);
Dis = zeros(cA,1);
for i = 1:cA
    Dis(i) = length(M{i});
    plot3(x(M{i}),y(M{i}),z(M{i}),'.'); hold on;
end
goodplot

% h = histogram(Dis);
% ylim([0.1 10000])
% set(gca,'YScale','log')
% set(gca,'XScale','log')
% h.BinEdges = [0:1:10000];
% h.FaceColor = [0.0 0.7 0.0];
% h.EdgeColor = [0.1 0.5 0.1];
% h.LineWidth = 3;
% h.FaceAlpha = 0.4;
% h.EdgeAlpha = 0.8;
% goodplot

load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');

Le = zeros(sum(DK),1); AA = find(DK); used = zeros(NT,200);
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

figure
hsv(cA);
Dis = zeros(cA,1);
for i = 1:cA
    Dis(i) = length(M{i});
    plot3(x(M{i}),y(M{i}),z(M{i}),'.'); hold on;
end
goodplot

% h = histogram(Dis);
% ylim([0.1 10000])
% set(gca,'YScale','log')
% set(gca,'XScale','log')
% h.BinEdges = [0:1:10000];
% h.FaceColor = [0.7 0.0 0.0];
% h.EdgeColor = [0.5 0.1 0.1];
% h.LineWidth = 3;
% h.FaceAlpha = 0.3;
% h.EdgeAlpha = 0.8;
% goodplot
