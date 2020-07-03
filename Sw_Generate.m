clear all; close all; clc
for num = 6:16; % Generate numbers of test brains
    N = 200000;
    num
    a = 0.3; b = 1.5; c = 2.1; %% Ellipsoidal axes for striatum. Measures in cm!!!
    x = - a + 2*a*rand(N,1); y = - b + 2*b*rand(N,1); z = - c + 2*c*rand(N,1);
    Re = find((x/a).^2 + (y/b).^2 + (z/c).^2 <= 1); NRe = 100000; % Place NRe neurons in striatum
    x = x(Re(1:NRe)); y = y(Re(1:NRe)); z = z(Re(1:NRe));
  %  plot3(x,y,z,'.');
    r0 = 0.05; % r0 is the radius of each neuron (axonal arbor)
    lambda = NRe/(a*b*c)*r0^3; lambda0 = lambda; Var = round(lambda + 5*sqrt(lambda));
    AK = zeros(NRe,Var+10); % AK is a matrix with all the connections for each neuron
    UK = zeros(NRe,1); % UK is an array with the number of connections for each neuron
    tic
    for i = 1:NRe;
        v = i + find(sqrt( (x(i)-x(i+1:end)).^2 + (y(i)-y(i+1:end)).^2 + (z(i)-z(i+1:end)).^2 ) <= r0 )';
        if (find(v < i) > 0)
            disp('prob')
            break
        end
        AK(i, UK(i) + 1 : UK(i) + length(v)) = v;
        for j = 1:length(v)
            AK(v(j),UK(v(j))+1) = i;
            UK(v(j)) = UK(v(j)) + 1;
        end
        UK(i) = UK(i) + length(v);
    end
    toc
    tic
    
    P1 = [x y z]; % P is a NRe * 3 with all the spatial coordinates for all neurons
    save(['P',num2str(num)],'P1');
    save(['AK',num2str(num)],'AK');
    save(['UK',num2str(num)],'UK');
    toc
end