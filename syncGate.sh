#!/bin/bash

#Usage: ./rsyncGate.sh GATEWAY TARGET TARGET_PATH (optional) LOCAL_PATH
# GATEWAY is the gateway user@hostname.
# TARGET is the target user@hostname, from the perspective of the gateway.
# TARGET_PATH is the path to copy over from the target machine.
# LOCAL_PATH is the path to copy to on the local machine. Defaults to current dir.

GATEWAY=$1
TARGET=$2
TARGET_PATH=$3
LOCAL_PATH=$4

if [[ -z $LOCAL_PATH ]]; then LOCAL_PATH="."; fi

rsync -avuz --stats --progress -e "ssh -A $GATEWAY ssh" $TARGET:$TARGET_PATH $LOCAL_PATH
