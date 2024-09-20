nr_of_runs = 4;
nr_of_pts = 1601;
outputfile = 'S21_abs_avg_AUT1.txt';

for n = 1:nr_of_runs
    folder = ['Mea_',num2str(n),'/'];
    output = ['S21_abs_avg_',num2str(n),'.txt'];
    func_getS21(nr_of_pts, folder, output);
end

func_sumupRuns(nr_of_pts, nr_of_runs, outputfile);