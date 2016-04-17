function bytecount = exportToOpenSim(tout,x,fileName,motionName)
%% Create Combined Motion Matrix
motB = zeros(size(tout,1),14);
motB(:,1) = tout;
motB(:,8) = x(:,1);
motB(:,9) = 90;
motB(:,11) = x(:,2);
%% Create File & Print
fileID = fopen(fileName,'a');
bytecount = fprintf(fileID,['' motionName '\n' ...
    'nRows=%d \nnColumns=14 \nendheader \ntime \t r_x \t r_y \t r_z \t t_x \t' ...
    't_y \t t_z \t elv_angle \t shoulder_elv \t shoulder_rot \t elbow_flexion ' ...
    '\t pro_sup \t deviation \t flexion \n'],size(tout,1));
for i = 1:size(tout,1)
    bytecount = bytecount + fprintf(fileID, ...
        ['%4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %4.4f %6.6f %4.4f %4.4f  ' ...
        '%6.6f %4.4f %4.4f %4.4f \n'],motB(i,:));
end
fclose(fileID);