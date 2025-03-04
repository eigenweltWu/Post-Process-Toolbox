clear;
row_AUT_start = 429;
row_AUT_end = 788;

store_plane_gain = 1; % 是否储存面结果
standard = -22; % 标准增益天线接收强度
Standard_Gain = 14; % 标准增益天线标称增益
Standard_path = 'standardGain.csv'; % 此处填写将覆盖Standard_Gain
%Standard_path = '';

save_folder = '2.6-3.95';
save_name = 'Gain.csv';
h_cp_path = '../2.6-3.95/EP-HPOL/mea';
h_xp_path = '../2.6-3.95/EP-VPOL/mea';
v_cp_path = '../2.6-3.95/HP-HPOL/mea';
v_xp_path = '../2.6-3.95/HP-VPOL/mea';

if ~isempty(Standard_path)
    Standard_file = dlmread(Standard_path);
    Standard_file = sortrows(Standard_file);
end

[resfreq,s21_db,s21_linear,rows] = func_getS21_parallel(row_AUT_start,row_AUT_end,...
    h_cp_path,h_xp_path,v_cp_path,v_xp_path, 0, store_plane_gain,save_folder);

if isempty(Standard_path)
    s21_db = s21_db - standard + Standard_Gain;
else
    for plane = 1:4
        Standard_Gain = 0;
        for i = 1:rows(plane)
            for pt = 1:length(Standard_file)
                 if resfreq(i,plane) >= Standard_file(pt,1)
                     Standard_Gain = Standard_file(pt,2);
                 end
            end
            s21_db(i,plane) = s21_db(i,plane) - standard + Standard_Gain;
        end
    end
end

plot(max(resfreq')/1e9,max(s21_db',[],1));
writematrix([max(resfreq')/1e9,max(s21_db',[],1)], save_name);
