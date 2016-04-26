%% Test Pec2
set_param('plant/LockShoulder', 'sw', '0') % Lock Shoulder
set_param('plant/LockElbow', 'sw', '1') % Unlock Elbow
set_param('plant/BalanceShoulderTorque','sw','0')
set_param('plant/BalanceElbowTorque','sw','1')
set_param('plant/testmu', 'sw', '1') % Disable Mu Testing
set_param('plant/testtauM', 'sw', '1') % Disable TauM Testing
prerunScript
uBRD_a = 0;
uBRD_f = pi/10*3;
uBRD_p = 0;
uBRD_b = 0;
uPEC2_a = 1;
uPEC2_f = 2*pi/10;
uPEC2_p = 0;
uPEC2_b = 0;
uTRIlong_a = 0;
uTRIlong_f = pi/10*3;
uTRIlong_p = pi;
uTRIlong_b = 0;