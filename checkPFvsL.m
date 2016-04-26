clearvars

optimalLambda = [[0.027];[0.0713];[0.1157];[0.1321];[0.0858];[0.1726]; ...
    [0.0932];[0.0976];[0.1078];[0.1367];[0.0585];[0.081];[0.0622];[0.07]; ...
    [0.065];[0.0724];[0.0626];[0.0675];[0.0589];[0.0675];[0.054];[0.0628]; ...
    [0.0509];[0.0749];[0.0749];[0.0835];[0.0798];[0.0835];[0.0515];[0.0749]; ...
    [0.0736];[0.0552];[0.0755];[0.254];[0.2324];[0.2789];[0.1442];[0.1385]; ...
    [0.1385];[0.0638];[0.0282];[0.0492];[0.0873];[0.033];[0.0682];[0.1624]; ...
    [0.0741];[0.1138];[0.134];[0.1138]];

%% Plot Elbow Force vs Length
flenElboFlex
pFElbow
figure
hold on
for n = 1:50
    plot(fiberLenElboFlex(:,n+2)/optimalLambda(n,1),pForceElbow(:,n+2))
end
xlabel('Length (L_o)')
ylabel('Force')
title('Passive Force vs Muscle Length (Elbow)')

%% Plot Shoulder Force Vs Length

flenElevAngl
pFShoulder
figure
hold on
for n = 1:50
    plot(fiberLenElevAngle(:,n+2)/optimalLambda(n,1),pForceShoulder(:,n+2))
end
xlabel('Length (L_o)')
ylabel('Force')
title('Passive Force vs Muscle Length (Shoulder)')

%% Create Curve-fitting Datasets
cutoff = 1.01;
% Elbow
dElbow = zeros(100*50,2);
for n = 1:50
    start = 100*(n-1)+1;
    last = start + 100 - 1;
    dElbow(start:last,1) = fiberLenElboFlex(:,n+2)/optimalLambda(n,1);
    dElbow(start:last,2) = pForceElbow(:,n+2);
end

dElbowP = dElbow(find(dElbow(:,1) > cutoff),:);
% Shoulder
dShoulder = zeros(100*50,2);
for n = 1:50
    start = 100*(n-1)+1;
    last = start + 100 - 1;
    dShoulder(start:last,1) = fiberLenElevAngle(:,n+2)/optimalLambda(n,1);
    dShoulder(start:last,2) = pForceShoulder(:,n+2);
end

dShoulderP = dShoulder(find(dShoulder(:,1) > cutoff),:);
% UNIFICATION
da = [dElbow ; dShoulder];
d = [dElbowP ; dShoulderP];
%% Create Parameterization
% Based off Brown et al 1999
% x(1) = c1;
% x(2) = k1;
% x(3) = Lr1; 
F = @(x,xdata)x(1)*x(2)*(exp((xdata - x(3))/x(2)) + 1);
x0 = [mean([25.6,31.8,69.6]),mean([0.059,0.046,0.058]),mean([1.54,1.34,1.50])];

FLog = @(x,xdata)x(1)*x(2)*log(exp((xdata - x(3))/x(2)) + 1);

options = optimoptions('lsqcurvefit','MaxFunEvals',10^5); 
[x,resnorm,~,exitflag,output] = lsqcurvefit(F,x0,da(:,1),da(:,2),[],[],options)
[xlog,resnorm,~,exitflag,output] = lsqcurvefit(FLog,x0,da(:,1),da(:,2),[],[],options)

% Plotting
r = 0.2:0.02:1.65;
figure
hold on
plot(da(:,1),da(:,2),'.')
xlabel('Length (L_o)')
ylabel('Force')
title('Passive Force vs Muscle Length (All Muscles, Joints)')
plot(r,F(x,r),'k--','LineWidth',2)
plot(r,F(x0,r),'r--','LineWidth',2)
plot(r,FLog(xlog,r),'k-.','LineWidth',1)
plot(r,FLog(x0,r),'r-.','LineWidth',1)
legend('OpenSim data','my fit (no log)','Brown 1999 (no log)','my fit (log)','Brown 1999 (log)','location','best')


%% Prep Data for Saving

FP_c  = x(1,1);
FP_k  = x(1,2);
FP_lr = x(1,3);
