#!/usr/bin/env bash
if [ -e /tmp/youtube.lock ]
then
  echo " job already running...exiting"
  exit
fi

touch /tmp/youtube.lock

cd ./arm/bin
raspivid -o - -t 0 -ex verylong -fps 25 -b 6000000  -w 1280 -h 720 -a 4 -a "%d-%m-%Y %X" | ./ffmpeg -re -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero -f h264 -i - -vcodec copy -acodec aac -ab 128k -g 50 -strict experimental -f flv rtmp://a.rtmp.youtube.com/live2/dp0m-09jc-hhyx-6z6u
#delete lock file at end of your job

rm /tmp/youtube.lock
