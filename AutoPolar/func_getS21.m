function [s21,polar_c] = func_getS21(beginrow, endrow, path, rotate)

polar_c = zeros(181,3);
s21 = zeros(endrow-beginrow+1,2);

for row = 1:endrow-beginrow+1
    temp = string(split(path,'.'));
    temp = string(temp);
    temp(cellfun(@isempty,temp)) = [];
    if length(temp) > 1
        folderdir = join(temp(1:length(temp)-1),'.');
    else
        folderdir = '';
    end
    filesamp = temp(length(temp));
    temppath = '';
    [freq,beginTheta,endTheta,maxx_dB,maxx_linear,polar_c] = ...
        func_getFarfield(row+beginrow-1, folderdir,filesamp, temppath);
    %polar_c(:,2) = polar_c(:,2) - maxx_dB;
    %polar_c(:,3) = polar_c(:,3) - maxx_linear;
    polar_c(:,2:3) = func_polarSteering(polar_c(:,2:3),rotate);
    polar_c(181,1) = 360;
    polar_c(181,2) = polar_c(1,2);
    polar_c(181,3) = polar_c(1,3);
    s21(row,1) = freq;
    s21(row,2) = maxx_dB;
    s21(row,3) = maxx_linear;
end

