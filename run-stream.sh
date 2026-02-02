#!/bin/bash

# Single stream example (legacy):
#gst-rtsp-launch --gst-debug-level=3 "( videotestsrc is-live=1 ! clockoverlay halignment=right valignment=bottom font-desc=\"Sans, 36\" ! x264enc speed-preset=ultrafast tune=zerolatency key-int-max=25 ! rtph264pay name=pay0 pt=96 )"

# With authentication:
#gst-rtsp-launch --auth digest --username foo --password bar --gst-debug-level=3 --streams 16 "( videotestsrc is-live=1 ! clockoverlay halignment=right valignment=bottom font-desc=\"Sans, 36\" ! x264enc speed-preset=ultrafast tune=zerolatency ! rtph264pay name=pay0 pt=96 )"

# 16 streams at /live/1/1, /live/2/1, ... /live/16/1 (CBR 2000 kbps):
gst-rtsp-launch --gst-debug-level=3 --streams 16 "( videotestsrc is-live=1 ! clockoverlay halignment=right valignment=bottom font-desc=\"Sans, 36\" ! x264enc speed-preset=ultrafast tune=zerolatency key-int-max=25 bitrate=2000 pass=cbr vbv-buf-capacity=2000 ! rtph264pay name=pay0 pt=96 )"
