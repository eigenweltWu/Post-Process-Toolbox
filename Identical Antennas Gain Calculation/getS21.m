beginrow= 1;
endrow = 401;
s21 = zeros(endrow-beginrow+1,2);
filename = 'two_right';
outputfile = 'S21.csv';

for row = 1:endrow-beginrow+1
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, filename, 'temp.csv');
    s21(row,1) = freq;
    s21(row,2) = maxx_dB;
    s21(row,3) = maxx_linear;
end
writematrix(s21, outputfile);