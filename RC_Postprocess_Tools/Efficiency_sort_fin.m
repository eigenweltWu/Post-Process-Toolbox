nr_of_pts = 1601;
S21_AUT=zeros(nr_of_pts,2);
S21_RA_total=zeros(nr_of_pts,2);
EFF_1=zeros(nr_of_pts,2);
EFF_2=zeros(nr_of_pts,2);

fid_2='S21_abs_avg_horn.txt';
fid_3='S21_abs_avg_AUT1.txt';
S21_AUT(:,1)=dlmread(fid_3,',',[0 0 nr_of_pts-1 0]);  %column of frequency
S21_RA(:,1)=dlmread(fid_2,',',[0 0 nr_of_pts-1 0]);  

S21_AUT(:,2)=dlmread(fid_3,',',[0 1 nr_of_pts-1 1]);  %column of S21

S21_RA(:,2)=dlmread(fid_2,',',[0 1 nr_of_pts-1 1]);  

EFF_2(:,1)=dlmread(fid_3,',',[0 0 nr_of_pts-1 0]);
EFF_2(:,2)=(S21_AUT(:,2)./S21_RA(:,2))*0.9;


plot(EFF_2(:,1),EFF_2(:,2))

save efficiency.txt -ascii EFF_2
