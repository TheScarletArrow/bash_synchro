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
	exec 3>&1
	
	result=$(gdialog --title "Warning" --menu "Which file to copy?" 15 80 2 1 "$dir1/$i: $(date -r "$dir1/$i")"  2 "$dir2/$i: $(date -r "$dir2/$i")"  2>&1 1>&3)
	case "$result" in
		'1') cp "$dir1/$i" "$dir2/$i";;
		'2') cp "$dir2/$i" "$dir1/$i";;
	esac
	echo "\n"
	exec 3>&-
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

directory1="/home/anton/Desktop/lab"
directory2="/home/anton/Desktop/folder"

if [ ! -d "$directory1" ]; then
	echo "directory $directory1 does not exist"
fi

if [ ! -d "$directory2" ]; then
	echo "directory $directory2 does not exist"
fi
[ -d "$directory1" ] && [ -d "$directory2" ] && Syncro $directory1 $directory2
