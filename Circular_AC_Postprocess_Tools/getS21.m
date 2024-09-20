clear;
beginrow= 301;
endrow = 401;
h_cp_path = 'shoulder_R_crosspo_2/shoulder_R_crosspo_v2_';
h_xp_path = 'shoulder_R_copo_2/shoulder_R_copo_v2_';
v_cp_path = 'shoulder_R_copo/shoulder_R_copo';
v_xp_path = 'shoulder_R_crosspo/shoulder_R_cross';

s21_h_cp = zeros(endrow-beginrow+1,2);
s21_h_xp = zeros(endrow-beginrow+1,2);
s21_v_cp = zeros(endrow-beginrow+1,2);
s21_v_xp = zeros(endrow-beginrow+1,2);

for row = 1:endrow-beginrow+1
    path = [h_cp_path, num2str(row+beginrow-1),'.txt'];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, h_cp_path, 'temp_hcp.csv');
    s21_h_cp(row,1) = freq;
    s21_h_cp(row,2) = maxx_dB;
    s21_h_cp(row,3) = maxx_linear;
end
writematrix(s21_h_cp, 'h_copol.csv');

for row = 1:endrow-beginrow+1
    path = [v_cp_path, num2str(row+beginrow-1),'.txt'];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, v_cp_path, 'temp_vcp.csv');
    s21_v_cp(row,1) = freq;
    s21_v_cp(row,2) = maxx_dB;
    s21_v_cp(row,3) = maxx_linear;
end
writematrix(s21_v_cp, 'v_copol.csv');

for row = 1:endrow-beginrow+1
    path = [h_xp_path, num2str(row+beginrow-1),'.txt'];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, h_xp_path, 'temp_hxp.csv');
    s21_h_xp(row,1) = freq;
    s21_h_xp(row,2) = maxx_dB;
    s21_h_xp(row,3) = maxx_linear;
end
writematrix(s21_h_xp, 'h_xpol.csv');

for row = 1:endrow-beginrow+1
    path = [v_xp_path, num2str(row+beginrow-1),'.txt'];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, v_xp_path, 'temp_vxp.csv');
    s21_v_xp(row,1) = freq;
    s21_v_xp(row,2) = maxx_dB;
    s21_v_xp(row,3) = maxx_linear;
end
writematrix(s21_v_xp, 'v_xpol.csv');