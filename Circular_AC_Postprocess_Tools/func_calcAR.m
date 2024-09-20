function minAR = func_calcAR(Plane1, Plane2, beginTheta, endTheta, type)
beginTheta = mod(beginTheta+180,180)+1;
endTheta = mod(endTheta+180,180)+1;
if beginTheta > endTheta
    beginTheta = beginTheta+endTheta;
    endTheta = beginTheta-endTheta;
    beginTheta = beginTheta - endTheta;
end
pattern1 = readmatrix(Plane1);
pattern2 = readmatrix(Plane2);
AR = zeros(size(pattern1));
if type == "Linear"
    AR(:,1) = pattern1(:,1);
    AR(:,2) = abs(pattern1(:,2) - pattern2(:,2));
elseif type == "CP"
    AR(:,1) = pattern1(:,1);
    AR(:,2) = abs(10*log(abs((pattern1(:,3)-pattern2(:,3))./...
        (pattern1(:,3)+pattern2(:,3))))/log(10));
end
minAR = 100;
for i=floor((beginTheta+2)/2):floor((endTheta+2)/2)
    minAR = min(minAR, AR(i,2));
end