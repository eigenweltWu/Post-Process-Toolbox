function [freq,beginTheta,endTheta] = func_getFarfield(row,inputPath,outputFile)%频率对应的行数
S21_dB=zeros(180,2);
for i=1:180
    S21_dB(i,1)=i*2-2;
end

for n=1:180
    fid=[inputPath,num2str(n),'.txt'];
    M=dlmread(fid,' ',[row 0 row 16]);
    S21_dB(n,3)= sqrt(M(1,13)^2+M(1,17)^2);
    s21_dB=20*log10(sqrt(M(1,13)^2+M(1,17)^2));
    S21_dB(n,2)=s21_dB;
    freq = M(1,1);
end

maxx = -10000;
for i=1:180
    maxx = max(maxx,S21_dB(i,2));
end
for i=1:180
    if S21_dB(i,2)>=maxx-3
        beginTheta = i*2-2;
        break
    end
end
endTheta = 358;
for i=beginTheta:358
    if S21_dB(floor((i+2)/2),2)<=maxx-3
        endTheta = i;
        break
    end
end
if isempty(outputFile) == 0
    writematrix(S21_dB,outputFile);
end