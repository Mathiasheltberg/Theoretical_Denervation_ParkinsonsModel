clear all; close all; clc
All1 = zeros(16,500);
All2 = zeros(16,500);
All3 = zeros(16,500);

nRem = 1;  out = 1;
for type = 1:3
    
    for test2 = 1:16
        in = test2;
        if type == 1
            load(['../Rand/Remaining_',num2str(nRem),'_Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
            idx = length(find(Tim<2))
            Tim = Tim;
        elseif type ==2
            load(['../Spread/Remaining_',num2str(nRem),'_Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
            Tim = Tim/3;
            idx = length(find(Tim<2))
        else
            load(['../Stress/Remaining_',num2str(nRem),'_Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
            Tim = Tim/70;
            idx = length(find(Tim<2))
        end
        
        Del = 0.075;
        L = [];
        for i = 1:500
            idx = length(find(Tim<i*Del));
            L = [L; i*Del 100000-idx];
        end
        if (type==1)
            All1(test2,:) = L(:,2);
        elseif type == 2
            All2(test2,:) = L(:,2);
        else
            All3(test2,:) = L(:,2);
        end
        if (test2 < 7)
        semilogy(L(:,1),L(:,2),'r'); 
        else
            semilogy(L(:,1),L(:,2),'b'); 
        end
            hold on;  goodplot
    end
end
PNew = L(:,1);
figure
MN = mean(All3)';
SN = std(All3)'./sqrt(16);
plot(PNew,MN,'r','LineWidth',2); hold on
plotshaded(PNew',[(MN-SN),(MN+SN)]','r');
set(gca, 'YScale', 'log')

MR = mean(All1)';
SR = std(All1)'./sqrt(16);
plot(PNew,MR,'b','LineWidth',2); hold on
plotshaded(PNew',[(MR-SR),(MR+SR)]','c');
set(gca, 'YScale', 'log')

MS = mean(All2)';
SS = std(All2)'./sqrt(16);
plot(PNew,(MS),'color',[0.1 0.5 0.1],'LineWidth',2); hold on
plotshaded(PNew',[(MS-SS),(MS+SS)]','g');
set(gca, 'YScale', 'log')
goodplot;

