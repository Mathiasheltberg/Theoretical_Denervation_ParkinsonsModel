clear all; close all; clc
for inp = 6:16
    inp 
    outp = 1; nRem = 1;
    load(['../P',num2str(inp),'.mat'],'P1');
    load(['../AK',num2str(inp),'.mat'],'AK');
    load(['../UK',num2str(inp),'.mat'],'UK');
    N = 100000;
    a = 0.3; b = 1.5; c = 2.1; r0 = 0.05; lambda = N/(a*b*c)*r0^3; lambda0 = lambda; Var = round(lambda + 5*sqrt(lambda));
    
    NT = nRem*1000; ts = 1000; thr = lambda0; s = 10; click = 1; RT = 0; Sa = zeros(round((N-NT)/ts),1);
    PK = ones(N,1); DK = ones(N,1); c = 0; T = zeros(N,1);
    

    Points = [1 3 6 10 13 16 20 25 30 35 40 50 60 70 80 90];
    PoiN = Points*1000;
    sw = 0;
    
    tic
    
    x = P1(:,1);
    y = P1(:,2);
    z = P1(:,3);
    
    KT= randperm(N)';
    Any = [KT(1:1)];
    A = Any(1);
    Tim = [];
    
    %%%% Any is a collection of all infected cells
    %%% UK is the
    
 %   plot3(x(Any),y(Any),z(Any),'b*'); hold on;
    while (N > NT)
        c = c+1;
                
        RT = RT - log(rand)/length(Any);
        Tim = [Tim;RT];
        if (UK(A) > 0)
            for i = 1:UK(A)
                Af = AK(A,i);
                B = find(AK(Af,:) == A);
                AK(Af,B) = 0;
                AK(Af,B:UK(Af)) = AK(Af,B+1:UK(Af)+1);
                UK(Af) = UK(Af) - 1;
            end
        end
        K = randperm(UK(A));
        if (UK(A) == 1)
            Any = [Any; AK(A,K(1))];
        elseif (UK(A) > 1)
            Any = [Any; AK(A,K(1:2))'];
        end
        Any = Any(2:end);
        
        UK(A) = 0; PK(A) = 0; AK(A,:) = 0; DK(A) = 0;
        N = N-1;
        %%% Here we choose the next cell to die
        Any = unique(Any);
        K2 = randperm(length(Any))';
        Any = Any(K2);        
        A = Any(1);
                
        if (c > click*ts)
            Sa(click,1) = RT; Sa(click,2) = N;
            click = click+1
            sw = 1;
        end
        
        if (ismember(N,PoiN) && sw == 1)
            save(['Remaining_',num2str(100-click),'_DK_',num2str(inp),'_',num2str(outp)],'DK');
            %save(['Remaining_',num2str(100-click),'_UK_',num2str(inp),'_',num2str(outp)],'UK');
            %save(['Remaining_',num2str(100-click),'_AK_',num2str(inp),'_',num2str(outp)],'AK');
            save(['Remaining_',num2str(100-click),'_Time_',num2str(inp),'_',num2str(outp)],'Tim');
            sw = 0;
        end
        
    end
    toc
end
