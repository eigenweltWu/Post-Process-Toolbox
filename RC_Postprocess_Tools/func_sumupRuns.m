function func_sumupRuns(nr_of_points, nr_of_runs, outputfile)
disp('Starting Sumup!');
S21_abs=zeros(nr_of_points,2);
S21_abs_total=zeros(nr_of_points,2);
S21_abs_avg=zeros(nr_of_points,2);

fid_1='S21_abs_avg_1.txt';

S21_abs(:,1)=dlmread(fid_1,',',[0 0 nr_of_points-1 0]);  %column of frequency
S21_abs_total(:,1)=dlmread(fid_1,',',[0 0 nr_of_points-1 0]);  
S21_abs_avg(:,1)=dlmread(fid_1,',',[0 0 nr_of_points-1 0]);

for n=1:nr_of_runs
 fid=['S21_abs_avg_',num2str(n),'.txt'];
 S21_abs(:,2)=dlmread(fid,',',[0 1 nr_of_points-1 1]);
 S21_abs_total(:,2)=S21_abs_total(:,2)+S21_abs(:,2);
end
S21_abs_avg(:,2)=S21_abs_total(:,2)./nr_of_runs;
writematrix(S21_abs_avg, outputfile);
save S21_abs_avg.txt -ascii S21_abs_avg
disp('Completed!');
