clear;

useFFT = true; % Smooth data with fft.
resultDir = 'polar.opju'; % Path of result origin file,ended with .opju

% The following paths should be set to '' if ignored.
% 1. Simulated results from CST.
simEPlaneDir = 'E.txt'; % Path of simulated E-Plane
simHPlaneDir = 'H.txt'; % Path of simulated H-Plane
% 2. Measured results in anechoic chamber.
basedir = '3.95-6/'; % Root Path
meaEcoDir = 'HP_VPOL/MEA.txt';
% Sample path of E-Plane Co-Polarized Pattern.
meaExDir = 'HP_HPOL/MEA.txt';
% Sample path of E-Plane Cross-Polarized Pattern (Ignore if not measured)
meaHcoDir = 'EP_VPOL/MEA.txt';
% Sample path of H-Plane Co-Polarized Pattern.
meaHxDir = 'EP_HPOL/MEA.txt';
% Sample path of H-Plane Cross-Polarized Pattern (Ignore if not measured)

nr_of_points = 180; % Number of sampling points
Angle_Eco = 0; % Adjust angle of E-Plane Co-Pol
Angle_Ex = 0; % Adjust angle of E-Plane Cross-Pol
Angle_Hco = 0; % Adjust angle of H-Plane Co-Pol
Angle_Hx = 0; % Adjust angle of H-Plane Cross-Pol

polarRow = 100; % Row number of the frequency

magic = 0; % Magic

%---------------Don't change codes below!----------------------
if useFFT
    templateDir = 'polar_template.opju'; % 使用origin自带的fft滤波
else
    templateDir = 'polar_template_ordinary.opju'; % 使用小波变换滤波
end

if ~exist(resultDir,'file')
    copyfile(templateDir,resultDir);
end

originObj = actxserver('Origin.ApplicationSI');
invoke(originObj, 'Execute', 'doc -mc 1;');
invoke(originObj, 'IsModified', 'false');
invoke(originObj,'Load',[pwd,'/',resultDir]);

try 
if isempty(simHPlaneDir) == 0
    [simHCo,simHx] = readSimData(simHPlaneDir);
    mco = max(simHCo(:,2));
    mx = max(simHx(:,2));
    if mco < mx
        t = simHCo(:,2);
        simHCo(:,2) = simHx(:,2);
        simHx(:,2) = t;
    end
    simHCo(:,2) = simHCo(:,2) - max(mco,mx);
    simHx(:,2) = simHx(:,2) - max(mco,mx);
	invoke(originObj,'PutWorksheet','simHPlane',....
        [simHCo(:,1),simHCo(:,2),simHx(:,2)]);
end

if isempty(simEPlaneDir) == 0
    [simECo,simEx] = readSimData(simEPlaneDir);
    mco = max(simECo(:,2));
    mx = max(simEx(:,2));
    if mco < mx
        t = simECo(:,2);
        simECo(:,2) = simEx(:,2);
        simEx(:,2) = t;
    end
    simECo(:,2) = simECo(:,2) - max(mco,mx);
    simEx(:,2) = simEx(:,2) - max(mco,mx);
	invoke(originObj,'PutWorksheet','simEPlane',....
        [simECo(:,1),simECo(:,2),simEx(:,2)]);
end

if isempty(meaEcoDir) == 0
    realDir = join([basedir, meaEcoDir],'');
    [s21,polar_cur] = func_getS21(polarRow, polarRow,realDir,...
        Angle_Eco,nr_of_points);
    polar_cur(:,2) = polar_cur(:,2);
	invoke(originObj,'PutWorksheet','meaEco',polar_cur);
end

if isempty(meaExDir) == 0
    realDir = join([basedir, meaExDir],'');
    [s21,polar_cur] = func_getS21(polarRow, polarRow,realDir,...
        Angle_Ex,nr_of_points);
    polar_cur(:,2) = polar_cur(:,2) - magic;
	invoke(originObj,'PutWorksheet','meaEx',polar_cur);
end

if isempty(meaHcoDir) == 0
    realDir = join([basedir, meaHcoDir],'');
    [s21,polar_cur] = func_getS21(polarRow, polarRow,realDir,...
        Angle_Hco,nr_of_points);
    polar_cur(:,2) = polar_cur(:,2);
	invoke(originObj,'PutWorksheet','meaHco',polar_cur);
end

if isempty(meaHxDir) == 0
    realDir = join([basedir, meaHxDir],'');
    [s21,polar_cur] = func_getS21(polarRow, polarRow,realDir,...
        Angle_Hx,nr_of_points);
    polar_cur(:,2) = polar_cur(:,2) - magic;
	invoke(originObj,'PutWorksheet','meaHx',polar_cur);
end

invoke(originObj, 'Execute', ['save ',[pwd,'\',resultDir]]);
release(originObj);

catch ErrorInfo
    disp(ErrorInfo.message);
    for i = 1:length(ErrorInfo.stack)
        disp(ErrorInfo.stack(i));
    end
    release(originObj);
end