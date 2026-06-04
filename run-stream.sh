#!/bin/bash

# ---- Stream profile: resolution and throughput ----------------------------
# Default (high-res): 2880x1620 at 25 fps, ~2 Mbps.
#WIDTH=2880
#HEIGHT=1620
#FRAMERATE=25
#BITRATE=2000   # kbps

# Low-res profile: uncomment to use 1280x720 at 25 fps, ~1 Mbps.
WIDTH=1280
HEIGHT=720
FRAMERATE=25
BITRATE=1000   # kbps
# ----------------------------------------------------------------------------

# Set to true for H.265/HEVC, false for H.264/AVC
USE_H265=false

if [ "$USE_H265" = true ]; then
    ENCODER="x265enc speed-preset=ultrafast tune=zerolatency key-int-max=50 bitrate=$BITRATE"
    CAPS="video/x-h265,profile=main"
    PAYLOADER="rtph265pay name=pay0 pt=96"
else
    ENCODER="x264enc speed-preset=ultrafast tune=zerolatency bframes=0 ref=1 key-int-max=50 bitrate=$BITRATE pass=cbr vbv-buf-capacity=2000"
    CAPS="video/x-h264,profile=baseline"
    PAYLOADER="rtph264pay name=pay0 pt=96"
fi

# 16 streams at /live/1/1, /live/1/2, ... /live/1/16:
gst-rtsp-launch --streams 16 --path-pattern "/live/1/%%CHANNEL%%" "( \
    videotestsrc is-live=1 \
    ! video/x-raw,width=$WIDTH,height=$HEIGHT,framerate=$FRAMERATE/1,format=I420 \
    ! clockoverlay halignment=right valignment=bottom font-desc=\"Sans, 36\" \
    ! $ENCODER \
    ! $CAPS \
    ! $PAYLOADER \
    audiotestsrc is-live=1 wave=silence \
    ! audio/x-raw,rate=8000,channels=1,format=S16LE \
    ! mulawenc \
    ! rtppcmupay name=pay1 pt=0 \
  )"
