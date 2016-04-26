%% Preamble
close all
%% Basics
figure
subplot(1,3,1)
hold on
plot(xe,ye)
title('Endpoint Effector Location Relative to Shoulder')
xlabel('x (m)')
ylabel('y (m)')
subplot(1,3,2)
hold on
plot(tout, x(:,1))
plot(tout, x(:,2))
legend('Shoulder', 'Elbow', 'location', 'best')
title('Angles vs Time')
xlabel('time (sec)')
ylabel('Angle (degrees)')
subplot(1,3,3)
hold on
plot(tout, tauM(:,1))
plot(tout, tauM(:,2))
legend('Shoulder', 'Elbow', 'location', 'best')
title('Torques vs Time')
xlabel('time (sec)')
ylabel('Torque (N*m)')

%% Check Moments of Inertia
% load data
mEFlex
mSAbb
figure
% Shoulder - Smooth
subplot(2,2,1)
hold on
plot(x(:,1),squeeze(rho(38,1,:)))
plot(momentDataShoulder(:,2),momentDataShoulder(:,40))
legend('Simulink', 'OpenSim')
title('rhoS PEC2 (Smooth)')
xlabel('qs (deg)')
ylabel('rhoS')
% Shoulder - Sharp
subplot(2,2,2)
hold on
plot(x(:,1),squeeze(rho(35,1,:)))
plot(momentDataShoulder(:,2),momentDataShoulder(:,37))
legend('Simulink', 'OpenSim')
title('rhoS LAT2 (Sharp)')
xlabel('qs (deg)')
ylabel('rhoS')
% Elbow - Smooth
subplot(2,2,3)
hold on
plot(x(:,2),squeeze(rho(6,2,:)))
plot(momentDataElbow(:,2),momentDataElbow(:,8))
legend('Simulink', 'OpenSim')
title('rhoE BRD (Smooth)')
xlabel('qe (deg)')
ylabel('rhoE')
%% Check ALL Rho
figure
hold on
for ang = 1:2
    subplot(2,1,ang)
    hold on
    for i = 1:50
        plot(tout,squeeze(rho(i,ang,:)))
    end 
end

%% Check Muscle Lengths 
% load data
flenElevAngl
flenElboFlex
figure
% Shoulder - Smooth
subplot(2,2,1)
hold on
plot(x(:,1),lambda(:,38))
plot(fiberLenElevAngle(:,2),fiberLenElevAngle(:,40))
legend('Simulink', 'OpenSim')
title('Fiber Length PEC2')
xlabel('qs (deg)')
ylabel('fLen (m)')
% Shoulder - Sharp
% TODO: CURRENTLY FAILING, FIX
subplot(2,2,2)
hold on
plot(x(:,1),lambda(:,35))
plot(fiberLenElevAngle(:,2),fiberLenElevAngle(:,37))
legend('Simulink', 'OpenSim')
title('Fiber Length LAT2')
xlabel('qs (deg)')
ylabel('fLen (m)')
% Elbow
subplot(2,2,3)
hold on
plot(x(:,2),lambda(:,6))
plot(fiberLenElboFlex(:,2),fiberLenElboFlex(:,8))
legend('Simulink', 'OpenSim')
title('Fiber Length BRD')
xlabel('qe (deg)')
ylabel('fLen (m)')
%% Check Jmu
figure
hold on
plot(tout, squeeze(Jmu(6,2,:)))
plot(tout, -1*squeeze(rho(6,2,:)))
legend('Jmu', '-1*Rho')
title('Jmu vs Rho BRD')
xlabel('t (sec)')
ylabel('moment')
figure
hold on
plot(tout, squeeze(Jmu(38,1,:)))
plot(tout, squeeze(rho(38,1,:)))
legend('Jmu', 'Rho')
title('Jmu vs Rho PEC2')
xlabel('t (sec)')
ylabel('moment')
%% Check Fiber Lengths vs Time
figure 
hold on
plot(tout,lambda(:,38))
plot(tout,lambda(:,35))
plot(tout,lambda(:,6))
title('FLen vs time')
legend('PEC2','LAT2','BRD')
xlabel('time (sec)')
ylabel('length (m)')
%% Check FV and FL
figure
hold on
plot(tout,fl(:,6))
plot(tout,fv(:,6))
plot(tout,fl(:,35))
plot(tout,fv(:,35))
plot(tout,fl(:,38))
plot(tout,fv(:,38))
plot(tout,fl(:,49))
plot(tout,fv(:,49))
title('FV,FL vs t')
legend('FL(BRD)','FV(BRD)','FL(LAT2)','FV(LAT2','FL(PEC2)','FV(PEC2)','FL(TRIlong)','FV(TRIlong)','location','best')
xlabel('time (sec)')
ylabel('scaling factor')
%% Check Rho(t)
figure
hold on
plot(tout, -1*squeeze(rho(6,2,:)))
plot(tout, -1*squeeze(rho(35,1,:)))
plot(tout, -1*squeeze(rho(37,1,:)))
legend('BRD','LAT2','PEC2')
xlabel('time (sec)')
ylabel('moment arm (m)')
title('Rho(t) evolution')
%% Curl Analysis
figure
subplot(2,2,1)
hold on
plot(tout,u(:,6),'k')
plot(tout,u(:,49),'r')
legend('BRD','TRIlong','location','best')
xlabel('Time (sec)')
ylabel('Activation Level')
title('Input Activations')
subplot(2,2,3)
hold on
plot(tout,x(:,1))
plot(tout,x(:,2))
legend('Shoulder','Elbow','location','best')
xlabel('Time (sec)')
ylabel('Angle (deg)')
title('Joint Movement')
subplot(2,2,2)
hold on
plot(tout,lambda(:,49),'r')
plot(tout,lambda(:,6),'k')
title('Muscle Length vs Time')
legend('TRIlong','BRD','location','best')
xlabel('time (sec)')
ylabel('length (m)')
subplot(2,2,4)
hold on
plot(tout,fl(:,6),':k')
plot(tout,fv(:,6),'k')
plot(tout,fl(:,49),':r')
plot(tout,fv(:,49),'r')
title('FV,FL vs t')
legend('FL(BRD)','FV(BRD)','FL(TRIlong)','FV(TRIlong)','location','best')
xlabel('time (sec)')
ylabel('scaling factor')
%% TestPec2
% setPTPEC2
% sim('plant')
figure
subplot(2,2,1)
hold on
plot(tout,u(:,38),'k')
legend('PECM2','location','best')
xlabel('Time (sec)')
ylabel('Activation Level')
title('Input Activations')
subplot(2,2,3)
hold on
plot(tout,x(:,1))
plot(tout,x(:,2))
legend('Shoulder','Elbow','location','best')
xlabel('Time (sec)')
ylabel('Angle (deg)')
title('Joint Movement')
subplot(2,2,2)
hold on
plot(tout,tauM(:,1))
plot(tout,squeeze(tauM(:,2)))
legend('Shoulder','Elbow','location','best')
xlabel('Time (sec)')
ylabel('Torque (N*m)')
title('Joint Torque')
%% Test Calcium Dynamics:
figure
plot(tout,u(:,1))
hold on
plot(tout,a(:,1))
legend('u','a','location','best')
xlabel('Time (sec)')
ylabel('Amplitude')
title('u vs a on Anc')