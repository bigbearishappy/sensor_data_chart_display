#!/bin/bash 
echo "init the sensor"

#i2ctransfer -y 1 w1@0x5a 0x0f r1
#
#i2ctransfer -y 1 w2@0x5a 0x20 0x00
#i2ctransfer -y 1 w2@0x5a 0x21 0x80
#
#i2ctransfer -y 1 w2@0x5a 0x21 0x10
#i2ctransfer -y 1 w2@0x5a 0x11 0x40
#i2ctransfer -y 1 w2@0x5a 0x08 0x2a
#i2ctransfer -y 1 w2@0x5a 0x09 0x01
#i2ctransfer -y 1 w2@0x5a 0x11 0x00
#i2ctransfer -y 1 w2@0x5a 0x21 0x00
#i2ctransfer -y 1 w2@0x5a 0x10 0x03
#
#i2ctransfer -y 1 w2@0x5a 0x21 0x10
#i2ctransfer -y 1 w2@0x5a 0x11 0x40
#i2ctransfer -y 1 w2@0x5a 0x08 0x20
#i2ctransfer -y 1 w2@0x5a 0x09 0xf4
#i2ctransfer -y 1 w2@0x5a 0x09 0x01
#i2ctransfer -y 1 w2@0x5a 0x11 0x00
#i2ctransfer -y 1 w2@0x5a 0x21 0x00
#
#i2ctransfer -y 1 w2@0x5a 0x21 0x10
#i2ctransfer -y 1 w2@0x5a 0x11 0x40
#i2ctransfer -y 1 w2@0x5a 0x08 0x22
#i2ctransfer -y 1 w2@0x5a 0x09 0x0
#i2ctransfer -y 1 w2@0x5a 0x09 0x00
#i2ctransfer -y 1 w2@0x5a 0x11 0x00
#i2ctransfer -y 1 w2@0x5a 0x21 0x00
#
#i2ctransfer -y 1 w2@0x5a 0x21 0x10
#i2ctransfer -y 1 w2@0x5a 0x11 0x40
#i2ctransfer -y 1 w2@0x5a 0x08 0x26
#i2ctransfer -y 1 w2@0x5a 0x09 0x0
#i2ctransfer -y 1 w2@0x5a 0x09 0x0
#i2ctransfer -y 1 w2@0x5a 0x11 0x00
#i2ctransfer -y 1 w2@0x5a 0x21 0x00

i2ctransfer -y 3 w2@0x5a 0x0c 0x04
i2ctransfer -y 3 w2@0x5a 0x0d 0x22
i2ctransfer -y 3 w2@0x5a 0x10 0x02
i2ctransfer -y 3 w2@0x5a 0x20 0x08
i2ctransfer -y 3 w2@0x5a 0x21 0x00
i2ctransfer -y 3 w2@0x5a 0x22 0x00

reg_0c=`i2ctransfer -y 3 w1@0x5a 0x0c r1`
reg_0d=`i2ctransfer -y 3 w1@0x5a 0x0d r1`
reg_10=`i2ctransfer -y 3 w1@0x5a 0x10 r1`
reg_20=`i2ctransfer -y 3 w1@0x5a 0x20 r1`
reg_21=`i2ctransfer -y 3 w1@0x5a 0x21 r1`
reg_22=`i2ctransfer -y 3 w1@0x5a 0x22 r1`
printf 'reg0x0c:0x%x reg0x0d:0x%x reg0x10:0x%x reg0x20:0x%x reg0x21:0x%x reg0x22:0x%x\n' $reg_0c $reg_0d $reg_10 $reg_20 $reg_21 $reg_22

function unsigned16_to_signed()
{
temp=0
if (( $1 >= 0x8000));then
temp=$(($1-0x10000))
else
temp=$1
fi
echo $temp
}

for((;;))
do
reg_26_r4=`i2ctransfer -y 3 w1@0x5a 0x26 r4`
TempObject_l=${reg_26_r4: 0: 4}
TempObject_h=${reg_26_r4: 5: 4}
TempObject=$(((TempObject_h*256+TempObject_l)))
#echo TempObject=$TempObject

TempAmbient_l=${reg_26_r4: 10: 4}
TempAmbient_h=${reg_26_r4: 15: 4}
TempAmbient=$(((TempAmbient_h*256+TempAmbient_l)/100))
#TempAmbient=`unsigned16_to_signed $TempAmbient`
#echo TempAmbient=$TempAmbient

reg_3a_r4=`i2ctransfer -y 3 w1@0x5a 0x3a r4`
TempPresence_l=${reg_3a_r4: 0: 4}
TempPresence_h=${reg_3a_r4: 5: 4}
TempPresence=$((TempPresence_h*256+TempPresence_l))
TempPresence=`unsigned16_to_signed $TempPresence`
#echo TempPresence=$TempPresence

TempMotion_l=${reg_3a_r4: 10: 4}
TempMotion_h=${reg_3a_r4: 15: 4}
TempMotion=$((TempMotion_h*256+TempMotion_l))
TempMotion=`unsigned16_to_signed $TempMotion`
#echo TempMotion=$TempMotion

detect=`i2ctransfer -y 3 w1@0x5a 0x25 r1`
printf 'TempObject=%i\t TempAmbient=%i\t TempPresence=%i\t TempMotion=%i\t detect=%i\n' $TempObject $TempAmbient $TempPresence $TempMotion $detect
sleep 0.126 
done
