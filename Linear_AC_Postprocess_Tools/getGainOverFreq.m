clear;
row_AUT_start = 1;
row_AUT_end = 243;
row_Standard_start = 1;
row_Standard_end = 243;
Standard_S21 = 'standard.csv';
Standard_path = 'standardGain.csv';
save_folder = 'result';
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/verti_co';
v_xp_path = 'vertical_crosspo/verti_cross';

Standard_file = dlmread(Standard_path);
Standard_file = sortrows(Standard_file);

func_getS21(row_AUT_start,row_AUT_end,h_cp_path,h_xp_path,v_cp_path,v_xp_path, 0, 1);

AUT_hcp_path = 'h_copol.csv';
AUT_hxp_path = 'h_xpol.csv';
AUT_vcp_path = 'v_copol.csv';
AUT_vxp_path = 'v_xpol.csv';

hcp = zeros(row_AUT_end-row_AUT_start,2);
hxp = zeros(row_AUT_end-row_AUT_start,2);
vcp = zeros(row_AUT_end-row_AUT_start,2);
vxp = zeros(row_AUT_end-row_AUT_start,2);
freq = zeros(row_AUT_end-row_AUT_start,1);

if (row_AUT_end-row_AUT_start) == (row_Standard_end-row_Standard_start)
    for row_AUT = row_AUT_start:row_AUT_end
        row_Standard = row_AUT - row_AUT_start + row_Standard_start;
        standard = dlmread(Standard_S21, ',', [row_Standard-1 1 row_Standard-1 1]);
        freq(row_AUT-row_AUT_start+1,2) = dlmread(AUT_vxp_path, ',', [row_AUT-row_AUT_start 0 row_AUT-row_AUT_start 0]);
        Standard_Gain = 0;
        for pt = 1:length(Standard_file)
            if freq(row_AUT-row_AUT_start+1,2)/1e9 >= Standard_file(pt,1)
                Standard_Gain = Standard_file(pt,2);
            end
        end
        hcp(row_AUT-row_AUT_start+1,2) = dlmread(AUT_hcp_path, ',', [row_AUT-row_AUT_start 1 row_AUT-row_AUT_start 1])-standard+Standard_Gain;
        hxp(row_AUT-row_AUT_start+1,2) = dlmread(AUT_hxp_path, ',', [row_AUT-row_AUT_start 1 row_AUT-row_AUT_start 1])-standard+Standard_Gain;
        vcp(row_AUT-row_AUT_start+1,2) = dlmread(AUT_vcp_path, ',', [row_AUT-row_AUT_start 1 row_AUT-row_AUT_start 1])-standard+Standard_Gain;
        vxp(row_AUT-row_AUT_start+1,2) = dlmread(AUT_vxp_path, ',', [row_AUT-row_AUT_start 1 row_AUT-row_AUT_start 1])-standard+Standard_Gain;
    end
    hcp(:,1) = freq(:,2);
    hxp(:,1) = freq(:,2);
    vcp(:,1) = freq(:,2);
    vxp(:,1) = freq(:,2);
    
    subplot(2,2,1);
    plot(hcp(:,1)/1e9,hcp(:,2));
    subtitle('HP-Co Pol');
    subplot(2,2,2);
    plot(hxp(:,1)/1e9,hxp(:,2));
    subtitle('HP-X Pol');
    subplot(2,2,3);
    plot(vcp(:,1)/1e9,vcp(:,2));
    subtitle('VP-Co Pol');
    subplot(2,2,4);
    plot(vxp(:,1)/1e9,vxp(:,2));
    subtitle('VP-X Pol');
    
    mkdir(save_folder);
    writematrix(hcp,[save_folder,'/hcp.csv']);
    writematrix(hxp,[save_folder,'/hxp.csv']);
    writematrix(vcp,[save_folder,'/vcp.csv']);
    writematrix(vxp,[save_folder,'/vxp.csv']);
else
    disp('Error: Different size of S21.');
end