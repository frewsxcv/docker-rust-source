FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
  cmake \
  curl \
  g++ \
  git \
  file \
  libssl-dev \
  python

WORKDIR /opt
RUN git clone https://github.com/rust-lang/rust.git
WORKDIR /opt/rust
RUN ./configure --enable-optimize --disable-docs
RUN make -j 8
ENV PATH $PATH:/opt/rust/x86_64-unknown-linux-gnu/stage2/bin
ENV LLVM_CONFIG /opt/rust/x86_64-unknown-linux-gnu/llvm/bin/llvm-config

WORKDIR /opt
RUN git clone https://github.com/rust-lang/cargo
WORKDIR /opt/cargo
RUN ./configure --local-rust-root=/opt/rust/x86_64-unknown-linux-gnu/stage2/ --enable-optimize
RUN make -j 8
ENV PATH $PATH:/opt/cargo/target/x86_64-unknown-linux-gnu/release
