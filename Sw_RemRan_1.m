clear all; close all; clc
for inp = 6:16;
    outp = 1; nRem = 1;
    load(['../P',num2str(inp),'.mat'],'P1');
    load(['../AK',num2str(inp),'.mat'],'AK');
    load(['../UK',num2str(inp),'.mat'],'UK');
    x = P1(:,1);
    y = P1(:,2);
    z = P1(:,3);
    N = 100000;
    a = 0.3; b = 1.5; c = 2.1; r0 = 0.05; lambda = N/(a*b*c)*r0^3; lambda0 = lambda; Var = round(lambda + 5*sqrt(lambda));
    NT = nRem*1000; ts = 1000; thr = lambda0; s = 10; click = 1; RT = 0; Sa = zeros(round((N-NT)/ts),1);
    
    
    Points = [1 3 6 10 13 16 20 25 30 35 40 50 60 70 80 90]; % Generate output at these number of remaining neurons (in thousands)
    PoiN = Points*1000;
    sw = 0;
    PK = ones(N,1); 
    DK = ones(N,1); c = 0; T = zeros(N,1);
    Tim = [];
    tic
    while (N > NT)
        c = c+1;
        RT = RT - log(rand)/sum(PK*0.1);        
        Tim = [Tim; RT]; % Tim is an array with the time points of each neuronal removal
        ra = 1 + round(rand*(N-1));
        K = find(DK);
        A = K(ra);
        for i = 1:UK(A)
            Af = AK(A,i);
            B = find(AK(Af,:) == A);
            AK(Af,B) = 0;
            AK(Af,B:UK(Af)) = AK(Af,B+1:UK(Af)+1);
            UK(Af) = UK(Af) - 1;
        end
        T(c) = A;
        UK(A) = 0; PK(A) = 0; AK(A,:) = 0; DK(A) = 0;
        N = N-1;
        if (c > click*ts)
            Sa(click,1) = RT;
            Sa(click,2) = N;
            click = click+1
            sw = 1;
        end
        
        if (ismember(N,PoiN) && sw == 1)
            save(['Remaining_',num2str(100-click),'_DK_',num2str(inp),'_',num2str(outp)],'DK'); %DK is a binary array with 1 if the original neuron is still alive and zero otherwise
            %save(['Remaining_',num2str(100-click),'_UK_',num2str(inp),'_',num2str(outp)],'UK'); %UK is an array with the number of connections for each neuron
            %save(['Remaining_',num2str(100-click),'_AK_',num2str(inp),'_',num2str(outp)],'AK'); %AK is a matrix with the specific connections for each neuron
            save(['Remaining_',num2str(100-click),'_Time_',num2str(inp),'_',num2str(outp)],'Tim'); %Time saves the timepoints where each neuron was removed
            sw = 0;
        end
        
    end
    toc
end
plot3(x(find(DK)),y(find(DK)),z(find(DK)),'.r'); goodplot

