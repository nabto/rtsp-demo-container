# RTSP test service

A container for hosting a simple RTSP test stream.

## Build container

```
docker build -t rtsp-demo-server .
```

## Run

```
docker run --rm -it -p 8554:8554 rtsp-demo-server
```

## Debug

First start interactive session:

```
docker run --rm -p8554:8554 -it rtsp-demo-server bash
```

Then manually run the service:

```
$ gst-rtsp-launch --gst-debug-level=3 "( videotestsrc is-live=1 ! clockoverlay halignment=right valignment=bottom font-desc=\"Sans, 36\" ! x264enc speed-preset=ultrafast tune=zerolatency ! rtph264pay name=pay0 pt=96 )"
```

## Test

```
ffplay  -probesize 32 -sync ext -rtsp_flags prefer_tcp rtsp://127.0.0.1:8554/video
```
