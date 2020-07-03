clc, clf, clear, close all

for test = 4:4
    N=100;
    K= test-1;   h=0.001;
    V0 = 4.1/100*N; Vmax = V0*N; Km = 0.21; Ga0 = 2.5;
    
    gg = [0.7 0.7 0.1;
        0.1 0.7 0.1;
        0.1 0.1 0.7;
        0.7 0.1 0.1];
    iter=22000;
    
    t=0:h:h*iter;
    
    theta=zeros(N,iter);
    
    theta(:,1)=2*pi*rand(N,1);
    fir = [];
    Omega=4*pi+0.0*randn(N,1);
    x0 = 0; y0 = 0; D = 0.25; DA = 0;
    Sav = zeros(iter,1);
    R = ones(N,1);
    c=0;
    for j=1:iter
        RT = j*h;
        if sin(RT) > 0.9965
            K = 0.0; BB = find(rand(N,1)>0.0); Omega(BB,1) = 30*pi+1*randn(length(BB),1);
        else
            K = 0.0; Omega=8*pi+1*randn(N,1);
        end
%         if(RT > 15 && RT < 20)
%             K = 4;
%         end
        if(RT > 5 && RT < 6)
            BB = find(rand(N,1) > 0.0); Omega(BB,1) = 0*pi +0*randn(length(BB),1);
        end
        if(RT > 10 && RT < 11)
            BB = find(rand(N,1) > 0.0); Omega(BB,1) = 0*pi +0*randn(length(BB),1);
        end
        if(RT > 15 && RT < 16)
            BB = find(rand(N,1) > 0.0); Omega(BB,1) = 0*pi +0*randn(length(BB),1);
        end
        k1=kuramoto(theta(:,j),K,N,Omega);
        k2=kuramoto(theta(:,j)+0.5*h*k1,K,N,Omega);
        k3=kuramoto(theta(:,j)+0.5*h*k2,K,N,Omega);
        k4=kuramoto(theta(:,j)+h*k3,K,N,Omega);
        if(RT > 10 && RT < 11)
            D = 0.0
        elseif(RT > 5 && RT < 6)
            D = 0.0
            elseif(RT > 15 && RT < 16)
            D = 0.0
        else
            D = 0.25
        end
        theta(:, j+1)=theta(:,j)+(h/6)*(k1+2*k2+2*k3+k4) + sqrt(2*D*h)*randn(N,1);
        x=cos(theta(:,j)); y=sin(theta(:,j));
        
        A = find(x>0 & x0<0 & R==1); R(A) = 0;
        B = find(y>0 & y0<0); R(B) = 1;
        
        fir = [fir; A j*ones(length(A),1)];
        x0 = x; y0 = x;
        
        if test == 3
            V = V0/(1-1*0.6);
            Ga = Ga0/(1-1*0.6);
        elseif test == 2
            V = V0*(1-1*0.6);
            Ga = Ga0;
        elseif test == 1
            V = V0;
            Ga = Ga0/(1-1*0.6);
        else
            V = V0;
            Ga = Ga0;
        end
        
        DA = DA + h*(Ga*length(A) - V*DA/(DA + Km));
        Sav(j,1) = RT;
        Sav(j,2) = DA;
    end
    subplot(10,1,1:6)
    plot(Sav(:,1),Sav(:,2),'color',[0.1 0.8 0.1],'LineWidth',3); hold on; goodplot
    set(gca,'XTick',[]);
    legend('Fig. 2A','Fig. 2B','Fig. 2C','No compensation')
    
    subplot(10,1,7:10)
    plot(fir(:,2)*h,fir(:,1),'.','color',[0.1 0.8 0.1]); hold on
    if test < 4
        set(gca,'XTick',[]);
    end
    set(gca,'YTick',[]);
end
goodplot
T = [];
for i = 1:N
    KK = find(fir(:,1)==i); fir(KK,2);
    T = [T; fir(KK(2:end),2)-fir(KK(1:end-1),2)];
end
T=T*h;
figure
h = histogram(T,'Normalization','pdf');
h.BinEdges = [0 : 0.1 : 10];
h.FaceColor = [0.1 0.8 0.0];
h.EdgeColor = [0.1 0.5 0.1];
h.LineWidth = 4;
