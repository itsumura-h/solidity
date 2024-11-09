FROM ubuntu:22.04

# prevent timezone dialogue
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y \
      xz-utils \
      curl \
      git \
      vim
RUN apt autoremove -y

# nodejs
WORKDIR /root
# https://nodejs.org/en/download/prebuilt-binaries
ARG NODE_VERSION=v20.16.0
RUN curl -OL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz
RUN tar -xvf node-${NODE_VERSION}-linux-x64.tar.xz
RUN rm node-${NODE_VERSION}-linux-x64.tar.xz
RUN mv node-${NODE_VERSION}-linux-x64 .node
ENV PATH /root/.node/bin:$PATH
ENV PATH /application/src/solidity/node_modules/.bin:$PATH

# pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | bash -s -- -y

# foundry
RUN curl -L https://foundry.paradigm.xyz | bash
RUN /root/.foundry/bin/foundryup
