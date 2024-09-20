# 暗室中两相同天线增益测试数据处理

## 更新日志

Jiatong Wu Created. Aug.14, 2024.

## 实验原理

根据Friss传输定理，

$$
\frac{P_r}{P_t} = \left(\frac{\lambda}{4\pi R}\right)^2G_rG_t
$$

由于天线相同，$G_r=G_t$，因而，

$$
G(dB) = 20\log\left(\frac{4\pi R}{\lambda}\right)/\log(10)+S_{21}(dB)
$$

## Tree

**Raw Data**

- two_right1.txt
- two_right2.txt
- ...
- two_rightn.txt
- func_getFarfield.m
- getS21.m
- getStandardGain.m
- temp.csv
- **StandardGain.csv**
- **S21.csv**

注：原始数据应为360°打180个点。如超出或不足请重新实验或先进行预处理。

## 使用方法

首先进入`getS21.csv`，修改`filename`为数据文件名，`outputfile`为S21的输出文件名。

```matlab
filename = 'two_right';
outputfile = 'S21.csv';
```
执行脚本后将生成`temp.csv`。

进入`getStandardGain.m`，修改`beginrow`和`endrow`为起始、终止频率对应的行数；`filename`为原始数据文件名，`outputfile`为Gain-Frequency结果的输出文件名；`R`为两天线间的距离（单位为m）。

```matlab
beginrow= 1;
endrow = 401;
filename = 'two_right';
outputfile = 'StandardGain.csv';
R = 3; 
```

执行脚本后将输出Gain-Frequency曲线，并将数据保存于`StandardGain.csv`中。
