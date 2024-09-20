clear;
plane1Dir = 'shoulder_R_crosspo_2/shoulder_R_crosspo_v2_'; %Co-Pol文件夹路径
plane2Dir = 'shoulder_R_copo_2/shoulder_R_copo_v2_'; %Cross-Pol文件夹路径
freqBeginRow = 203; %起始行数
freqEndRow = 401; %终止行数
outputfile = 'AR2.csv';%输出文件名
calType = 'CP';

ARBW = zeros(freqEndRow-freqBeginRow,3);
for row = freqBeginRow:freqEndRow
    disp(row);
    beginTheta = 0;
    endTheta = 0;
    freq = 0;
    [freq,beginTheta1,endTheta1] = func_getFarfield(row,plane1Dir,'Co-Pol.csv');
    [freq,beginTheta2,endTheta2] = func_getFarfield(row,plane2Dir,'Cross-Pol.csv');
    ARBW(row-freqBeginRow+1,1) = row;
    ARBW(row-freqBeginRow+1,2) = freq;
    ARBW(row-freqBeginRow+1,3) = func_calcAR('Co-Pol.csv','Cross-Pol.csv',...
       min(beginTheta1,beginTheta2),max(endTheta1,endTheta2),calType);

end
plot(ARBW(:,2),ARBW(:,3));
writematrix(ARBW,outputfile); 