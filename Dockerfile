FROM alpine:3.18.5

RUN apk add cmake make g++
RUN apk add mysql-dev sqlite-dev boost-dev gmp-dev lua-dev libxml2-dev

ENV PATH="/otserver:${PATH}"
VOLUME /otserver
WORKDIR /otserver
