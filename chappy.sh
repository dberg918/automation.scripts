#!/bin/bash

if [ ! -f "$1" ]; then
    echo
    echo "Gimme a real file, kthnx."
    exit
fi

CHAPTERS=${1:0:-4}.chapters
VTT=${1:0:-4}.vtt

echo "WEBVTT" > $VTT
> $CHAPTERS
i=1
while IFS= read -r LINE; do
    start_seconds=`echo $LINE | cut -d ' ' -f 1 | rev | cut -c 4- | rev`
    end_seconds=`echo $LINE | cut -d ' ' -f 2 | rev | cut -c 4- | rev`
    chapter_name=`echo $LINE | cut -d ' ' -f 3-`

    sh=`printf %02d $(echo "$start_seconds / 3600" | bc)`
    sm=`printf %02d $(echo "$start_seconds / 60" | bc)`
    ss=`printf %06.3f $(echo "$start_seconds % 60" | bc)`
    eh=`printf %02d $(echo "$end_seconds / 3600" | bc)`
    em=`printf %02d $(echo "$end_seconds / 60" | bc)`
    es=`printf %06.3f $(echo "$end_seconds % 60" | bc)`

    echo -e "\n$i\n$sh:$sm:$ss --> $eh:$em:$es\n$chapter_name" >> $VTT
    echo -e "CHAPTER$i=$sh:$sm:$ss\nCHAPTER"$i"NAME=$chapter_name" >> $CHAPTERS
    ((i=$i+1))
done < $1
