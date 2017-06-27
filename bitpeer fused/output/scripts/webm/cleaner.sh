head -n -1 $1 > temp.txt ; mv temp.txt $1
echo "$(tail -n +2 $1)" > $1
