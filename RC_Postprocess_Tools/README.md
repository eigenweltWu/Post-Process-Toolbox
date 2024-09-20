# 混响室数据处理

## 更新日志

Jiatong Wu Created. Aug.13, 2024.

## 实验原理

不懂混响室。

## Tree

**Raw Data**
- Mea_1

  - SParaResults1.txt

  - SParaResults2.txt

  - ...

  - SParaResultsn.txt
- Mea_2
- ...
- Mea_n
- Efficiency_sort_fin.m
- func_getS21.m
- func_sumupRuns.m
- processS21.m
- S21_abs_avg.txt
- S21_abs_avg_1.txt
- S21_abs_avg_1.txt
- ...
- S21_abs_avg_n.txt
- S21_abs_avg_AUT1.txt
- S21_abs_avg_horn.txt
- **efficiency.txt**

其中，S21_abs_avg.txt, S21_abs_avg_1.txt, ..., S21_abs_avg_n.txt, S21_abs_avg_AUT1.txt为生成文件；S21_abs_avg_horn.txt为手动拖入的文件。

注：原始数据应为360°打180个点。如超出或不足请重新实验或先进行预处理。

## 使用方法

### 获取S21

进入`processS21.m`，修改`nr_of_runs`为总测试次数，修改`nr_of_pts`为VNA打点个数；修改`folder`为路径文件夹和输出文件名`outputfile`。**请勿更改临时输出文件名及路径**。执行该matlab脚本。

```matlab
nr_of_runs = 4;
nr_of_pts = 1601;
outputfile = 'S21_abs_avg_AUT1.txt';
folder = ['Mea_',num2str(n),'/']; %路径文件夹为Mea_1/,Mea_2/,...
```

在标准增益天线的混响室测试中，重复该操作。获得`S21_abs_avg_horn.txt`。

### 效率计算

进入`Efficiency_sort_fin.m`，修改`nr_of_pts`，`fid_2`和`fid_3`分别为标准增益天线和待测天线的S参数文件。修改输出文件名（默认为efficiency.txt）。

```matlab
nr_of_pts = 1601;
fid_2='S21_abs_avg_horn.txt';
fid_3='S21_abs_avg_AUT1.txt';
save efficiency.txt -ascii EFF_2
```

计算完成后，将会呈现效率关于频率的曲线及数据（第一列为频率，第二列为效率，用英文逗号分隔）。