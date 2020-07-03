%clear all; close all; clc


F10 = importdata('../MeanFreq1.csv');
F20 = importdata('../MeanFreq2.csv');
F1a = importdata('../MeanFreq1CC1.csv');
F2a = importdata('../MeanFreq2CC1.csv');
F1b = importdata('../MeanFreq1CC2.csv');
F2b = importdata('../MeanFreq2CC2.csv');
F1c = importdata('../MeanFreq1CC3.csv');
F2c = importdata('../MeanFreq2CC3.csv');

F1 = [F10 F1a F1b F1c];
F2 = [F20 F2a F2b F2c];
Nue = [1 3 6 10 13 16 20 25 30 35 40 50 60 70 80 90];
% Mme1 = zeros(length(Nue),4,4);
% Msd1 = zeros(length(Nue),4,4);
% Mme2 = zeros(length(Nue),4,4);
% Msd2 = zeros(length(Nue),4,4);

for nni = 1:length(Nue);
    nni
    in = 1; out = 1; nRem = Nue(nni);
    load(['../P',num2str(in),'.mat'],'P1');
    for type = 1:1
        for test = 1:4
            if test == 1;
                load(['../Rand/Remaining_',num2str(nRem),'_DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
            elseif (test==2)
                load(['../Spread/Remaining_',num2str(nRem),'_DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
            elseif (test == 3)
                load(['../Stress/Remaining_',num2str(nRem),'_DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
            else
                DK = linspace(1,100000,100000)';
            end
            
            ND = find(DK);
            a = 0.3; b = 1.5; c = 2.1;
            P1n = P1(ND,:);
            
            ac = zeros(5000,1); M = [];
            for i = 1:5000
                
                x = -a + 2*a*rand;
                y = -b + 2*b*rand;
                z = -c + 2*c*rand;
                
                while (x^2/a^2 + y^2/b^2 + z^2/c^2 > 1)
                    x = -a + 2*a*rand;
                    y = -b + 2*b*rand;
                    z = -c + 2*c*rand;
                end
                Pn = [x, y, z]';
                dd = sqrt( (P1n(:,1)-Pn(1)).^2 + (P1n(:,2)-Pn(2)).^2 + (P1n(:,3)-Pn(3)).^2);
                n1 = find(dd < 0.05);
                n = 1 + poissrnd(length(n1)*10); if (n>140); n=140; end
                if (n>1)
                    ac1(i) = F1(round(n/2),type);
                    ac2(i) = F2(round(n/2),type);
                else
                    ac1(i) = F1(1,type);
                    ac2(i) = F2(1,type);
                end
                
                
            end
            Mme1(nni,test,type) = mean(ac1);
            Msd1(nni,test,type) = std(ac1);
            Mme2(nni,test,type) = mean(ac2);
            Msd2(nni,test,type) = std(ac2);
        end
    end
    
end
% Nue = flip(Nue);
% Nue = 100-Nue;
y1 = flip(smooth(Mme2(:,1,1)))./flip(smooth(Mme2(:,4,1)));
y2 = flip(smooth(Mme2(:,1,2)))./flip(smooth(Mme2(:,4,1)));
y3 = flip(smooth(Mme2(:,1,3)))./flip(smooth(Mme2(:,4,1)));
y4 = flip(smooth(Mme2(:,1,4)))./flip(smooth(Mme2(:,4,1)));
figure
plot(Nue',y1,'-*','color',[0.7 0.1 0.1],'LineWidth',3); hold on;
plot(Nue',y2,'-*','color',[0.7 0.7 0.1],'LineWidth',3);
plot(Nue',y3,'-*','color',[0.1 0.7 0.1],'LineWidth',3); goodplot;
plot(Nue',y4,'-*','color',[0.1 0.1 0.7],'LineWidth',3); goodplot;
plot(Nue',smooth(Msd2(:,4,4))./smooth(Msd2(:,4,4)),'--k','LineWidth',3); goodplot;
%axis([10 99 0 300])
% 
% 
% figure;
% plot(Nue',smooth(Mme2(:,1))./smooth(Mme2(:,4)),'color',[0.1 0.1 0.7],'LineWidth',3); hold on;
% plot(Nue',smooth(Mme2(:,2))./smooth(Mme2(:,4)),'color',[0.7 0.1 0.1],'LineWidth',3);
% plot(Nue',smooth(Mme2(:,3))./smooth(Mme2(:,4)),'color',[0.1 0.7 0.1],'LineWidth',3);   goodplot;
% plot(Nue',smooth(Mme2(:,4))./smooth(Mme2(:,4)),'--','color',[0.7 0.7 0.7],'LineWidth',3); goodplot;
% 
% %axis([0 90 0 300])
% 
% figure;
% plot(Nue',smooth(Msd1(:,1))./smooth(Msd1(:,4)),'color',[0.1 0.1 0.7],'LineWidth',3); hold on;
% plot(Nue',smooth(Msd1(:,2))./smooth(Msd1(:,4)),'color',[0.7 0.1 0.1],'LineWidth',3);
% plot(Nue',smooth(Msd1(:,3))./smooth(Msd1(:,4)),'color',[0.1 0.7 0.1],'LineWidth',3); goodplot;
% plot(Nue',smooth(Msd1(:,4))./smooth(Msd1(:,4)),'--','color',[0.7 0.7 0.7],'LineWidth',3); goodplot;
% %axis([10 99 0 300])
% 
% figure;
% plot(Nue',smooth(Msd2(:,1))./smooth(Msd2(:,4)),'color',[0.1 0.1 0.7],'LineWidth',3); hold on;
% plot(Nue',smooth(Msd2(:,2))./smooth(Msd2(:,4)),'color',[0.7 0.1 0.1],'LineWidth',3);
% plot(Nue',smooth(Msd2(:,3))./smooth(Msd2(:,4)),'color',[0.1 0.7 0.1],'LineWidth',3);   goodplot;
% plot(Nue',smooth(Msd2(:,4))./smooth(Msd2(:,4)),'--','color',[0.7 0.7 0.7],'LineWidth',3); goodplot;
% 
% %axis([10 99 0 300])

Nue(6)
xx = [Mme1(9,1,:); Mme1(9,2,:); Mme1(9,3,:)];
xx = squeeze(xx);
xx = xx/Mme1(end,4,1);
figure; b = bar(xx,'LineWidth',3); goodplot
b(1).FaceColor = [0.7 0.1 0.1];
b(2).FaceColor = [0.7 0.7 0.1];
b(3).FaceColor = [0.1 0.7 0.1];
b(4).FaceColor = [0.1 0.1 0.7];