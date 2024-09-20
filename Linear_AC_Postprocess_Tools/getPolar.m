clear;
polarrow = 160;
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/verti_co';
v_xp_path = 'vertical_crosspo/verti_cross';
save_folder = 'polar1.7-2.6';
nr_of_angles = 180;

AUT_hcp_path = 'temp_hcp.csv';
AUT_hxp_path = 'temp_hxp.csv';
AUT_vcp_path = 'temp_vcp.csv';
AUT_vxp_path = 'temp_vxp.csv';

func_getS21(polarrow,polarrow,h_cp_path,h_xp_path,v_cp_path,v_xp_path, 1, 0);

AUT_hcp = dlmread(AUT_hcp_path, ',', [0 0 nr_of_angles-1 1]);
AUT_hxp = dlmread(AUT_hxp_path, ',', [0 0 nr_of_angles-1 1]);
AUT_vcp = dlmread(AUT_vcp_path, ',', [0 0 nr_of_angles-1 1]);
AUT_vxp = dlmread(AUT_vxp_path, ',', [0 0 nr_of_angles-1 1]);

maxx = -10000;
maxx = max(maxx,AUT_hcp(:,2));
maxx = max(maxx,AUT_hxp(:,2));
maxx = max(maxx,AUT_vcp(:,2));
maxx = max(maxx,AUT_vxp(:,2));
maxx = max(maxx);

AUT_hcp(:,2) = AUT_hcp(:,2) - maxx;
AUT_hxp(:,2) = AUT_hxp(:,2) - maxx;
AUT_vcp(:,2) = AUT_vcp(:,2) - maxx;
AUT_vxp(:,2) = AUT_vxp(:,2) - maxx;

AUT_hcp(181,1) = 360;
AUT_hxp(181,1) = 360;
AUT_vcp(181,1) = 360;
AUT_vxp(181,1) = 360;
AUT_hcp(181,2) = AUT_hcp(1,2);
AUT_hxp(181,2) = AUT_hxp(1,2);
AUT_vcp(181,2) = AUT_vcp(1,2);
AUT_vxp(181,2) = AUT_vxp(1,2);

subplot(2,2,1);
polarplot(AUT_hcp(:,1)/180*pi,AUT_hcp(:,2));
rlim([-30 0]);
subplot(2,2,2);
polarplot(AUT_hxp(:,1)/180*pi,AUT_hxp(:,2));
rlim([-30 0]);
subplot(2,2,3);
polarplot(AUT_vcp(:,1)/180*pi,AUT_vcp(:,2));
rlim([-30 0]);
subplot(2,2,4);
polarplot(AUT_vxp(:,1)/180*pi,AUT_vxp(:,2));
rlim([-30 0]);

mkdir(save_folder);
writematrix(AUT_hcp,[save_folder,'/hori_copol.csv']);
writematrix(AUT_hxp,[save_folder,'/hori_xpol.csv']);
writematrix(AUT_vcp,[save_folder,'/verti_copol.csv']);
writematrix(AUT_vxp,[save_folder,'/verti_xpol.csv']);
