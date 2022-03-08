import matplotlib.pyplot as plt
import numpy as np

import os
import time
import subprocess

count = 100 

ax = list(range(count))  #save the data of pic 1
ay = [0] * 100
num = count  # count

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

os.system('i2ctransfer -y 1 w2@0x5a 0x10 0x02')
os.system('i2ctransfer -y 1 w2@0x5a 0x20 0x07')

# display the data
plt.ion()  #Open a drawing window to enter interactive mode for updating data in real time 
plt.rcParams['figure.figsize'] = (10, 5)  # configure the display size
plt.rcParams['axes.unicode_minus'] = False
plt.rcParams['lines.linewidth'] = 0.5  #configure the curve line width
plt.tight_layout()
while True:
    plt.clf()  #Clear the chart before refresh to prevent excessive data consumption from consuming memory
    plt.suptitle("TOP Title", fontsize=30)  # add the top title and config it's font size

    TempPresence_l=subprocess.check_output("i2ctransfer -y 1 w1@0x5a 0x3a r1", shell=True)
    TempPresence_h=subprocess.check_output("i2ctransfer -y 1 w1@0x5a 0x3b r1", shell=True)
    TempPresence=int(TempPresence_l, 16) + int(TempPresence_h, 16) * 156
    time.sleep(0.126)

    g1 = TempPresence
    # pic 1
    ax.append(num)  # display the data of x axis 
    ay.append(g1)  # display the data of y axis 
    agraphic = plt.subplot(1, 1, 1)
    agraphic.set_title('Sub Title1')  # add the subtitle
    agraphic.set_xlabel('time', fontsize=10)  # add the label of x axis
    agraphic.set_ylabel('sensor data', fontsize=20)
    plt.plot(ax[-count:], ay[-count:], 'g-') 

    plt.pause(0.001)  # config the pause time.
    num = num + 1

