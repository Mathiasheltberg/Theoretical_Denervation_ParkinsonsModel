clear all; close all; clc

Xden = [0.00];
gg = winter(2); N0 = 100; Ga0 = 0.0025; V0 = 0.041;
for test = 1:1
    test
    N = round(N0*(1-Xden(test)));
%    if test == 1
%         V = V0/(1-1*Xden(test));
%         Ga = Ga0/(1-1*Xden(test));
%     elseif test == 2
%         V = V0*(1-1*Xden(test));
%         Ga = Ga0/(1-0*Xden(test));
%     elseif test == 3
%         V = V0*(1-0*Xden(test));
%         Ga = Ga0/(1-1*Xden(test));
%     else
        V = V0;
        Ga = Ga0;
%     end
    Fr = [0 2; 2 2.2; 2.2 3.2; 3.2 3.4; 3.4 4.4; 4.4 4.6; 4.6 5.6; 5.6 10.1];
    f_al = [4.0; 15; 0.001; 15; 0.01; 15; 0.01; 4.0];
    WD = ones(2,1)*0.5;
    for i = 1:length(Fr);
        K = 0.21; f = f_al(i);
        %         la = N*f*Ga - V*N;
        %         de = N*f*K*Ga;
        %         Del = -K*V*N;
        %         D0 = WD(end);
        %         t = linspace(0,(Fr(i,2)-Fr(i,1)),(Fr(i,2)-Fr(i,1))*10);
        %         g0 = la*D0 + Del*log(la*D0 + de);
        %         Ar = exp(1/Del*(la^2*t + de)) * exp(1/Del*(la*D0)) * (la*D0 + de)*1/Del;
        %         WD = 1/la*(lambertw( Ar )*Del - de);
        %         plot(t+Fr(i,1),abs(WD),'-','color',gg(test,:),'LineWidth',7-2*test); hold on
        %        % axis([0 10.0 0 0.4]); goodplot
    end
    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    Tmax = 10.0; RT = 0; ts = 0.001; dt = 0.001;
    Sav = zeros(round(Tmax/ts),2);
    D = 0.05; click = 0; ct = 1;
    while RT < Tmax;
        RT = RT + dt;
        
        D = D + dt*(N*f*Ga - V*N*D/(D+K));
        if (RT > Fr(ct,2))
            ct = ct+1;
            f = f_al(ct);
        end
        if (click*ts < RT)
            click = click+1;
            Sav(click,1) = RT; Sav(click,2) = D;
        end
    end
    plot(Sav(:,1),Sav(:,2),'-','color',[0.1 0.8 0.1],'LineWidth',3); hold on
    %legend('0')
    %axis([0 10.0 0 0.4])
    goodplot
end