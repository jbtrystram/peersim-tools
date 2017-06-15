#!/bin/bash 
#
#Installer les packages : mjpegtools et vpx-tools
#

for a in *.png; do
        b=$(printf %04d.png ${a%.png})
        if [ $a != $b ]; then
                mv $a $b
        fi
done

png2yuv -I p -f 24 -b 1 -n 500 -j %04d.png > yuvVid.yuv

vpxenc --good --cpu-used=0 --auto-alt-ref=1 --lag-in-frames=16 --end-usage=vbr --passes=2 --threads=2 --target-bitrate=3000 -o $1.webm yuvVid.yuv

#Source : http://wiki.webmproject.org/howtos/convert-png-frames-to-webm-video

rm *.png
rm yuvVid.yuv
