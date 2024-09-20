clear;
plane1CPDir = 'shoulder_R_copo/shoulder_R_copo'; %EP_Co-Pol文件夹路径
plane1XPDir = 'shoulder_R_crosspo/shoulder_R_cross'; %EP_Cross-Pol文件夹路径
plane2CPDir = 'shoulder_R_copo_2/shoulder_R_copo_v2_'; %HP_Co-Pol文件夹路径
plane2XPDir = 'shoulder_R_crosspo_2/shoulder_R_crosspo_v2_'; %HP_Cross-Pol文件夹路径
freqRow = 331; %频率对应行数

AR = zeros(180,3);
func_getFarfield(freqRow,plane1CPDir,'Plane1CP.csv');
func_getFarfield(freqRow,plane1XPDir,'Plane1XP.csv');
func_getFarfield(freqRow,plane2CPDir,'Plane2CP.csv');
func_getFarfield(freqRow,plane2XPDir,'Plane2XP.csv');
patternCP1 = readmatrix('Plane1CP.csv');
patternXP1 = readmatrix('Plane1XP.csv');
patternCP2 = readmatrix('Plane2CP.csv');
patternXP2 = readmatrix('Plane2XP.csv');

AR(:,1) = patternCP1(:,1);
AR(:,2) = abs(20*log(abs((patternCP1(:,3)-patternXP1(:,3))./...
        (patternCP1(:,3)+patternXP1(:,3))))/log(10));
AR(:,3) = abs(20*log(abs((patternCP2(:,3)-patternXP2(:,3))./...
        (patternCP2(:,3)+patternXP2(:,3))))/log(10));

subplot(1,2,1);
plot(AR(:,1),AR(:,2));
subplot(1,2,2);
plot(AR(:,1),AR(:,3));
file = strcat('ARBeam',num2str(freqRow)); %输出文件夹名
writematrix(AR,file);