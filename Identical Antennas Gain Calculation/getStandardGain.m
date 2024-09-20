beginrow= 1;
endrow = 401;
filename = 'two_right';
outputfile = 'StandardGain.csv';
R = 3; 

s21 = zeros(endrow-beginrow+1,2);

for row = 1:endrow-beginrow+1
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear] = ...
        func_getFarfield(row+beginrow-1, filename, 'temp.csv');
    s21(row,1) = freq;
    s21(row,2) = maxx_dB;
    s21(row,3) = maxx_linear;
end


Gain = zeros(endrow-beginrow+1,2);
for row = 1:endrow-beginrow+1
    Gain(row,1) = s21(row,1);
    lambda = 3e8/Gain(row,1);
    dist_K = (4*pi*R)/lambda;
    %Gain(row,2) = 0.5*(20*log(dist_K)/log(10)-10*log(s21(row,2))/log(10));
    Gain(row,2) = 0.5*(20*log(dist_K)/log(10)+s21(row,2));
end
plot(Gain(:,1)/1e9, Gain(:,2));
writematrix(Gain, outputfile);