%%
clc
clearvars
clear

degree=11; %one more than the moment fits
pow = degree:-1:1;
%% Construct ldotS
flenElevAngl
ldotS = zeros(50,degree);
ang = fiberLenElevAngle(:,2);
for i= 3:52
    %i = 3;
    fl = fiberLenElevAngle(:,i);
    z = polyfit(ang,fl,degree);
    z = z(1:end-1);
    ldotS(i-2,:) = z.*pow;
end

%% Construct ldotE
flenElboFlex
ldotE = zeros(50,degree);
ang = fiberLenElboFlex(:,2);
for i= 3:52
    %i = 3;
    fl = fiberLenElboFlex(:,i);
    z = polyfit(ang,fl,degree);
    z = z(1:end-1);
    ldotE(i-2,:) = z.*pow;
end