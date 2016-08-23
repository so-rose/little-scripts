#!/bin/bash

framerate=24
quality=0
soundfile=""
output="./out.mp4"

help() {
less -R << EOF 
Usage:
	$(echo -e "\033[1m./mlov.sh\033[0m -q <quality> [OPTIONS] <pattern>")

PATTERN GUIDELINES:
	Same as in FFMPEG, you must specify the images you wish to convert.

	Ex. %04d.jpg -> 0000.jpg, 0001,jpg, 0002.jpg...
	Ex. seq-folder/MLV-07-2015_%06.exr -> seq-folder/MLV-07-2015_0000.exr, seq-folder/MLV-07-2015_0001.exr...

OPTIONS:
	-q		quality - 0 is fast but bad, 1 is amazing but slow, 3 is slow but small. Default: 0.
	-f		framerate - Frames per Second. Default: 24.
	-s		soundfile - The optional sound file to encode into the output.
	-o		output - The output file. Default: ./out.mp4

EOF
}

while getopts "vh q: f: d: o:" opt; do
	case "$opt" in
		h)
			help
			exit 0
			;;		
		
		v)
			echo -e "See mlov.sh -h"
			exit 0
			;;
		q)
			quality=${OPTARG} #0 = fast but bad, 1 = slow but gold, 2 = bad but small.
			;;
		f)
			framerate=${OPTARG}
			;;
		s)
			soundfile=${OPTARG}
			;;
		o)
			output=${OPTARG}
			;;
		*)
			echo "Invalid option: -$OPTARG" >&2
			;;
	esac
done

shift $((OPTIND-1))
path=$1

rm $output 2>/dev/null

if [[ $quality == 0 ]]; then
	preset="veryfast"
	crf="28"
elif [[ $quality == 1 ]]; then
	preset="veryslow"
	crf="20"
elif [[ $quality == 2 ]]; then
	preset="veryslow"
	crf="23"
elif [[ $quality == 3 ]]; then
	preset="veryslow"
	crf="28"
fi

if [[ ! -z $soundfile ]]; then sound="-i ${soundfile}"; else sound=""; fi


if [ -d $(dirname "${path}") ]; then
	ffmpeg -loglevel panic -stats -f image2 -i $path $sound -c:v libx264 -n -r $framerate -preset $preset -crf $crf -c:a mp3 -b:a 320k $output
else 
	echo "Doesn't exist!"
fi
