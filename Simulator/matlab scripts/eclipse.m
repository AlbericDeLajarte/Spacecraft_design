R = (Re+185000):1000:12000e3;

theta = 180-2*acosd(Re./R);

figure(1);plot(R, theta);

P = 2*pi*sqrt(R.^3 /(4e14));
T_eclipse = P.*theta/360;
figure(2);plot(R/1000, T_eclipse); xlabel("Radius of the orbit in km"); ylabel("Duration of the eclipse in seconds");