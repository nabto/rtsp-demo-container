FROM debian:bookworm

RUN apt update && apt install -y git gcc build-essential autoconf libtool pkg-config  cmake libgstrtspserver-1.0-dev libglib2.0-dev libgstreamer1.0-dev gstreamer1.0-plugins-ugly

WORKDIR /tmp
RUN git clone https://github.com/nabto/edge-device-webrtc && cd edge-device-webrtc && git checkout 2aad0e1fdfc3f34ce42e87716f3470ae99d5e3a9

WORKDIR /tmp/edge-device-webrtc/test-apps/rtsp-server/_build
RUN cmake ..
RUN make -j 8 install

EXPOSE 8554
COPY run-stream.sh /usr/bin/
RUN chmod +x /usr/bin/run-stream.sh

CMD [ "run-stream.sh" ]
