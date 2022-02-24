import matplotlib.pyplot as plt
import numpy as np

import os
import time
import subprocess

count = 100  # 图中最多数据量

ax = list(range(count))  # 保存图1数据
ay = [0] * 100
num = count  # 计数

# init the sensor
os.system('i2ctransfer -y 1 w1@0x5a 0x0f r1')

os.system('i2ctransfer -y 1 w2@0x5a 0x20 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x80')

os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x10')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x40')
os.system('i2ctransfer -y 1 w2@0x5a 0x08 0x2a')
os.system('i2ctransfer -y 1 w2@0x5a 0x09 0x01')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x10 0x03')

os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x10')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x40')
os.system('i2ctransfer -y 1 w2@0x5a 0x08 0x20')
os.system('i2ctransfer -y 1 w2@0x5a 0x09 0xc8')
os.system('i2ctransfer -y 1 w2@0x5a 0x09 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x00')

os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x10')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x40')
os.system('i2ctransfer -y 1 w2@0x5a 0x08 0x22')
os.system('i2ctransfer -y 1 w2@0x5a 0x09 0xc8')
os.system('i2ctransfer -y 1 w2@0x5a 0x09 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x00')

os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x10')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x40')
os.system('i2ctransfer -y 1 w2@0x5a 0x08 0x26')
os.system('i2ctransfer -y 1 w2@0x5a 0x09 0x32')
os.system('i2ctransfer -y 1 w2@0x5a 0x09 0x32')
os.system('i2ctransfer -y 1 w2@0x5a 0x11 0x00')
os.system('i2ctransfer -y 1 w2@0x5a 0x21 0x00')

os.system('i2ctransfer -y 1 w2@0x5a 0x20 0x06')

# display the data
plt.ion()  # 开启一个画图的窗口进入交互模式，用于实时更新数据
plt.rcParams['figure.figsize'] = (10, 5)  # 图像显示大小
plt.rcParams['axes.unicode_minus'] = False
plt.rcParams['lines.linewidth'] = 0.5  # 设置曲线线条宽度
plt.tight_layout()
while True:
    plt.clf()  # 清除刷新前的图表，防止数据量过大消耗内存
    plt.suptitle("TOP Title", fontsize=30)  # 添加总标题，并设置文字大小

    TempPresence_l=subprocess.check_output("i2ctransfer -y 1 w1@0x5a 0x3a r1", shell=True)
    TempPresence_h=subprocess.check_output("i2ctransfer -y 1 w1@0x5a 0x3b r1", shell=True)
    TempPresence=int(TempPresence_l, 16) + int(TempPresence_h, 16) * 156
    time.sleep(0.126)

    #g1 = np.random.random()  # 生成随机数画图
    g1 = TempPresence
    # 图表1
    ax.append(num)  # 追加x坐标值
    ay.append(g1)  # 追加y坐标值
    agraphic = plt.subplot(1, 1, 1)
    agraphic.set_title('Sub Title1')  # 添加子标题
    agraphic.set_xlabel('time', fontsize=10)  # 添加轴标签
    agraphic.set_ylabel('sensor data', fontsize=20)
    plt.plot(ax[-count:], ay[-count:], 'g-')  # 等于agraghic.plot(ax,ay,'g-')

    plt.pause(0.001)  # 设置暂停时间，太快图表无法正常显示
    num = num + 1

