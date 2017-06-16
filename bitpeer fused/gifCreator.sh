for a in *.png; do
	b=$(printf %04d.png ${a%.png})
	if [ $a != $b ]; then
		mv $a $b
	fi
done 

convert -delay 10 -loop 0 *.png $1.gif

