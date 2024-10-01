function [SimCo,SimX] = readSimData(simpath)
    simfile = fopen(simpath);
    SimCo = zeros(361,2);
    SimX = zeros(361,2);
    if simfile
        tline = fgets(simfile);
        tline = fgets(simfile);
        tline = fgets(simfile);
        temp = string(tline);
        temp = strsplit(temp);
        tempnum = zeros(1,8);
        for i = 2:9
            tempnum(i-1) = str2num(temp(i));
        end
        SimData = tempnum;
        while tline > 0
            temp = string(tline);
            temp = strsplit(temp);
            for i = 2:9
                tempnum(i-1) = str2num(temp(i));
            end
            SimData = [SimData;tempnum];
            tline = fgets(simfile);
        end
        judge = var(SimData(:,1));
        judgecol = 1+(judge==0);
        SimCo = [SimData(:,judgecol), SimData(:,4)];
        SimX = [SimData(:,judgecol), SimData(:,6)];
    end
