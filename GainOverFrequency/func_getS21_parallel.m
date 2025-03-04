function [resfreq,s21_db,s21_linear,rows] = ...
    func_getS21_parallel(beginrow, endrow, h_cp_path, h_xp_path, v_cp_path, ...
    v_xp_path, forPolar, forGain, save_folder)

if ~isempty(save_folder)
    if ~endsWith(save_folder,'\') && ~endsWith(save_folder,'/')
        save_folder = [save_folder,'\'];
    end
end
if ~exist(save_folder)
    mkdir(save_folder)
end

paths = {h_cp_path,h_xp_path,v_cp_path,v_xp_path};

rows = zeros(1,4);
resfreq = zeros(endrow-beginrow+1,4);
s21_db = zeros(endrow-beginrow+1,4);
s21_linear = zeros(endrow-beginrow+1,4);
progressBars = zeros(1, 4); % 进度存储数组
D = parallel.pool.DataQueue;
afterEach(D, @(data) updateProgressBar(data, 4, progressBars));

% 预先打印空行创建进度条空间
for i = 1:4
    fprintf(repmat(' ', 1, 39));
end

parfor i=1:4
    Gainsavename = {'h_copol.csv','v_copol.csv','h_xpol.csv','v_xpol.csv'};
    Polarsavename = {'temp_hcp.csv','temp_vcp.csv','temp_hxp.csv','temp_vxp.csv'};
    s21_current_plane = zeros(endrow-beginrow+1,2);
    if ~isempty(paths{i})
        pth = split(paths{i},'.');
        if strcmp(pth{end},'csv')
            dt = readtable(paths{i});
            s21_current_plane = table2array(dt);
        else
            for row = 1:endrow-beginrow+1
                temppath = '';
                if forPolar
                    temppath = [save_folder,Polarsavename{i}];
                end
                [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
                    func_getFarfield(row+beginrow-1, paths{i}, temppath);
                s21_current_plane(row,1) = freq;
                s21_current_plane(row,2) = maxx_dB;
                s21_current_plane(row,3) = maxx_linear;
                send(D, [i,row,(endrow-beginrow+1)]);
            end
        end
        if forGain
            writematrix(s21_current_plane, [save_folder,Gainsavename{i}]);
        end
        rows(i) = endrow-beginrow+1;
        resfreq(:,i) = s21_current_plane(:,1);
        s21_db(:,i) = s21_current_plane(:,2);
        s21_linear(:,i) = s21_current_plane(:,3);
    else
        send(D, [i,1,1]);
    end
end

fprintf('\n All Completed!\n');
