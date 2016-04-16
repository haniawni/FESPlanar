%%
clc
clearvars
clear all

%% Construct rhoE
mEFlex
degree=10;
rhoECoeffs = zeros(50,degree+1);
ang = momentDataElbow(:,2);
for i= 3:52
    %i = 3;
    m = momentDataElbow(:,i);
    z = polyfit(ang,m,degree);
    rhoECoeffs(i-2,:) = z;
end

%% Construct rhoS
mSAbb
degree=10;
rhoSCoeffs = zeros(50,degree+1);
ang = momentDataShoulder(:,2);
for i= 3:52
    %i = 3;
    m = momentDataShoulder(:,i);
    z = polyfit(ang,m,degree);
    rhoSCoeffs(i-2,:) = z;
end