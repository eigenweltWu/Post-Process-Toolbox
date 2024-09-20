clear;
beginrow= 1;
endrow = 100;
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/vertical_co';
v_xp_path = 'vertical_crosspo/vertical_cross';

s21_h_cp = zeros(endrow-beginrow+1,2);
s21_h_xp = zeros(endrow-beginrow+1,2);
s21_v_cp = zeros(endrow-beginrow+1,2);
s21_v_xp = zeros(endrow-beginrow+1,2);

for row = 1:endrow-beginrow+1
    path = [h_cp_path, ':', num2str(row+beginrow-1)];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, h_cp_path, 'temp_hcp.csv');
    s21_h_cp(row,1) = freq;
    s21_h_cp(row,2) = maxx_dB;
    s21_h_cp(row,3) = maxx_linear;
end
writematrix(s21_h_cp, 'h_copol.csv');

for row = 1:endrow-beginrow+1
    path = [v_cp_path, ':', num2str(row+beginrow-1)];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, v_cp_path, 'temp_vcp.csv');
    s21_v_cp(row,1) = freq;
    s21_v_cp(row,2) = maxx_dB;
    s21_v_cp(row,3) = maxx_linear;
end
writematrix(s21_v_cp, 'v_copol.csv');

for row = 1:endrow-beginrow+1
    path = [h_xp_path, ':', num2str(row+beginrow-1)];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, h_xp_path, 'temp_hxp.csv');
    s21_h_xp(row,1) = freq;
    s21_h_xp(row,2) = maxx_dB;
    s21_h_xp(row,3) = maxx_linear;
end
writematrix(s21_h_xp, 'h_xpol.csv');

for row = 1:endrow-beginrow+1
    path = [v_xp_path, ':', num2str(row+beginrow-1)];
    disp(['Processing ',path]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, v_xp_path, 'temp_vxp.csv');
    s21_v_xp(row,1) = freq;
    s21_v_xp(row,2) = maxx_dB;
    s21_v_xp(row,3) = maxx_linear;
end
writematrix(s21_v_xp, 'v_xpol.csv');
