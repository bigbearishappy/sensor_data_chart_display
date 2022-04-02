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
TempObject_l=`i2ctransfer -y 3 w1@0x5a 0x26 r1`
TempObject_h=`i2ctransfer -y 3 w1@0x5a 0x27 r1`
TempObject=$(((TempObject_h*256+TempObject_l)/2000))
TempObject=`unsigned16_to_signed $TempObject`
#echo TempObject=$TempObject

TempAmbient_l=`i2ctransfer -y 3 w1@0x5a 0x28 r1`
TempAmbient_h=`i2ctransfer -y 3 w1@0x5a 0x29 r1`
TempAmbient=$(((TempAmbient_h*256+TempAmbient_l)/100))
TempAmbient=`unsigned16_to_signed $TempAmbient`
#echo TempAmbient=$TempAmbient

TempPresence_l=`i2ctransfer -y 3 w1@0x5a 0x3a r1`
TempPresence_h=`i2ctransfer -y 3 w1@0x5a 0x3b r1`
TempPresence=$((TempPresence_h*256+TempPresence_l))
TempPresence=`unsigned16_to_signed $TempPresence`
#echo TempPresence=$TempPresence

TempMotion_l=`i2ctransfer -y 3 w1@0x5a 0x3c r1`
TempMotion_h=`i2ctransfer -y 3 w1@0x5a 0x3d r1`
TempMotion=$((TempMotion_h*256+TempMotion_l))
TempMotion=`unsigned16_to_signed $TempMotion`
#echo TempMotion=$TempMotion

detect=`i2ctransfer -y 3 w1@0x5a 0x25 r1`
printf 'TempObject=%i\t TempAmbient=%i\t TempPresence=%i\t TempMotion=%i\t detect=%i\n' $TempObject $TempAmbient $TempPresence $TempMotion $detect
sleep 0.126 
done
