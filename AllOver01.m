clear all; close all; clc

Points = [1 3 6 10 13 16 20 25 30 35 40];
ALLP = zeros(11,10,3);
for test = 1:11
   test
    for test2 = 1:10
        in = test2; out = 1; nRem = Points(test);
        
        load(['../P',num2str(in),'.mat'],'P1');
        DK1 = load(['../Remove_Random/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
        DK1 = DK1.DK;
        
        a = 0.3; b = 1.5; c = 2.1; %% Geometrical definitions for Putamen %%
        PS = [P1(find(DK1),1) P1(find(DK1),2) P1(find(DK1),3)];
        N = 200000;
        x = - a + 2*a*rand(N,1); y = - b + 2*b*rand(N,1); z = - c + 2*c*rand(N,1);
        Re = find((x/a).^2 + (y/b).^2 + (z/c).^2 <= 1); NRe = 10000; % Place NRe neurons in striatum
        x = x(Re(1:NRe)); y = y(Re(1:NRe)); z = z(Re(1:NRe));
        Sav = zeros(NRe,1);
        for i = 1:NRe
            PP = [x(i) y(i) z(i)];
            
            KK = sqrt(sum( (PS-PP)'.^2));
            Sav(i,1) = min(KK);
        end
        ALLP(test,test2,1) = length(find(Sav(:,1)>0.1));
        
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
        end
        
        ALLP(test,test2,2) = length(find(Sav(:,1)>0.1));
        
        
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
        end
        
        ALLP(test,test2,3) = length(find(Sav(:,1)>0.1));
    end
    
end
PNew = flip(Points);
figure
mx = mean(ALLP(:,:,1)')/NRe;
sx = std(ALLP(:,:,1)')/(NRe*sqrt(10));
plot(PNew,mx,'b','LineWidth',3); hold on
plotshaded(PNew,[(mx-sx)',(mx+sx)']','c');

mx = mean(ALLP(:,:,3)')/NRe;
sx = std(ALLP(:,:,3)')/(NRe*sqrt(10));
plot(PNew,mx,'r','LineWidth',3); hold on
plotshaded(PNew,[(mx-sx)',(mx+sx)']','r');

mx = mean(ALLP(:,:,2)')/NRe;
sx = std(ALLP(:,:,2)')/(NRe*sqrt(10));
plot(PNew,mx,'color',[0.1 0.5 0.1],'LineWidth',3); hold on
plotshaded(PNew,[(mx-sx)',(mx+sx)']','g'); goodplot