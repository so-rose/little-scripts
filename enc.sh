#!/bin/bash

#Creates a signed message for the argument from stdin and writes to stdout. Use in a pipe.

RECIP="-r sofus@sofusrose.com"
binData="--armor"

help() {
less -R << EOF 
Usage:
	other program | $(echo -e "\033[1m./enc.sh\033[0m -r <recipient> ...optional repeat... [OPTIONS]")

PATTERN GUIDELINES:
	Encrypts data using your PGP private key, printing encrypted data to stdout.

OPTIONS:
	-r		recipient - Specify a recipient, who will be the only person able to decrypt the message.
	                      *Multiple -r's = multiple recipients
	-b		binary - Binary data is outputted.

EOF
}

while getopts "vh r: b" opt; do
	case "$opt" in
		h)
			help
			exit 0
			;;		
		
		v)
			echo -e "See decr.sh -h"
			exit 0
			;;
		r)
			RECIP+=" -r ${OPTARG}"
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

gpg --encrypt --sign $binData $RECIP --output - /dev/stdin > /dev/stdout
