clear all; close all; clc
Points = [1 3 6 10 13 16 20 25 30 35 40];
Stat = zeros(11,25,3);
PlRem = zeros(11,1);
for test = 1:length(Points)
    for test2 = 1:10
        test
        in = test2; out = 1; nRem = Points(test);
        
        load(['../P',num2str(in),'.mat'],'P1');
        load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
        load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
        load(['../Remove_Neighbour/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
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
        
        hsv(cA);
        Dis = zeros(cA,1);
        for i = 1:cA
            Dis(i) = length(M{i});
            %plot3(x(M{i}),y(M{i}),z(M{i}),'.'); hold on;
        end
        Stat(test,test2,1) = length(Dis);
        Stat(test,test2,2) = max(Dis);
        Stat(test,test2,3) = mean(Dis);
        %goodplot
    end
    PlRem(test,1) = nRem;
end

for i = 1:10
    plot(Points,Stat(:,i,2)./(Points'*1000)); hold on
end
plot(Points,mean(Stat(:,:,2)')'./(Points'*1000),'LineWidth',4); goodplot
figure;
MN = mean(Stat(:,1:10,2)')'./(Points'*1000);
SN = std(Stat(:,1:10,2)')'./(Points'*1000);
plot(Points,MN,'r','LineWidth',3); hold on
plotshaded(Points,[(MN-SN),(MN+SN)]','r');

Stat2 = zeros(11,10,3);
PlRem2 = zeros(11,1);
for test = 1:length(Points)
    for test2 = 1:10
        test
        in = test2; out = 1; nRem = Points(test);
        
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
        
        hsv(cA);
        Dis = zeros(cA,1);
        for i = 1:cA
            Dis(i) = length(M{i});
            %plot3(x(M{i}),y(M{i}),z(M{i}),'.'); hold on;
        end
        Stat2(test,test2,1) = length(Dis);
        Stat2(test,test2,2) = max(Dis);
        Stat2(test,test2,3) = mean(Dis);
        %goodplot
    end
    PlRem2(test,1) = nRem;
end

MR = mean(Stat2(:,1:10,2)')'./(Points'*1000);
SR = std(Stat2(:,1:10,2)')'./(Points'*1000);
plot(Points,MR,'b','LineWidth',3); hold on
plotshaded(Points,[(MR-SR),(MR+SR)]','c');

Stat3 = zeros(11,10,3);
PlRem3 = zeros(11,1);
for test = 1:length(Points)
    for test2 = 1:10
        test
        in = test2; out = 1; nRem = Points(test);
        
        load(['../P',num2str(in),'.mat'],'P1');
        load(['../Remove_Spread/Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
        load(['../Remove_Spread/Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
        load(['../Remove_Spread/Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
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
        
        hsv(cA);
        Dis = zeros(cA,1);
        for i = 1:cA
            Dis(i) = length(M{i});
            plot3(x(M{i}),y(M{i}),z(M{i}),'.'); hold on;
        end
        Stat3(test,test2,1) = length(Dis);
        Stat3(test,test2,2) = max(Dis);
        Stat3(test,test2,3) = mean(Dis);
        goodplot
    end
    PlRem3(test,1) = nRem;
end

figure
PNew = flip(Points);
MN = mean(Stat(:,1:10,2)')'./(Points'*1000);
SN = std(Stat(:,1:10,2)')'./(Points'*1000);
plot(PNew,MN,'r','LineWidth',3); hold on
plotshaded(PNew,[(MN-SN),(MN+SN)]','r');
MR = mean(Stat2(:,1:10,2)')'./(Points'*1000);
SR = std(Stat2(:,1:10,2)')'./(Points'*1000);
plot(PNew,MR,'b','LineWidth',3); hold on
plotshaded(PNew,[(MR-SR),(MR+SR)]','c');
MS = mean(Stat3(:,1:10,2)')'./(Points'*1000);
SS = std(Stat3(:,1:10,2)')'./(Points'*1000);
plot(PNew,(MS),'color',[0.1 0.5 0.1],'LineWidth',3); hold on
plotshaded(PNew,[(MS-SS),(MS+SS)]','g');
goodplot; axis([0 50 0 1.3])
