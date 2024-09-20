# 线极化暗室测量数据处理

## 更新日志

Jiatong Wu Created. Aug.13, 2024.

Jiatong Wu Modified. Sep.17, 2024. 

> 修正了getS21.m中进度提示的显示错误；（从本版本后getS21.m不再被推荐使用）
>
> 修正了getGain.m中的错误；
>
> 新增了getStandardS21.m；
>
> 新增了getGainOverFreq.m；
>
> 新增了func_getS21.m；
>
> 修改了func_getFarfield.m，修正了计算HPBW的错误。

Jiatong Wu Modified Sep.20, 2024.

> 为getPolar.m增添了360°的数据点。

## 实验原理

不想写暗室。

## Tree

****

**Raw Data**

- horizontal_copo
  - hori_copo1.txt
  - hori_copo2.txt
  - ...
  - hori_copon.txt
- horizontal_crosspo
  - hori_cross1.txt
  - hori_cross2.txt
  - ...
  - hori_crossn.txt
- vertical_copo
  - ...
- vertical_crosspo
  - ...
- measurement_standard
  - mea_1.txt
  - mea_2.txt
  - ...
  - mea_n.txt
- func_getFarfield.m
- func_getS21.m
- getS21.m
- getStandardS21.m
- getGain.m
- getGainOverFreq.m
- standard.csv
- StandardGain.csv
- **h_copol.csv**
- **h_xpol.csv**
- **v_copol.csv**
- **h_xpol.csv**
- **temp_hcp.csv**
- **temp_hxp.csv**
- **temp_vcp.csv**
- **temp_vxp.csv**
- **polar2.4**
  - **verti_copol.csv**
  - **verti_xpol.csv**
  - **hori_copol.csv**
  - **hori_xpol.csv**
- **result**
  - **hcp.csv**
  - **hxp.csv**
  - **vcp.csv**
  - **vxp.csv**


注：原始数据应为360°打180个点。如超出或不足请重新实验或先进行预处理。


## 使用方法

### 获取S21

**在20240917版本后该功能已被重写为函数func_getS21.m，因而本脚本不再被推荐使用。**

~~进入`getS21.m`，修改`beginrow`和`endrow`为对应频率，修改`h_cp_path`，`h_xp_path`，`v_cp_path`，`v_xp_path`分别为HP共极化、交叉极化文件夹路径、VP共极化、交叉极化路径。~~

```matlab
beginrow= 1;
endrow = 401;
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/verti_co';
v_xp_path = 'vertical_crosspo/verti_cross';
```

如需保存某个频点的方向图，请设置`beginrow==endrow` ，则将会自动生成对应的`temp`文件。

### 获取标准增益天线S21

进入`getStandardS21.m`，修改`beginrow`和`endrow`分别为起始和终止行数；`path`为标准增益天线的Co-Pol文件路径；`result`为结果输出文件名。

```matlab
beginrow= 189;
endrow = 431;
path = 'measurement_standard/mea_';
result = 'standard.csv';
```

### 获取归一化方向图

进入`getPolar.m`，~~修改`AUT_hcp_path`，`AUT_hxp_path`，`AUT_vcp_path`，`AUT_vxp_path`为待测天线的temp文件；~~(在20240917版本后以上4个参数不推荐进行修改)。修改`h_cp_path`、`h_xp_path`、`v_cp_path`、`v_xp_path`分别为测试数据路径；`nr_of_angles`为扫描角度个数；`save_folder`为保存文件夹。

```matlab
polarrow = 160;
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/verti_co';
v_xp_path = 'vertical_crosspo/verti_cross';
save_folder = 'polar1.7-2.6';
nr_of_angles = 180;
```

点击运行，结果保存在`polar2.4`文件夹内。

### 获取某一频点的增益

**在执行本脚本之前，需要先执行getStandardS21.m获取标准增益文件。**

