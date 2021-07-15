%% Orbital parameter

% starting orbit: LEO
a1 = 185e3 + Re;
e1 = 0;
i1 = asin(Re/a1)*180/pi * 1.1; % inclination of initial orbit to have no shadow time, with 10% margin
MLT = "6am-6pm";
% Argument of perigee ?

% target orbit: GSO
a2 = 35786e3 + Re;
e2 = 0;
i2 = 0;
P = 23*3600 + 56*60 + 4; % period in seconds
%RAAN and argument of perigee are not defined for GSO

%% Trajectory

altitude = a1:1000:a2;
inclination_SSO = 180-acos(-(altitude./(12352e3)).^(7/2))*180/pi; % inclination to keep a Sun-synchronous orbit at a specific altitude 
inclination_noEclipse = asin(Re./altitude)*180/pi;

deltaV = sqrt(uE/a1)*(sqrt(2*a2/(a1+a2)) - 1) + sqrt(uE/a2)*(1 - sqrt(2*a1/(a1+a2)))