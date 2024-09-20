clear;
row_AUT = 200;
row_Standard = 200;
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/verti_co';
v_xp_path = 'vertical_crosspo/verti_cross';
Standard_S21 = 'standard.csv';
Standard_Gain = 12;

func_getS21(row_AUT,row_AUT,h_cp_path,h_xp_path,v_cp_path,v_xp_path, 0, 1);

AUT_hcp_path = 'h_copol.csv';
AUT_hxp_path = 'h_xpol.csv';
AUT_vcp_path = 'v_copol.csv';
AUT_vxp_path = 'v_xpol.csv';

standard = dlmread(Standard_S21, ',', [row_Standard-1 1 row_Standard-1 1]);

hcp = dlmread(AUT_hcp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;
hxp = dlmread(AUT_hxp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;
vcp = dlmread(AUT_vcp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;
vxp = dlmread(AUT_vxp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;