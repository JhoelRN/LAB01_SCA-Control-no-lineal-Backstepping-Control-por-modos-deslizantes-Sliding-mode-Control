%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% LABORATORIO2  - Control No Lineal  - SCA
% Apellidos y Nombres: VILCAPAZA GOYZUETA DENILSON JEAN
%                       Mamani Huanca Jhoel Rene
% GRUPO: A

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function lab2_pr()
  clear all ; close all ;
  
  to = 0; % tiempo de inicio
  tf = 60; % end time
  t=linspace(to,tf,200) ;
  
  xo(1) =-20; % condidicoens iniciales
  xo(2) = 30;
  
  global a % variable global
  a=-0;   %randi([-1,2],1,1)% VARIACION PARAMETRICA DE PARTE NO LINEAL 

  
  %u = 1;
  global fileID                                     
  fileID = fopen('datos.txt','w')         %fileID identificador de archcivo
                                           % creacion de archivo modo escritura
  k=fileID
  
  options1 = odeset( 'RelTol', 0.01) % cracateristoicas de solucion numerica ODESET
  fprintf('El valor de parametro "a" es %5.2f \n', a)
  
  % X es variable
  [t,x] = ode23 (@(t,x)nonlinear ( t , x ),t ,xo,options1 ) ; %  otra forma de resolver ecu. difrenciales de primer grado
  %[T ,Y] = ode45 (@(t,y)test(t ,y ,b ) ,tspan , y0 ) ; % One comma removed
 
 fclose( fileID); % cierra el archivo creado
  
  xlabel( 'Time (s)' )
  ylabel( 'Amplitud' )
  hold on
  plot(t,x(:,1))
  plot(t,x(:,2))
  legend('x1','x2')
  title(['Parametro is ',num2str(a),' a'])
  grid
  
  figure(2)
  plot(x(:,2),x(:,1))
  xlabel('x(2)'); ylabel('x(1)');
  grid
end 
  
function [xdot] = nonlinear(t,x) % FUNCION para ODE - ya con la ley d contorl 
  global fileID                                             % Variable gloal, conocida para todas funciones
  global a

  %a=randi([-1,2],1,1)% VARIACION PARAMETRICA DE PARTE NO LINEAL 
  
  k=1;  %   k=1;  INICIAL VALUE
  
  % control backstepping ley de control
  u=((-2-a*cos(x(1)))*(x(1) + a*sin(x(1)) + x(2)) - x(1) -k*(x(2)+2*x(1)+a*sin(x(1)))); 
  
  % modelo dinamico
  xdot=[x(1)+ a*sin(x(1)) + x(2);u];
  fprintf(fileID,'%10.6f %10.6f %10.6f %10.6f \n ',t,u,x(1),x(2)); % sirve para 
                    %guradar en fileID los datos de teccer arguento en adelante

  % esta funcion esta atacando dentro alka funcion ode23 
end
  
  % Cuestionario 
  % 1. k=1000  - verificar estabiliidad y porque varia result - COMENTAR DEMOSTRACION
    
##    Segun la teoria de control backstepping cuando se proyetc la 
##    v por feedback linearization la constante k debe ser mayor a cero para garantizar 
##    la estabilidad de lyapunov, entre mas aumente k, aumentara tambien la cantidad de 
##    resultados en x2,u,x1 - 
##    en cierta manera al aumentar k podria hace un consumo de enegia al sistema contorl


  % 2. incertidumbre 1 < a < 3. verificar estabilidad y plotear - COMENTAR DEMOSTRACION
  ##  En el regimen transitorio este permanece inestable el controladroe proyectado 
##  cuando se eleva el valor de A el regimen permanten tarda en llegar, o trada en estanilizarse
 


##en este caso de puso el vaolor estimado mas no el peor de los casos, entonces si 
##varia el paraemtero a a sus peorres casos, l amnetar los valores de 
##"a" que tarara e llegar al regimen el evolucion de los estados, tamnein en refimen 
##transitorioa seve que sufre demasidas variaciones al umentar y disminuir el valor d
##"a" , lo ideal seria tomar como cero este valor, para eliminar las no linalidades

  
  % 3. Proyecte una ley de control robusta con incertidumbre en 1 < c(t) < 2 
  %     - TALVES(MODOS DESLIZANTES)- VALIDADR NUMERICAMENTE
  
  
  
  % 4. Proyecte una ley de control ADAPTATIVA robusta - VALIDADR NUMERICAMENTE
  
  
  
  
  