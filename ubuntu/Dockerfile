FROM ubuntu:latest
LABEL maintainer="Junliang HU <jlhu@cse.cuhk.edu.hk>"
ENV http_proxy=http://proxy.cse.cuhk.edu.hk:8000
ENV https_proxy=${http_proxy}
ENV ftp_proxy=${http_proxy}
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Hong_Kong
# apt proxy
RUN sed -i 's/archive.ubuntu.com/ftp.cuhk.edu.hk\/pub\/Linux/g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/ftp.cuhk.edu.hk\/pub\/Linux/g' /etc/apt/sources.list \
    && echo "Acquire::http::Proxy \"${http_proxy}\";\nAcquire::https::Proxy \"${https_proxy}/\";" > /etc/apt/apt.conf.d/99proxy
# utils
RUN apt-get update && apt-get install -y software-properties-common lsb-release apt-utils wget bash sudo curl git zsh build-essential neovim unzip \
    && rm -rf /var/lib/apt/lists/* \    
    && update-alternatives --set editor /usr/bin/nvim \
    && echo "https_proxy = ${https_proxy}\nhttp_proxy = ${http_proxy}\nftp_proxy = ${ftp_proxy}" >> /etc/wgetrc 
# # gcc-11
# RUN  add-apt-repository ppa:ubuntu-toolchain-r/test && sudo apt-get update && apt-get install -y gcc-11 \
#     && rm -rf /var/lib/apt/lists/* 
# # llvm 14
# ENV llvm_version=14
# RUN wget https://apt.llvm.org/llvm.sh && bash llvm.sh ${llvm_version} && rm llvm.sh \
#     && sudo apt-get update && apt-get install -y clang-format clang-tidy \
#     && rm -rf /var/lib/apt/lists/* 
# additional tools
RUN apt-get update && apt-get install -y aria2 bmon cmake doxygen gnuplot-nox golang htop httrack hugo neofetch imagemagick ninja-build nmap pandoc parallel poppler-utils tmux \
    && rm -rf /var/lib/apt/lists/* 
# create user
RUN useradd --create-home --shell /usr/bin/zsh --groups sudo jlhu \
    && echo "jlhu:jlhu" | chpasswd
ENV TERM xterm-256color
USER jlhu
WORKDIR /home/jlhu
# zsh setup
COPY ubuntu.zsh .zshrc
# install all plugins and wait for zinit iced plugin to load
RUN zsh -ic 'zinit creinstall rust; zinit compinit'
CMD zsh
