#!/bin/bash

echo test start

for((i=0;i<50;i++))
do
sensor_data=`i2ctransfer -y 1 w1@0x44 0xe0; i2ctransfer -y 1 r6@0x44`

temp_h=${sensor_data: 0: 4}
temp_l=${sensor_data: 5: 4}
temperature=$((((temp_h*256+temp_l)*175/65535)|bc))
temperature=$((temperature-45))

humi_h=${sensor_data: 15: 4}
humi_l=${sensor_data: 20: 4}
humidity=$(((humi_h*256+humi_l)*125/65535))
humidity=$((humidity-1))

echo temperature=$temperature humidity=$humidity
sleep 0.1
done
