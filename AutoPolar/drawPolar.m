% beta版本，支持自动画图，如需修改作图结果请修改polar_template.opju
% 本版本小波变换的参数暂未进行调整
% 方向图自动对齐功能正在抓紧开发中...
clear;
templateDir = 'polar_template_ordinary.opju'; % 使用小波变换滤波
% templateDir = 'polar_template.opju'; % 使用origin自带的fft滤波
resultDir = 'Tri-band_5.6.opju'; % 自行更改
simEPlaneDir = 'E:/Shoulder3_0826/Figures/polar5.6/horisim.txt'; % CST导出的
simHPlaneDir = 'E:/Shoulder3_0826/Figures/polar5.6/vertisim.txt'; % CST导出的
% 底下的四个路径注意格式！如果没有就直接写空！新加图表不会覆盖原有数据！
meaEcoDir = 'E:/Shoulder3_0826/Measurements/9_11_measurement/measurement4_2/mea42_.txt';
meaExDir = 'E:/Shoulder3_0826/Measurements/9_11_measurement/measurement4_4/mea44_.txt';
meaHcoDir = 'E:/Shoulder3_0826/Measurements/9_11_measurement/measurement4_3/mea43_.txt';
meaHxDir = 'E:/Shoulder3_0826/Measurements/9_11_measurement/measurement4/mea4_.txt';
% 在beta版本中，需要人为输入方向图旋转角度进行调整。
Angle_Eco = 0;
Angle_Ex = 0;
Angle_Hco = 0;
Angle_Hx = 0;
% 对应频率所在行数
polarRow = 1229;

if ~exist(resultDir,'file')
    copyfile(templateDir,resultDir);
end

originObj = actxserver('Origin.ApplicationSI');
invoke(originObj, 'Execute', 'doc -mc 1;');
invoke(originObj, 'IsModified', 'false');
invoke(originObj,'Load',[pwd,'/',resultDir]);

try 
if isempty(simHPlaneDir) == 0
    simHPlane = readSimData(simHPlaneDir);
    mco = max(simHPlane(:,4));
    mx = max(simHPlane(:,6));
    if max(simHPlane(:,4)) < max(simHPlane(:,6))
        simHPlane(:,[4,6]) = simHPlane(:,[6,4]);
    end
    simHPlane(:,4) = simHPlane(:,4) - max(mco,mx);
    simHPlane(:,6) = simHPlane(:,6) - max(mco,mx);
	invoke(originObj,'PutWorksheet','simHPlane',[simHPlane(:,1),simHPlane(:,4),simHPlane(:,6)]);
end

if isempty(simEPlaneDir) == 0
    simEPlane = readSimData(simEPlaneDir);
    mco = max(simEPlane(:,4));
    mx = max(simEPlane(:,6));
    if max(simEPlane(:,4)) < max(simEPlane(:,6))
        simEPlane(:,[4,6]) = simEPlane(:,[6,4]);
    end
    simEPlane(:,4) = simEPlane(:,4) - max(mco,mx);
    simEPlane(:,6) = simEPlane(:,6) - max(mco,mx);
	invoke(originObj,'PutWorksheet','simEPlane',[simEPlane(:,1),simEPlane(:,4),simEPlane(:,6)]);
end

if isempty(meaEcoDir) == 0
    [s21,polar_cur] = func_getS21(polarRow, polarRow,meaEcoDir,Angle_Eco);
    polar_cur(:,2) = func_filter(polar_cur(:,2));
	invoke(originObj,'PutWorksheet','meaEco',polar_cur);
end

if isempty(meaExDir) == 0
    [s21,polar_cur] = func_getS21(polarRow, polarRow,meaExDir,Angle_Ex);
    polar_cur(:,2) = func_filter(polar_cur(:,2));
	invoke(originObj,'PutWorksheet','meaEx',polar_cur);
end

if isempty(meaHcoDir) == 0
    [s21,polar_cur] = func_getS21(polarRow, polarRow,meaHcoDir,Angle_Hco);
    %polar_cur(:,2) = polar_cur(:,2) - max(polar_cur(:,2));
    polar_cur(:,2) = func_filter(polar_cur(:,2));
	invoke(originObj,'PutWorksheet','meaHco',polar_cur);
end

if isempty(meaHxDir) == 0
    [s21,polar_cur] = func_getS21(polarRow, polarRow,meaHxDir,Angle_Hx);
    %polar_cur(:,2) = polar_cur(:,2) - max(polar_cur(:,2));
    polar_cur(:,2) = func_filter(polar_cur(:,2));
	invoke(originObj,'PutWorksheet','meaHx',polar_cur);
end

invoke(originObj, 'Execute', ['save ',[pwd,'\',resultDir]]);
release(originObj);

catch ErrorInfo
    disp(ErrorInfo);
    release(originObj);
end