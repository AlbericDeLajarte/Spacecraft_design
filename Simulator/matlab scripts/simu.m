function [x,y] = simu(Te, N)

    Msub = 1e4;

    uE = 3.986004418e14;
    gE = 9.81;
    
    Impulse = 4190;
    Tr = 2*236e-3;
    %Tr = 0;
    deltaM = Tr/(gE*Impulse)*Te;
    
    x = zeros(1, round(N/Msub));
    y = zeros(1, round(N/Msub));
    
    s = Satellite();
    s.mass = 380;
    s.x = 0; s.y = (6371+1500)*1e3;
    s.vx = 7.117e3; s.vy = 0;

%     M = Satellite(N);
%     M.mass = 7.342e22;
%     M.x(1) = 0; M.y(1) = -384402e3;
%     M.vx(1) = 1.018422e3; M.vy(1) = 0;

    x(1) = s.x;
    y(1) = s.y;
    k = 0;

    for i = 1:N-1
        
        r = s.radius;
        P = uE/r^3;

        if(s.y>6371e3)   
            Thrust = Tr/(r*s.mass);
            s.ax = -s.x* P + s.y *Thrust;
            s.ay = -s.y* P - s.x *Thrust;
            
            s.mass = s.mass - deltaM;
    
        else
            s.ax = -s.x* P;
            s.ay = -s.y* P;
        end

        s.vx = s.vx + s.ax*Te;
        s.vy = s.vy + s.ay*Te;

        s.x = s.x + s.vx*Te + 0.5*s.ax*Te^2;
        s.y = s.y + s.vy*Te + 0.5*s.ay*Te^2;
        
   
        if(~mod(i,Msub))
            k = k+1;
            x(k) = s.x;
            y(k) = s.y;
        end
        

    %     P = uE*M.mass/(M.radius(i)^2*M.mass);
    %     M.ax(i+1) = (-M.x(i)/M.radius(i) * P);
    %     M.ay(i+1) = -M.y(i)/M.radius(i) * P;
    %     
    %     M.vx(i+1) = M.vx(i) + M.ax(i)*Te;
    %     M.vy(i+1) = M.vy(i) + M.ay(i)*Te;
    %     
    %     M.x(i+1) = M.x(i) + M.vx(i)*Te + 0.5*s.ax(i)*Te^2;
    %     M.y(i+1) = M.y(i) + M.vy(i)*Te + 0.5*s.ay(i)*Te^2;

    end
    x(end) = s.x;
    y(end) = s.y;
    s.mass
end