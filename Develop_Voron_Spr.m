clear all; close all; clc

Points = [1 3 6 10 13 16 20 25 30 35 40];
Largest = zeros(11,10);
PlRem = zeros(11,1);
for i1 = 0:length(Points)-1
    i1
    for test = 1:25
    in = test; out = 1; nRem = Points(length(Points)-i1);
    
    load(['../../P',num2str(in),'.mat'],'P1');
    load(['../Remaining_',num2str(nRem),'/AK_',num2str(in),'_',num2str(out),'.mat'],'AK');
    load(['../Remaining_',num2str(nRem),'/UK_',num2str(in),'_',num2str(out),'.mat'],'UK');
    load(['../Remaining_',num2str(nRem),'/DK_',num2str(in),'_',num2str(out),'.mat'],'DK');
    load(['../Remaining_',num2str(nRem),'/Time_',num2str(in),'_',num2str(out),'.mat'],'Tim');
    
    a = 0.3; b = 1.5; c = 2.1; %% Geometrical definitions for Putamen %%
    N = [P1(find(DK),1) P1(find(DK),2) P1(find(DK),3)];
    xn = P1(find(DK),1); yn = P1(find(DK),2); zn = P1(find(DK),3);
    tic
    % Calculating voronoi tesselation and the corresponding vertices
    [V1 C1] = voronoin(N);
    V1 = V1(2:end,:)'; V1 = V1';
    V1 = V1(find((V1(:,1)/a).^2+(V1(:,2)/b).^2+(V1(:,3)/c).^2 <= 1),:);
    toc
    % Calculating distances from vertices to neurons
    tic
    dmaxv = []; Pmaxv = [];
    dmax = min(sqrt( (V1(1,1) - xn).^2 + (V1(1,2) - yn).^2 + (V1(1,3) - zn).^2 ));
    for i = 2:length(V1(:,1))
        if (min(sqrt( (V1(i,1) - xn(1:100)).^2 + (V1(i,2) - yn(1:100)).^2 + (V1(i,3) - zn(1:100)).^2 ))  > dmax)
            if (min(sqrt( (V1(i,1) - xn).^2 + (V1(i,2) - yn).^2 + (V1(i,3) - zn).^2 ))  > dmax)
                dmax = min(sqrt( (V1(i,1) - xn).^2 + (V1(i,2) - yn).^2 + (V1(i,3) - zn).^2 ))
                dmaxv = [dmaxv;dmax]
                Pmax = [V1(i,1) V1(i,2) V1(i,3)];
                Pmaxv = [Pmaxv;Pmax];
            end
        end
    end
    
    dmaxn = dmaxv(end);
    Pmaxv = []; dmaxv = [];
    for i = 2:length(V1(:,1))
        if (min(sqrt( (V1(i,1) - xn(1:100)).^2 + (V1(i,2) - yn(1:100)).^2 + (V1(i,3) - zn(1:100)).^2 ))  > dmaxn)
            if (min(sqrt( (V1(i,1) - xn).^2 + (V1(i,2) - yn).^2 + (V1(i,3) - zn).^2 ))  > dmaxn)
                dmax1 = min(sqrt( (V1(i,1) - xn).^2 + (V1(i,2) - yn).^2 + (V1(i,3) - zn).^2 ));
                dmaxv = [dmaxv;dmax1];
                Pmax1 = [V1(i,1) V1(i,2) V1(i,3)];
                Pmaxv = [Pmaxv;Pmax1];
            end
        end
    end
    [B,I] = sort(dmaxv,'descend');
    dmaxv = dmaxv(I); Pmaxv = Pmaxv(I,:);
    toc
   figure
   plot3(P1(find(DK),1),P1(find(DK),2),P1(find(DK),3),'.r'); hold on
    for i = 1:length(dmaxv)
        rad = dmaxv(i);
        phi=linspace(0,pi,10);
        theta=linspace(0,2*pi,15);
        [phi,theta] = meshgrid(phi,theta);
        xd = rad*sin(phi).*cos(theta);
        yd = rad*sin(phi).*sin(theta);
        zd = rad*cos(phi);
       plot3(Pmaxv(i,1) + xd, Pmaxv(i,2) + yd, Pmaxv(i,3) + zd,'--k'); hold on
       axis([-5 5 -5 5 -5 5])
   end
    PlRem(i1+1,1) = nRem;
    Largest(i1+1,test) = dmax;
    end
    plot3(Pmax(1),Pmax(2),Pmax(3),'*')
    
    Pro = find(sqrt( (Pmax(1) - xn).^2 + (Pmax(2) - yn).^2 + (Pmax(3) - zn).^2) < dmax);
    plot3(xn(Pro),yn(Pro),zn(Pro),'.b')
end

figure;

DD = mean(Largest');
plot(PlRem,DD,'-*'); goodplot

figure
h = histogram(dmaxv);
ylim([0.0 30])
% set(gca,'YScale','log')
h.BinEdges = [0:.01:0.5];
h.FaceColor = [0.0 0.0 0.7];
h.EdgeColor = [0.1 0.1 0.5];
h.LineWidth = 4;
goodplot
