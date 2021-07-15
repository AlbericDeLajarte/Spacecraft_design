%% Parameters

dT = 1; % time discretization in seconds


%% Init
T_max = 24*3600*30*9;
Time = 0:dT:T_max-1;

Altitude = zeros(1, T_max*dT);
Altitude(1) = a1;

Inclination = zeros(1, T_max*dT);
Inclination(1) = 0; %Inclination(1) = i1;

Energy = zeros(1, T_max*dT);
Energy(1) = - uE/(2*Altitude(1));

Speed = zeros(1, T_max*dT);
Speed(1) = sqrt(uE/Altitude(1));

Mass = zeros(1, T_max*dT);
Mass(1) = M_dry + M_prop;

FSM = 1;

%% Simulation
i=1;
while (FSM ~= 3 && i< T_max)
    
    Energy(i+1) = Energy(i) + Speed(i) *T/Mass(i) *dT;
    Mass(i+1) = Mass(i) - M_flow*dT;
    
    Altitude(i+1) = -uE/(2*Energy(i+1));
    Speed(i+1) = sqrt(uE/Altitude(i+1));
    
    switch FSM
        
        case 1 % SSO
            
            %Inclination(i+1) = 180-acos(-(Altitude(i+1)/(12352e3))^(7/2))*180/pi;
            %theta = abs(Inclination(i+1) - Inclination(i)); 
            %Mass(i+1) = Mass(i+1)*exp(-2*Speed(i+1)*sind(theta/2)/(gE*Impulse));

            if(Inclination(i+1)< asin(Re/Altitude(i+1))*180/pi *1.1)
                FSM = FSM+1;
            end
        
        case 2 % fixed attitude
            
            Inclination(i+1) = Inclination(i);
            
            if(Altitude(i+1) >= 300000e3)
                FSM = FSM+1;
            end
    end
  
    i = i+1;
end

while(Inclination(i)>0 && i< T_max)
    
    Speed(i+1) = Speed(i);
    Mass(i+1) = Mass(i) - M_flow*dT;
    Altitude(i+1) = Altitude(i);
    Energy(i+1) = Energy(i);
    
    theta = -2*asind( gE*Impulse/(2*Speed(i))*log(1-M_flow*dT/Mass(i)) );
    Inclination(i+1) = Inclination(i)  - theta;
    i = i+1;
end

%% Plot

figure(1);
yyaxis left; plot(Time(1:20:end)/(3600*24), Altitude(1:20:end)./1000 -6371); ylabel("Altitude [km]")
yyaxis right; plot(Time(1:20:end)/(3600*24), Mass(1:20:end)); ylabel("Mass [kg]")

figure(2); 
yyaxis left; plot(Time/(3600*24), Altitude./1000 - 6371 ); ylabel("Altitude [km]")
yyaxis right; plot(Time/(3600*24), Inclination); ylabel("Inclination [degree]")
