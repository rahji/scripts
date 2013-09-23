#!/bin/bash

# finds .wav files in the current directory and
# creates numbered mp3 files from them (001.mp3, etc)

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
let i=0
for f in `ls *wav`; do 
    let i++; 
    lame -h -b 192 $f `printf '%03d' $i`.mp3; 
done
IFS=$SAVEIFS

