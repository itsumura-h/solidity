FROM ubuntu:24.04

# prevent timezone dialogue
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y \
  git \
  curl \
  xz-utils \
  ca-certificates
RUN apt autoremove -y

# nodejs
WORKDIR /root

# https://nodejs.org/en/download/prebuilt-binaries
ARG NODE_VERSION=22.12.0
RUN curl -OL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz
RUN tar -xvf node-v${NODE_VERSION}-linux-x64.tar.xz
RUN rm node-v${NODE_VERSION}-linux-x64.tar.xz
RUN mv node-v${NODE_VERSION}-linux-x64 .node
ENV PATH $PATH:/root/.node/bin

# pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | bash -
ENV PATH $PATH:/root/.local/share/pnpm

# foundry
RUN curl -L https://foundry.paradigm.xyz | bash
ENV PATH=/root/.foundry/bin/:$PATH
RUN foundryup

RUN git config --global --add safe.directory /application
WORKDIR /application