进入`getGain.m`，~~修改`AUT_hcp_path`，`AUT_hxp_path`，`AUT_vcp_path`，`AUT_vxp_path`为待测天线的temp文件；~~(在20240917版本后以上4个参数不推荐进行修改)。修改`row_AUT`与`row_Standard`分别为该频率对应的待测天线和标准增益天线S21行数；`h_cp_path`、`h_xp_path`、`v_cp_path`、`v_xp_path`分别为测试数据路径；`Standard_S21`为标准增益天线的S21文件；`Standard_Gain`为待测天线在该频率的标准增益。

```matlab
row_AUT = 200;
row_Standard = 200;
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/verti_co';
v_xp_path = 'vertical_crosspo/verti_cross';
Standard_S21 = 'standard.csv';
Standard_Gain = 12;
```

H面的CP、XP增益、V面的CP、XP增益分别记录在变量`hcp`、`hxp`、`vcp`、`vxp`中。

### 获取Gain over Frequency曲线

**在执行本脚本之前，需要先执行`getStandardS21.m`获取标准增益文件。同时，需要准备`Standard_Gain.csv`作为参考增益。**

进入`getGainOverFreq.m`，分别设置`row_AUT_start`、`row_AUT_end`为待测天线起始、终止行数；`row_Standard_start`、`row_Standard_end`为标准增益天线起始、终止行数。`Standard_S21`为标准天线S21文件。`Standard_path`为标称增益文件路径。`save_folder`为保存文件夹。`h_cp_path`、`h_xp_path`、`v_cp_path`、`v_xp_path`分别为测试数据路径；`Standard_S21`为标准增益天线的S21文件。

```matlab
row_AUT_start = 1;
row_AUT_end = 243;
row_Standard_start = 1;
row_Standard_end = 243;
Standard_S21 = 'standard.csv';
Standard_path = 'standardGain.csv';
save_folder = 'result';
h_cp_path = 'horizontal_copo/hori_copo';
h_xp_path = 'horizontal_crosspo/hori_cross';
v_cp_path = 'vertical_copo/verti_co';
v_xp_path = 'vertical_crosspo/verti_cross';
```

`Standard_Gain.csv`应当包含两列，其中第一列为频率**（单位：GHz）**，第二列为增益（单位：dB）。一个用于参考的增益文件如下所示，其中1.7-2.6GHz、3.95-6GHz为AInfo的标准增益天线，其余均为恒达微波的标准增益天线。

```
1.7, 10.28
1.8, 10.75
1.9, 10.62
2.0, 11.46
2.1, 11.77
2.2, 12.53
2.3, 12.86
2.4, 13.10
2.5, 13.67
2.59, 13.64
2.60, 14.85
2.72, 15.29
2.84, 15.60
2.96, 15.82
3.09, 15.97
3.21, 16.16
3.33, 16.43
3.57, 16.88
3.69, 17.06
3.82, 17.23
3.94, 17.34
3.95, 14.31
4.20, 14.92
4.40, 15.39
4.60, 15.75
4.80, 16.05
5.00, 16.35
5.20, 16.62
5.40, 16.89
5.60, 17.12
5.80, 17.34
6.00, 17.61
6.14, 15.28
6.40, 15.55
6.65, 15.83
6.90, 16.08
7.16, 16.32
7.41, 16.54
7.66, 16.75
7.92, 16.93
8.19, 17.13
8.20, 14.45
8.58, 14.78
8.96, 15.10
9.33, 15.39
9.71, 15.67
10.09, 15.94
10.47, 16.19
10.85, 16.42
11.22, 16.65
11.60, 16.87
11.98, 17.06
12.40, 17.27
17.60, 19.77
18.42, 20.10
19.24, 20.41
20.06, 20.70
20.88, 20.97
21.70, 21.23
22.51, 21.47
23.33, 21.69
24.15, 21.91
24.97, 22.11
25.79, 22.30
26.70, 22.49
26.50, 19.98
27.72, 20.31
28.93, 20.62
30.15, 20.92
31.36, 21.18
32.58, 21.45
33.79, 21.70
35.01, 21.93
36.22, 22.05
37.44, 22.36
38.65, 22.55
40.00, 22.76
```

