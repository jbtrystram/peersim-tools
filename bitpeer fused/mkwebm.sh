#installer les packages : mjpegtools et vpx-tools
#


for a in *.png; do
	b=$(printf %04d.png ${a%.png})
	if [ $a != $b ]; then
               mv $a $b
        fi
done

l= `ls -a | grep png | wc -l`
png2yuv -I p -f 24 -b 1 -n $((l-1)) -j %04d.png > yuvVid.yuv

vpxenc --good --cpu-used=0 --auto-alt-ref=1 --lag-in-frames=16 --end-usage=vbr --passes=2 --threads=2 --target-bitrate=3000 -o ./output/out_gif/$1.webm yuvVid.yuv

#Source : http://wiki.webmproject.org/howtos/convert-png-frames-to-webm-video
rm yuvVid.yuv
