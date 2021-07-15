classdef Satellite
   properties
      mass
      x
      y
      vx
      vy
      ax
      ay
   end
   methods
      function obj = Satellite()
         obj.mass = 100;
         
         obj.x = 0;
         obj.y = 0;
         
         obj.vx = 0;
         obj.vy = 0;
         
         obj.ax = 0;
         obj.ay = 0;
         
      end       
      function r = radius(obj)
         r = sqrt(obj.x^2 + obj.y^2);
      end
      function r = speed(obj)
         r = sqrt(obj.vx^2 + obj.vy^2);
      end
   end
end