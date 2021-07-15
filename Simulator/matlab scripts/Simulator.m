%% Initialization
Te = 0.0168;
%Te = 0.002;

N = 100*24*3600/Te;

uE = 3.986004418e14;
Tr = 2*236e-3;


%% Simulation
tstart = tic;
[x,y] = simu(Te, N);
toc(tstart)
T = linspace(0,size(x,2)*(Te*1e4),size(x,2));

%% Plot
T = linspace(0,size(x,2)*(Te*1e4),size(x,2));
figure(1);
% viscircles([0,0],6371e3,'LineWidth', 1);
% viscircles([0,0],384000e3,'LineWidth', 1);
%hold on
for i = 1:1:size(x,2)
    %plot3(T/(24*3600), x(i), y(i), '+');
    plot( x(i), y(i), 'b+'); hold on;
    %plot(M.x(i),M.y(i), 'ro');
    xlim([-1e7 1e7]);    
    ylim([-1e7 1e7]);
    zlim(([0 300]));

    drawnow
end
