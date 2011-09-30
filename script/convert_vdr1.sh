#!/bin/sh

convert $1 \( +clone -alpha extract -draw 'fill black polygon 0,0 0,20 20,0 fill white circle 20,20 20,0' \( +clone -flip \) -compose Multiply -composite \( +clone -flop \) -compose Multiply -composite \) -alpha off -compose CopyOpacity -composite $2
#convert $1 xc:white -fill "#ffe" -draw "roundrectangle 0,0,260,146 10,10" -transparent "#ffe" $2
