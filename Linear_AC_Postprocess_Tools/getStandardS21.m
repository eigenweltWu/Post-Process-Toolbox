clear;
beginrow= 189;
endrow = 431;
path = 'measurement_standard/mea_';
s21_standard = zeros(endrow-beginrow+1,2);
result = 'standard.csv';

for row = 1:endrow-beginrow+1
    temppath = [path,':',num2str(row+beginrow-1)];
    disp(['Processing ',temppath]);
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, path, 'temp_standard.csv');
    s21_standard(row,1) = freq;
    s21_standard(row,2) = maxx_dB;
    s21_standard(row,3) = maxx_linear;
end
writematrix(s21_standard, result);

