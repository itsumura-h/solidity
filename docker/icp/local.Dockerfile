FROM ubuntu:22.04

# prevent timezone dialogue
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y \
      xz-utils \
      curl \
      git \
      vim \
      libunwind-dev
RUN apt autoremove -y

WORKDIR /root

# nodejs
# https://nodejs.org/en/download/prebuilt-binaries
ARG NODE_VERSION=v20.16.0
RUN curl -OL https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz
RUN tar -xvf node-${NODE_VERSION}-linux-x64.tar.xz
RUN rm node-${NODE_VERSION}-linux-x64.tar.xz
RUN mv node-${NODE_VERSION}-linux-x64 .node
ENV PATH /root/.node/bin:$PATH
ENV PATH /application/src/icp/node_modules/.bin:$PATH

# pnpm
RUN curl -fsSL https://get.pnpm.io/install.sh | bash -s -- -y

WORKDIR /application/src/icp

# install icp after docker container is running
# sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
