#! /bin/sh

# $1 is first directory somewhere on PC
# $2 external directory, flash drive

#$2="/media/anton/YURKOVANTON"
#$flashfile - file in flash directory
#$file - file
if [ ! -d  "$2" ]; then
	echo "flash directory does not exist"
	echo "creating "$2" path in flash drive"	
	mkdir "$2"
	echo "Directory "$2" successfully made on your flash drive"
	echo "Will be copying from "$1" to "$2""
fi

for file in "$1"/*
do
	echo "File "$(basename $file)" "
	#echo "$(basename $file)"

	$flashfile="$2/$(basename $file)"

	if [ ! -f "$flashfile" ]
	then
		echo "No such files on flash drive"
		echo "Copying 'em to "$2""
		cp "$file" "$2"
	
	elif [ -f $flashfile ] && [ "$(ls -l $file)" lt "$(ls -l $flashfile)" ];
		then
		#echo "Flash version is newer, replace existing one? Y\N"
		read  -e -n 1 -p reply "Flash version is newer, replace existing one? [Y|N]"
		#read reply
		case $reply in
			y|Y) echo "Copying now to "$1" "
			cp "$file" "$1";;
			n|N) echo "Staying as we were" 
			exit 2 ;;
			*) echo "Wrong input"
		;;
		esac
		
	else
			cp "$file" "$2"
	fi
done
	

