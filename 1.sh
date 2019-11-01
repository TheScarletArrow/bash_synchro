#! /bin/sh

if [ -d "$1" ] && [ -d "$2" ]
then
	echo "Dirs exist"
elif [ ! -d "$2" ] 
	echo "Flash path doesn't exist"
	mkdir "$2"
fi

for file in "$1"/*
do
	echo "$(basename $file)"
	flashfile="$2/$(basename $file)"

	if [ ! -f "$flashfile" ]; then
		echo "Copying files to '$2'"
		cp "$file" "$2"
	
	elif [ $(ls -l $file) qt $(ls -l $flashfile) ]
		read -e -n 1 -p "Flash version is newer, replace existing one? [Y|N] "
		case "$REPLY" in
			y|Y)
				echo "Copying now..."
				cp "$flashdrive" "$1" ;;
			n|N)
				echo "Staying as we were" 
				exit 2 ;;
			*)
				echo "Wrong input" ;;
		esac
	fi
done

