FROM alpine:3.10 as builder
LABEL maintainer "Chinthaka Deshapriya <chinthaka@cybergate.lk>"
RUN apk add --no-cache \
    gperf \
    alpine-sdk \
    openssl-dev \
    git \
    cmake \
    zlib-dev \
    linux-headers

WORKDIR /tmp/_build_tdlib/

RUN git clone https://github.com/tdlib/td.git /tmp/_build_tdlib/

RUN mkdir build
WORKDIR /tmp/_build_tdlib/build/

RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN cmake --build .
RUN make install

FROM alpine:3.10

COPY --from=builder /usr/local/lib/libtd* /usr/local/lib/

RUN apk add --no-cache \
    openssl-dev \
    git \
    cmake \
    zlib-dev
