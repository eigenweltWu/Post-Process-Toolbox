# 圆极化暗室测量数据处理

**圆极化计算暂不支持`func_getS21.m`直接进行调用。**

## 更新日志

Jiatong Wu Created. Aug.13, 2024.

Jiatong Wu Modified, Sep.17, 2024.

## 实验原理

轴比可利用RHCP和LHCP进行更精准的计算：
$$
AR = \left|\frac{|G_{LHCP}|-|G_{RHCP}|}{|G_{LHCP} |+|G_{RHCP}|}\right|
$$

## Tree

****

**Raw Data**

- shoulder_R_copo
  - shoulder_R_copo1.txt
  - shoulder_R_copo2.txt
  - ...
  - shoulder_R_copon.txt
- shoulder_R_copo2
  - shoulder_R_copo_v2_1.txt
  - shoulder_R_copo_v2_2.txt
  - ...
  - shoulder_R_copo_v2_n.txt
- shoulder_R_crosspo
  - ...
- shoulder_R_crosspo_2
  - ...
- getS21.m
- getGain.m
- getPolar.m
- getARBW_CP.m
- drawARBeamCP.m
- func_getFarfield.m
- func_calcAR.m
- h_copol.csv
- h_xpol.csv
- v_copol.csv
- h_xpol.csv
- standard.csv
- Co-Pol.csv
- Cross-Pol.csv
- Plane1CP.csv
- Plane1XP.csv
- Plane2CP.csv
- Plane2XP.csv
- **AR2.csv**
- **ARBeam331.txt**
- **Polar2.4**
  - **temp_hcp.csv**
  - **temp_hxp.csv**
  - **temp_vcp.csv**
  - **temp_vxp.csv**


注：原始数据应为360°打180个点。如超出或不足请重新实验或先进行预处理。


## 使用方法

### 获取S21

进入`getS21.m`，修改`beginrow`和`endrow`为对应频率，修改`h_cp_path`，`h_xp_path`，`v_cp_path`，`v_xp_path`分别为HP共极化、交叉极化文件夹路径、VP共极化、交叉极化路径。

```matlab
beginrow= 301;
endrow = 401;
h_cp_path = 'shoulder_R_crosspo_2/shoulder_R_crosspo_v2_';
h_xp_path = 'shoulder_R_copo_2/shoulder_R_copo_v2_';
v_cp_path = 'shoulder_R_copo/shoulder_R_copo';
v_xp_path = 'shoulder_R_crosspo/shoulder_R_cross';
```

如需保存某个频点的方向图，请设置`beginrow==endrow` ，则将会自动生成对应的`temp`文件。

### 获取归一化方向图

**使用该脚本前，需要先使用`getS21.m`，并设置beginRow=endRow，获取S21数据。**

进入`getPolar.m`，修改`AUT_hcp_path`，`AUT_hxp_path`，`AUT_vcp_path`，`AUT_vxp_path`为待测天线的temp文件；`nr_of_angles`为扫描角度个数；`save_folder`为保存文件夹。

```matlab
AUT_hcp_path = 'temp_hcp.csv';
AUT_hxp_path = 'temp_hxp.csv';
AUT_vcp_path = 'temp_vcp.csv';
AUT_vxp_path = 'temp_vxp.csv';
nr_of_angles = 180;
save_folder = 'polar2.4';
```

点击运行，结果保存在`polar2.4`文件夹内。

### 获取某一频点的增益

**使用该脚本前，需要先使用`getS21.m`，并设置beginRow=endRow，获取S21数据。**

进入`getGain.m`，修改`AUT_hcp_path`，`AUT_hxp_path`，`AUT_vcp_path`，`AUT_vxp_path`为待测天线的S21文件；`row_AUT`与`row_Standard`分别为该频率对应的待测天线和标准增益天线S21行数；`Standard_S21`为标准增益天线的S21文件；`Standard_Gain`为待测天线在该频率的标准增益。

```matlab
row_AUT = 45;
row_Standard = 45;
AUT_hcp_path = 'h_copol.csv';
AUT_hxp_path = 'h_xpol.csv';
AUT_vcp_path = 'v_copol.csv';
AUT_vxp_path = 'v_xpol.csv';

Standard_S21 = 'standard.csv';
Standard_Gain = 12;
```

H面的CP、XP增益、V面的CP、XP增益分别记录在变量`hcp`、`hxp`、`vcp`、`vxp`中。

### 获取AR-Frequency曲线

**使用该脚本前，需要先使用`getS21.m`，并设置beginRow和endRow，获取S21数据。**

进入`getARBW_CP.m`，修改`plane1Dir`、`plane2Dir`分别为Co-Pol和X-Pol的原始数据文件夹路径，`freqBeginRow`、`freqEndRow`分别为计算频率对应的起始、终止频率，`outputfile`为曲线的输出文件夹。**请勿修改临时文件名`Co-Pol.csv`和`Cross-Pol.csv`**。执行该脚本，将输出AR-Frequency曲线，数据保存于outputfile文件夹内。

```matlab
plane1Dir = 'shoulder_R_crosspo_2/shoulder_R_crosspo_v2_'; %Co-Pol文件夹路径
plane2Dir = 'shoulder_R_copo_2/shoulder_R_copo_v2_'; %Cross-Pol文件夹路径
freqBeginRow = 203; %起始行数
freqEndRow = 401; %终止行数
outputfile = 'AR2.csv'; %输出文件名
```

*备注：如需使用两个线极化进行轴比计算，只需将`Plane1Dir`和`Plane2Dir`修改为VP和HP原始数据文件夹路径，修改`calType`的`‘CP’`为`‘Linear’`即可。*

### 获取AR-Elevation Angle曲线

**使用该脚本前，需要先使用`getS21.m`，并设置beginRow=endRow，获取S21数据。**

进入`drawARBeamCP.m`，修改`plane1CPDir`、`plane1XPDir`、`plane2CPDir`、`plane2XPDir`分别为E面、H面Co-Pol和X-Pol文件夹路径；修改`freqRow`为需要计算的频率对应的行数。执行该脚本，结果将保存在`ARBeam331.txt`中。

```matlab
plane1CPDir = 'shoulder_R_copo/shoulder_R_copo'; %EP_Co-Pol文件夹路径
plane1XPDir = 'shoulder_R_crosspo/shoulder_R_cross'; %EP_Cross-Pol文件夹路径
plane2CPDir = 'shoulder_R_copo_2/shoulder_R_copo_v2_'; %HP_Co-Pol文件夹路径
plane2XPDir = 'shoulder_R_crosspo_2/shoulder_R_crosspo_v2_'; %HP_Cross-Pol文件夹路径
freqRow = 331; %频率对应行数
```

*备注：本脚本仅支持通过LHCP和RHCP计算。*