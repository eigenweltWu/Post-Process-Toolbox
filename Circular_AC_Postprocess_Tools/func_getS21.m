function func_getS21(beginrow, endrow, h_cp_path, h_xp_path, v_cp_path, ...
    v_xp_path, forPolar, forGain)

s21_h_cp = zeros(endrow-beginrow+1,2);
s21_h_xp = zeros(endrow-beginrow+1,2);
s21_v_cp = zeros(endrow-beginrow+1,2);
s21_v_xp = zeros(endrow-beginrow+1,2);

for row = 1:endrow-beginrow+1
    path = [h_cp_path,':',num2str(row+beginrow-1)];
    disp(['Processing ',path]);
    temppath = '';
    if forPolar
        temppath = 'temp_hcp.csv';
    end
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, h_cp_path, temppath);
    s21_h_cp(row,1) = freq;
    s21_h_cp(row,2) = maxx_dB;
    s21_h_cp(row,3) = maxx_linear;
end
if forGain
    writematrix(s21_h_cp, 'h_copol.csv');
end

for row = 1:endrow-beginrow+1
    path = [v_cp_path, num2str(row+beginrow-1),'.txt'];
    disp(['Processing ',path]);
    temppath = '';
    if forPolar
        temppath = 'temp_vcp.csv';
    end
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, v_cp_path, temppath);
    s21_v_cp(row,1) = freq;
    s21_v_cp(row,2) = maxx_dB;
    s21_v_cp(row,3) = maxx_linear;
end
if forGain
    writematrix(s21_v_cp, 'v_copol.csv');
end

for row = 1:endrow-beginrow+1
    path = [h_xp_path, num2str(row+beginrow-1),'.txt'];
    disp(['Processing ',path]);
    temppath = '';
    if forPolar
        temppath = 'temp_hxp.csv';
    end
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, h_xp_path, temppath);
    s21_h_xp(row,1) = freq;
    s21_h_xp(row,2) = maxx_dB;
    s21_h_xp(row,3) = maxx_linear;
end
if forGain
    writematrix(s21_h_xp, 'h_xpol.csv');
end

for row = 1:endrow-beginrow+1
    path = [v_xp_path, num2str(row+beginrow-1),'.txt'];
    disp(['Processing ',path]);
    temppath = '';
    if forPolar
        temppath = 'temp_vxp.csv';
    end
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, v_xp_path, temppath);
    s21_v_xp(row,1) = freq;
    s21_v_xp(row,2) = maxx_dB;
    s21_v_xp(row,3) = maxx_linear;
end
if forGain
    writematrix(s21_v_xp, 'v_xpol.csv');
end
