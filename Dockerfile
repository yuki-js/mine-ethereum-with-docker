FROM ubuntu:20.04

WORKDIR /
ENV DEBIAN_FRONTEND=noninteractive

# install deps
RUN apt-get update
RUN apt upgrade -y
RUN apt install -y wget curl build-essential libdbus-1-dev mesa-common-dev git software-properties-common cmake

# install CUDA toolkit
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
RUN mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
RUN add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
RUN apt-get update
RUN apt-get install -y cuda
RUN apt-get install -y cuda-drivers


# clone repo & build
RUN git clone https://github.com/ethereum-mining/ethminer.git
WORKDIR /ethminer
RUN git submodule update --init --recursive
RUN mkdir build
WORKDIR /ethminer/build
RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.66.0/source/boost_1_66_0.7z -P $HOME/.hunter/_Base/Download/Boost/1.66.0/075d0b4
RUN cmake ..
RUN cmake --build . -j
RUN make install
RUN ethminer -V

ENTRYPOINT ["ethminer"]
CMD ["-U","-P","stratum2+tcp://missmonacoin.001:123456@ethash.poolbinance.com:1800"]
