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
RUN curl -o cargo.tar.gz https://static.rust-lang.org/cargo-dist/cargo-nightly-x86_64-unknown-linux-gnu.tar.gz \
  && tar xf cargo.tar.gz \
  && sh cargo-nightly-x86_64-unknown-linux-gnu/install.sh \
  && rm -rf cargo.tar.gz cargo-nightly-x86_64-unknown-linux-gnu
