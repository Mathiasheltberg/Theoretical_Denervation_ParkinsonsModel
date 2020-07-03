clear all; close all; clc

in = 2; out = 1; nRem = 20;

load(['../P',num2str(in),'.mat'],'P1');
DK1 = load(['../Remove_Random/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
DK1 = DK1.DK;

a = 0.3; b = 1.5; c = 2.1; %% Geometrical definitions for Putamen %%
PS = [P1(find(DK1),1) P1(find(DK1),2) P1(find(DK1),3)];
N = 200000;
x = - a + 2*a*rand(N,1); y = - b + 2*b*rand(N,1); z = - c + 2*c*rand(N,1);
Re = find((x/a).^2 + (y/b).^2 + (z/c).^2 <= 1); NRe = 10000; % Place NRe neurons in striatum
x = x(Re(1:NRe)); y = y(Re(1:NRe)); z = z(Re(1:NRe));
Sav = zeros(NRe,2);
for i = 1:NRe
    PP = [x(i) y(i) z(i)];    
    KK = sqrt(sum( (PS-PP)'.^2));
    Sav(i,1) = min(KK);
    Sav(i,2) = length(find(KK<0.05));
end
figure
h = histogram(Sav(:,2),'Normalization','probability'); hold on
%h.BinEdges = [0:.01:0.5];
h.BinEdges = [0:1:30];
h.FaceColor = [0.0 0.0 0.7];
h.EdgeColor = [0.1 0.1 0.5];
h.LineWidth = 4;
h.FaceAlpha = 0.2;
goodplot
    
in = 2; out = 1; nRem = 10;

load(['../P',num2str(in),'.mat'],'P1');
DK2 = load(['../Remove_Spread/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
DK2 = DK2.DK;

a = 0.3; b = 1.5; c = 2.1; %% Geometrical definitions for Putamen %%
PS = [P1(find(DK2),1) P1(find(DK2),2) P1(find(DK2),3)];
N = 200000;
x = - a + 2*a*rand(N,1); y = - b + 2*b*rand(N,1); z = - c + 2*c*rand(N,1);
Re = find((x/a).^2 + (y/b).^2 + (z/c).^2 <= 1); NRe = 10000; % Place NRe neurons in striatum
x = x(Re(1:NRe)); y = y(Re(1:NRe)); z = z(Re(1:NRe));
Sav = zeros(NRe,1);
for i = 1:NRe
    PP = [x(i) y(i) z(i)];
    
    KK = sqrt(sum( (PS-PP)'.^2));
    Sav(i,1) = min(KK);
    Sav(i,2) = length(find(KK<0.05));
end

h = histogram(Sav(:,2),'Normalization','probability');
h.BinEdges = [0:1:30];
%h.BinEdges = [0:.01:0.5];
h.FaceColor = [0.0 0.7 0.0];
h.EdgeColor = [0.1 0.5 0.1];
h.LineWidth = 4;
h.FaceAlpha = 0.2;
goodplot

in = 2; out = 1; nRem = 10;

load(['../P',num2str(in),'.mat'],'P1');
DK3 = load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
DK3 = DK3.DK;

a = 0.3; b = 1.5; c = 2.1; %% Geometrical definitions for Putamen %%
PS = [P1(find(DK3),1) P1(find(DK3),2) P1(find(DK3),3)];
N = 200000;
x = - a + 2*a*rand(N,1); y = - b + 2*b*rand(N,1); z = - c + 2*c*rand(N,1);
Re = find((x/a).^2 + (y/b).^2 + (z/c).^2 <= 1); NRe = 10000; % Place NRe neurons in striatum
x = x(Re(1:NRe)); y = y(Re(1:NRe)); z = z(Re(1:NRe));
Sav = zeros(NRe,1);
for i = 1:NRe
    PP = [x(i) y(i) z(i)];
    
    KK = sqrt(sum( (PS-PP)'.^2));
    Sav(i,1) = min(KK);
    Sav(i,2) = length(find(KK<0.05));
end
h = histogram(Sav(:,2),'Normalization','probability');
h.BinEdges = [0:1:30];
h.FaceColor = [0.7 0.0 0.0];
h.EdgeColor = [0.5 0.1 0.1];
h.LineWidth = 4;
h.FaceAlpha = 0.2;
goodplot

plot(ones(100,1)*0.1, linspace(0,1,100)','--k','LineWidth',3)
    

    

