function func_getS21(nr_of_points, folder, outputfile)
disp(['Extracting S21 Data from ',folder]);
S21_abs=zeros(nr_of_points,2);
S21_abs_total=zeros(nr_of_points,2);
S21_abs_avg=zeros(nr_of_points,2);

%column of frequency
 fid_1=[folder,'SParaResults1.txt'];
 S21_abs(:,1)=dlmread(fid_1,' ',[1 0 nr_of_points 0])./1E9;
 S21_abs_total(:,1)=dlmread(fid_1,' ',[1 0 nr_of_points 0])./1E9;
 S21_abs_avg(:,1)=dlmread(fid_1,' ',[1 0 nr_of_points 0])./1E9;
  
%add S21_abs_total
for n=1:180
 fid=[folder,'SParaResults',num2str(n),'.txt'];
 S21_real=dlmread(fid,' ',[1 12 nr_of_points 12]);
 S21_im=dlmread(fid,' ',[1 16 nr_of_points 16]);
 S21_abs(:,2)=sqrt((S21_real).^2+(S21_im).^2);
 S21_abs_total(:,2)=S21_abs_total(:,2)+S21_abs(:,2);
end
S21_abs_avg(:,2)=S21_abs_total(:,2)./180;

writematrix(S21_abs_avg, outputfile)
disp(['Completed ',folder, '!']);


