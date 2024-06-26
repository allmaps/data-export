FROM ubuntu:22.04

RUN apt-get update \
  && apt-get -y install build-essential libsqlite3-dev zlib1g-dev \
  rclone git wget jq

RUN git clone https://github.com/felt/tippecanoe.git tippecanoe
RUN cd tippecanoe \
  && make \
  && make install

COPY config/* /allmaps/config/
COPY src/* /allmaps/src/
COPY data/* /allmaps/data/

WORKDIR /allmaps

ENTRYPOINT ["src/run.sh"]
