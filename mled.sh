#!/bin/bash

framerate=""
soundfile=""
replace=true
output="./.tmpout.mp4"
isOut=false

help() {
less -R << EOF 
Usage:
	$(echo -e "\033[1m./mled.sh\033[0m [OPTIONS] <inputfile>")

PATTERN GUIDELINES:
	Processes H.264/mp4 video files with simple operations, replacing the old one.

OPTIONS:
	-o		output - The output file; specify if you do not wish to replace output. Output format must be the same as input format.

	-s		soundfile - Replacement sound file. 'STRIP' strips all sound from the file.

EOF
}

while getopts "vh s: o:" opt; do
	case "$opt" in
		h)
			help
			exit 0
			;;		
		
		v)
			echo -e "See mled.sh -h"
			exit 0
			;;
		s)
			if [[ ${OPTARG} == "STRIP" ]]; then
				soundfile="-an"
			else
				soundfile="-i ${OPTARG} -shortest"
			fi
			;;
		o)
			output=${OPTARG}; isOut=true
			;;
		*)
			echo "Invalid option: -$OPTARG" >&2
			;;
	esac
done

shift $((OPTIND-1))
path=$(pwd)/$1

rm $output 2>/dev/null

ffmpeg -loglevel panic -stats -i $path $soundfile -c:v copy -c:a mp3 -b:a 320k $output

if [[ $isOut == false ]]; then mv $output $path; fi

exit 0
