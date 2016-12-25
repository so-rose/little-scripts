#!/bin/bash

# Link (or unlink) an executable to your PATH.

lPath="/usr/local/bin"
delete=false

help() {
less -R << EOF 
Usage:
	other program | $(echo -e "\033[1m./linkPath.sh\033[0m [OPTIONS] executable")

PATTERN GUIDELINES:
	Links the specified executable to PATH (/usr/local/bin), removing any extensions (like .sh).

OPTIONS:
	-s		sbin - Put the program in /usr/local/sbin instead of /usr/local/bin.
	-d		delete - The program already at PATH (bin or sbin) will be removed.
	                   *Won't touch the real program.

EOF
}

while getopts "vh s d" opt; do
	case "$opt" in
		h)
			help
			exit 0
			;;		
		
		v)
			echo -e "See decr.sh -h"
			exit 0
			;;
		s)
			lPath="/usr/local/sbin"
			;;
		d)
			delete=true
			;;
		*)
			echo "Invalid option: -$OPTARG" >&2
			;;
	esac
done

shift $((OPTIND-1))

exPath="$1"
filename=$(basename "$exPath")
name="${filename%.*}"

if [[ $delete == "true" ]]; then
	rm "$lPath/$name"
	if [ $? -eq 0 ]; then echo "Removed executable at $lPath/$name !"; fi
	exit 0
fi

absPath() {
	#Depends python3.
	python3 -c "import os; print(os.path.abspath('$1'));"
}

ln -s $(absPath "$exPath") "$lPath/$name"

if [ $? -eq 0 ]; then echo "Linked executable to $lPath/$name !"; fi
