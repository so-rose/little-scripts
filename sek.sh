#!/bin/bash

path=$1
if [ -d $path ]; then
	djv_view $(find ${path} | sort | cut -d$'\n' -f2)
else 
	djv_view $path
fi
