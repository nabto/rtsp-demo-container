FROM debian:bullseye

RUN apt update && apt install -y git gcc build-essential autoconf libtool pkg-config  cmake libgstrtspserver-1.0-dev libglib2.0-dev libgstreamer1.0-dev gstreamer1.0-plugins-ugly

WORKDIR /tmp
RUN git clone https://github.com/sfalexrog/gst-rtsp-launch.git

WORKDIR /tmp/gst-rtsp-launch/_build
RUN cmake ..
RUN make -j install

EXPOSE 8554

ENTRYPOINT [ "gst-rtsp-launch", "( videotestsrc is-live=1 ! clockoverlay halignment=right valignment=bottom font-desc=\"Sans, 36\" ! x264enc speed-preset=ultrafast tune=zerolatency ! rtph264pay name=pay0 pt=96 )" ]
