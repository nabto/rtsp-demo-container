FROM debian:bookworm

RUN apt update && apt install -y git gcc g++ build-essential autoconf libtool pkg-config  cmake libgstrtspserver-1.0-dev libglib2.0-dev libgstreamer1.0-dev gstreamer1.0-plugins-ugly

WORKDIR /tmp
RUN git clone https://github.com/nabto/edge-device-webrtc

WORKDIR /tmp/edge-device-webrtc/test-apps/rtsp-server/_build
RUN cmake -DCMAKE_MAKE_PROGRAM=/usr/bin/make -DCMAKE_CXX_COMPILER=/usr/bin/g++ .. 
RUN make -j 8 install

EXPOSE 8554
COPY run-stream.sh /usr/bin/
RUN chmod +x /usr/bin/run-stream.sh

CMD [ "run-stream.sh" ]
