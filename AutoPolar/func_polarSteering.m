function polar = func_polarSteering(data,angle, nr_of_points)
    if angle >= 360
        data = flip(data);
    end
    angle = mod(angle,360);
    alter_pts = floor(angle/360* nr_of_points + 0.5);
    len = length(data);
    alter_pts = mod(alter_pts,len);
    polar = [data(end-alter_pts+1:end,:);data(1:end-alter_pts,:)];
end