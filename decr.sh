#!/bin/bash

# Decrypt any message you're able to. Shows signature status too.

supp=false
binData="--armor"

help() {
less -R << EOF 
Usage:
	other program | $(echo -e "\033[1m./decr.sh\033[0m [OPTIONS]")

PATTERN GUIDELINES:
	Decrypts PGP encrypted text and binary data easily, and prints decrypted data to stdout.

OPTIONS:
	-s		suppress - Only show decrypted message on stdout; suppressed stderr.
	-b		binary - Incoming data is treated as binary data.

EOF
}

while getopts "vh s b" opt; do
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
			supp=true
			;;
		b)
			binData=""
			;;
		*)
			echo "Invalid option: -$OPTARG" >&2
			;;
	esac
done

if test -t 0; then help; exit 1; fi

if [[ $supp == "false" ]]; then
	gpg --decrypt --output - $binData /dev/stdin 
else
	gpg --decrypt --output - $binData /dev/stdin 2>/dev/null
fi
