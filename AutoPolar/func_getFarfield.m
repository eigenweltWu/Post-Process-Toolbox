function [freq,beginTheta,endTheta,maxx_dB,maxx_linear, polar] =...
    func_getFarfield(row,inputPath,inputEnding,outputFile)%频率对应的行数

polar=zeros(180,2);
for i=1:180
    polar(i,1)=i*2-2;
end

for n=1:180
    fid=join([inputPath,num2str(n),'.',inputEnding],'');
    M=dlmread(fid,' ',[row 0 row 16]);
    polar(n,3)= sqrt(M(1,13)^2+M(1,17)^2);
    s21_dB=20*log10(sqrt(M(1,13)^2+M(1,17)^2));
    polar(n,2)=s21_dB;
    freq = M(1,1);
end

maxx_dB = -10000;
maxx_linear = -10000;
for i=1:180
    maxx_dB = max(maxx_dB,polar(i,2));
    maxx_linear = max(maxx_linear,polar(i,3));
end
for i=1:180
    if polar(i,2)>=maxx_dB-3
        beginTheta = i*2-2;
        break
    end
end
endTheta = 358;
for i=beginTheta:358
    if polar(floor((i+2)/2),2)<=maxx_dB-3
        endTheta = i;
        break
    end
end

if isempty(outputFile) == 0
    writematrix(polar,outputFile);
end
