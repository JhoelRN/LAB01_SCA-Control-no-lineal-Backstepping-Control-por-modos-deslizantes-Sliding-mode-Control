%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LABORATORIO 02 - SCA
% MAMANI HUANCA, JHOEL RENE
% VILCAPAZA GOYZUETA, DENILSON 
% [PREGUNTA 02] : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function item2()
clear all; close all; clc;
to = 0; tf = 60;             % rango 
t = linspace(to,tf,200); 
xo = [-8,10];                % condiciones iniciales

global fileID
fileID = fopen('datosP2.txt','w');
options1 = odeset('RelTol',0.01);

%ode23 
[t,x] = ode23(@(t,x)nonlinear(t,x),t,xo,options1);
% [T,Y] = ode45(@(t,x) test(t,y,b), tspan, y0);  % One command removed 
fclose(fileID);

xlabel('Tiempo (s)'); ylabel('Amplitud'); title('Respuesta en tiempo [PREGUNTA 2]')
hold on
plot(t,x(:,1))
plot(t,x(:,2))
legend('x1','x2');
grid




%%%%%%%%%%%%%%%%%%%%% SLIDING MODE CONTROL %%%%%%%%%%%%%%%%%%%%%
function [xdot] = nonlinear(t,x)
  global fileID
  
  a = 1;                
  w = pi/2;                           % frecuencia
  lambda = 10;  n = 6;                % eta
  
  Xd = 2*sin(w*t);                    % X deseado (Xd) (senoidal)
  dXd = 2*w*cos(w*t);                 % 1ra deriv de X deseado
  ddXd = -2*w^2*sin(w*t);             % 2da deriv de X deseado
  
  F = 1.99*cos(x(1))*x(2);
  
  K = F+n;                            % k es una grandeza
  s = x(2)-dXd + lambda*(x(1)-Xd);    % superficie deslizante 2do orden
  
  
  fe = x(2)+cos(x(1))*x(2);           % f nominal estimado
  ue = -fe+ddXd-lambda*(x(2)-dXd);    % ue u estimado
  
  %Ley de Control
  u = ue-K*sign(s);
  
  xdot = [x(2);x(2)+a*cos(x(1))*x(2)+u];
  
  fprintf(fileID, '%10.6f %10.6f %10.6f %10.6f \n',t,u,x(1),x(2));
endfunction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%









##%%%%%%%%%%%%%%%%%%%%% SLIDING MODE CONTROL %%%%%%%%%%%%%%%%%%%%%
##function [xdot] = nonlinear(t,x)
##  global fileID
##  
##  c = 1.5;                
##  w = pi/2;                           % frecuencia
##  lambda = 15;  n = 6;                 % eta
##  
##  Xd = 2*sin(w*t);                    % X deseado (Xd) (senoidal)
##  dXd = 2*w*cos(w*t);                 % 1ra deriv de X deseado
##  ddXd = -2*w^2*sin(w*t);             % 2da deriv de X deseado
##  
##  
##  F = 0.5*x(2)^2*cos(3*x(1));         % Funcion conocida F = (x,x•)
##  K = F+n;                            % k es una grandeza
##  s = x(2)-dXd + lambda*(x(1)-Xd);    % superficie deslizante 2do orden
##  
##  
##  fe = 1.5*(x(2))^2*cos(3*x(1));      % f nominal estimado
##  ue = -fe+ddXd-lambda*(x(2)-dXd);    % ue u estimado
##  
##  %Contrl
##  u = ue-K*sign(s);
##  
##  xdot = [x(2);c*(x(2))^2*cos(3*x(1))+u];
##  
##  fprintf(fileID, '%10.6f %10.6f %10.6f %10.6f \n',t,u,x(1),x(2));
##endfunction
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

endfunction




##%%%%%%%%%%%%%%%%%%% BACKSTEPPING CONTROL %%%%%%%%%%%%%%%%%%%%%
##function [xdot] = nonlinear(t,x)
##  % non linear model to integrate with ode45
##  % parameters
##  % deslizante control
## 
##global fileID
##% 
##
##
##a = 1;
##k = 1;
##
##% backstepping control law
##u = (-2-a*cos(x(1))) * (x(1)+a*sin(x(1))+x(2)) - x(1)-k*(x(2)+2*x(1)+a*sin(x(1)));
##
##
##
##% model dynamics
##xdot = [x(1)+a*sin(x(1))+x(2);
##        u];
##
##fprintf(fileID, '%10.6f %10.6f %10.6f %10.6f \n',t,u,x(1),x(2));
## 
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

