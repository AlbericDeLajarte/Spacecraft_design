% World 
Re = 6371e3;
uE = 3.986e14;
uS = 1.327e20;
gE = 9.81;

% Spacecraft
M_dry = 300; % mass of the spacraft without propellant
M_prop = 300; % mass in kg of propellant

T = 2*236e-3;
Impulse = 4190;
M_flow = T/(gE*Impulse);


fsm = ["SSO", "fixed_attitude", "attitude_correction"];

%% Thermal
A_tot = 1.4*3.1*4 + 1.4*1.4;
A = 1.4*3.1;
J_p = 237 + 21*6371/21371;
sigma = 5.670367e-8;
[epsilon, alpha] = meshgrid(0:0.01:1);
%% Illumination
Q_max = 1*13800*0.29;
J_s = 1370 + 50;
F = 1;
a = 0.39;
J_a = J_s*a*F;
%% eclipse
J_s = 0;
F = 1;
a = 0.39;
J_a = J_s*a*F;

Q_max = 1000;
%%
T = A*J_p + Q_max./epsilon + A*J_s + A*J_a.*alpha./epsilon;

T = (T./(sigma*A_tot)).^(1/4);
mesh(epsilon, alpha, T-273.15);
hold on;
T_max = 15*ones(size(T));
mesh(epsilon, alpha, T_max, 'FaceColor', 'r');
hold on;
plot3(0.78, 0.08, -58.22, 'r+');
xlabel("epsilon"); ylabel('alpha'); zlabel('Temperature')
