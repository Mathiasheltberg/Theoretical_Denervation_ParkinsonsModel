clear all; close all; clc
Points = [1 3 6 10 13 16 20 25 30 35 40];
Stat = zeros(11,25,3);
PlRem = zeros(11,1);
for test = 1:length(Points)
    for test2 = 1:25
        test
        in = test2; out = 1; nRem = Points(test);
        
        load(['../../P',num2str(in),'.mat'],'P1');
        load(['../Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
        load(['../Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
        load(['../Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
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

% figure
% h = histogram(Dis);
% ylim([0.1 10000])
% set(gca,'YScale','log')
% set(gca,'XScale','log')
% h.BinEdges = [0:1:10000];
% h.FaceColor = [0.0 0.7 0.0];
% h.EdgeColor = [0.1 0.5 0.1];
% h.LineWidth = 4;
% goodplot

