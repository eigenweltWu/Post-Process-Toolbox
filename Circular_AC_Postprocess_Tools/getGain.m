clear;
row_AUT = 45;
row_Standard = 45;
AUT_hcp_path = 'h_copol.csv';
AUT_hxp_path = 'h_xpol.csv';
AUT_vcp_path = 'v_copol.csv';
AUT_vxp_path = 'v_xpol.csv';

Standard_S21 = 'standard.csv';
Standard_Gain = 12;
standard = dlmread(AUT_Standard, ',', [row_Standard-1 1 row_Standard-1 1]);

hcp = dlmread(AUT_hcp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;
hxp = dlmread(AUT_hxp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;
vcp = dlmread(AUT_vcp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;
vxp = dlmread(AUT_vxp_path, ',', [row_AUT-1 1 row_AUT-1 1])-standard+Standard_Gain;