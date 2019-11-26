#! /bin/sh

# $1 is first directory somewhere on PC
# $2 external directory, flash drive

Syncro()
{
local dir1=$1
local dir2=$2

for i in "$dir1"/*
do
	i=${i##*/}

	echo "\n Current file "$dir1/$i" \n"
	
	if [ -f "$dir2/$i" ] && [ -f "$dir1/$i" ]; then
	echo "\t" 1 Date and time of latest modification of "$dir1/$i" is $(date -r $dir1/$i)
	echo "\t" 2 Date and time of latest modification of "$dir2/$i" is $(date -r $dir2/$i)
	
	if date -r "$dir1/$i" +%s -lt date -r "$dir2/$i"; then
		cp "$dir1/$i" "$dir2/$i"
	else
		cp "$dir2/$i" "$dir1/$i"
	fi
	
	continue
elif [ -d "$dir2/$i" ] && [ -d "$dir1/$i" ]; then
	Syncro "$dir1/$i" "$dir2/$i"
	echo "Heading to $i subdirectory"	
	continue	
fi
cp -r "$dir1/$i" "$dir2/$i"
done

for j in "$dir2"/*
do
j=${J##*/}
echo "File" $dir2/$j
if [ ! -e "$fir2/$j" ]; then
	echo "doesnt exist in dir1 $dir2/$j"
	cp -r "$dir2/$j" "$di1/$j"
fi
done
echo "\n"
}

echo "Select directory dafults\n 1)by default in code \n 2) manually typed"
read answer
case $answer in
'1')
	directory1="/home/anton/Desktop/folder"
	directory2="/home/anton/Desktop/folderthe2"
;;
'2')
	read $directory1
	read $directory2
;;
*)
	echo "Wrong input"
	exit 15
;;
esac
if [ ! -d "$directory1" ]; then
	echo "directory $directory1 does not exist"
fi

if [ ! -d "$directory2" ]; then
	echo "directory $directory2 does not exist"
fi
[ -d "$directory1" ] && [ -d "$directory2" ] && Syncro $directory1 $directory2
