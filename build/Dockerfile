FROM debian:bookworm-20250630-slim
ARG UID
ARG GID
ARG USER_NAME
ARG DIR_PATH

# For python2
RUN echo "deb http://deb.debian.org/debian bullseye main" > /etc/apt/sources.list.d/bullseye.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main" >> /etc/apt/sources.list.d/bullseye.list

RUN apt-get update && \ 
    apt-get install -y sudo build-essential chrpath cpio debianutils \
    diffstat expect file gcc git iputils-ping libacl1 liblz4-tool \
    locales python3 python3-git python3-jinja2 python3-pexpect \
    python3-subunit socat texinfo unzip wget xz-utils zstd git-core \
    gnupg flex bison gperf build-essential zip curl zlib1g-dev \
    libncurses5-dev x11proto-core-dev libx11-dev libz-dev \
    libxml-simple-perl libc6-dev libgl1-mesa-dev tofrodos libxml2-utils \
    xsltproc genisoimage gawk chrpath texinfo p7zip-full \
    android-sdk-libsparse-utils mime-support ruby subversion libssl-dev \
    protobuf-compiler pkg-config nano libtinfo5 ninja-build clang ccache \
    libc++-dev rsync cmake automake libtool

RUN apt-get install -y -t bullseye libssl1.1 libffi7

RUN ln -sf /bin/bash /bin/sh
RUN useradd -ms /bin/bash ${USER_NAME} && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
RUN usermod -u ${UID} ${USER_NAME} && groupmod -g ${GID} ${USER_NAME}

RUN set -e; \
    arch="$(dpkg --print-architecture)"; \
    for url in \
"https://github.com/upx/upx/releases/download/v5.0.0/upx-5.0.0-${arch}_linux.tar.xz" \
"https://go.dev/dl/go1.24.4.linux-${arch}.tar.gz" \
"http://ftp.debian.org/debian/pool/main/p/python2.7/libpython2.7-minimal_2.7.18-8+deb11u1_${arch}.deb" \
"http://ftp.debian.org/debian/pool/main/p/python2.7/python2.7-minimal_2.7.18-8+deb11u1_${arch}.deb" \
"http://ftp.debian.org/debian/pool/main/p/python2.7/libpython2.7-stdlib_2.7.18-8+deb11u1_${arch}.deb" \
"http://ftp.debian.org/debian/pool/main/p/python2.7/python2.7_2.7.18-8+deb11u1_${arch}.deb"; \
    do \
        wget -q "$url"; \
    done && \
    tar -zxf go1.24.4.linux-${arch}.tar.gz && \
    tar -xvf upx-5.0.0-${arch}_linux.tar.xz && \
    mv upx-5.0.0-${arch}_linux/upx /usr/bin/ && \
    dpkg -i *.deb && \
    rm -f *.deb *.tar.gz *.tar.xz

RUN mv go /usr/local/
RUN ln -sf /usr/local/go/bin/go /usr/bin/go
RUN mkdir /root/go
RUN wget https://github.com/ccache/ccache/releases/download/v4.11.3/ccache-4.11.3-linux-x86_64.tar.xz
RUN tar -xf ccache-4.11.3-linux-x86_64.tar.xz
RUN mv ccache-4.11.3-linux-x86_64/ccache /usr/bin/
RUN chmod +x /usr/bin/ccache
RUN chmod 0755 /usr/bin/upx
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN ln -sf /usr/bin/python2.7 /usr/bin/python2
RUN chmod 0755 /usr/local/bin
RUN ln -sf /usr/bin/ninja /usr/local/bin/ninja

USER ${USER_NAME}
WORKDIR ${DIR_PATH}
CMD ["/bin/bash"]