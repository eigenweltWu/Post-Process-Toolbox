clear;
AUT_hcp_path = 'temp_hcp.csv';
AUT_hxp_path = 'temp_hxp.csv';
AUT_vcp_path = 'temp_vcp.csv';
AUT_vxp_path = 'temp_vxp.csv';
nr_of_angles = 180;
save_folder = 'polar2.4';

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

mkdir(save_folder);
writematrix(AUT_hcp,[save_folder,'/hori_copol.csv']);
writematrix(AUT_hxp,[save_folder,'/hori_xpol.csv']);
writematrix(AUT_vcp,[save_folder,'/verti_copol.csv']);
writematrix(AUT_vxp,[save_folder,'/verti_xpol.csv']);