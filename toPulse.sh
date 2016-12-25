#!/bin/bash

#Switches back to the normal pulseaudio driver from the jack server that's started at login.

jack_control exit && pulseaudio -k && pulseaudio -D
