%% Preamble
close all

%% Check Moments of Inertia
% load data
mEFlex
mSAbb
% Shoulder
figure
hold on
plot(x(:,1),squeeze(rho(38,1,:)))
plot(momentDataShoulder(:,2),momentDataShoulder(:,40))
legend('Simulink', 'OpenSim')
title('rhoS PEC2')
xlabel('qs (deg)')
ylabel('rhoS')
% Elbow
figure
hold on
plot(x(:,2),squeeze(rho(6,2,:)))
plot(momentDataElbow(:,2),momentDataElbow(:,8))
legend('Simulink', 'OpenSim')
title('rhoE BRD')
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
% Shoulder
% TODO: CURRENTLY FAILING, FIX
figure
hold on
plot(x(:,1),lambda(:,38))
plot(fiberLenElevAngle(:,2),fiberLenElevAngle(:,40))
legend('Simulink', 'OpenSim')
title('Fiber Length PEC2')
xlabel('qs (deg)')
ylabel('fLen (m)')
% Elbow
figure
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
%% Check lambdaDot
% CURRENTLY BROKEN
figure
hold on
plot(tout,squeeze(ldot(6,2,:)).*x(:,4)/180*pi)
plot(tout,lambdaDot(:,6))
legend('ldot (Curve-Fit)', 'lambdaDot (Jmu*qdot)')
xlabel('time (sec)')
ylabel('lengthening rate (m/s)')
title('BRD Lengthening Rate')
figure
hold on
plot(tout,squeeze(ldot(38,1,:)).*x(:,3)/180*pi)
plot(tout,lambdaDot(:,38))
legend('ldot (Curve-Fit)', 'lambdaDot (Jmu*qdot)')
xlabel('time (sec)')
ylabel('lengthening rate (m/s)')
title('PEC2 Lengthening Rate')
%% Check Fiber Lengths vs Time
figure 
hold on
plot(tout,lambda(:,38))
plot(tout,lambda(:,6))
title('FLen vs time')
legend('PEC2','BRD')
xlabel('time (sec)')
ylabel('length (m)')