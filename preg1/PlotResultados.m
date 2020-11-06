%% SCA GRUPO A
% MAMANI HUANCA JHOEL RENÉ

% ******************************************************
%% LABORATORIO 2 (COMP. PREG 01)
% ******************************************************

%% MOSTRAR RESULTADOS
R = dlmread('datos.txt');

figure(1)
plot(R(:,1))
xlabel('N adaptative samples ODE45')
ylabel('Tiempo (s)')
title('Vector tiempo Vs Muestras')


figure(2)
plot(R(:,1),R(:,1))
xlabel('Tiempo (s)')
ylabel('Tiempo (s)')
title('vector tiempo vs vector tiempo')

figure(4)
plot(R(:,1),R(:,2),R(:,1),R(:,3),R(:,1),R(:,4))
xlabel('Tiempo (s)')
ylabel('Amplitud')
legend('u','x')
title('u y x (k = 1000)')
