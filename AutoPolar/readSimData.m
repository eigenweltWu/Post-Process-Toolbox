function SimData = readSimData(simpath)
    simfile = fopen(simpath);
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
    end
