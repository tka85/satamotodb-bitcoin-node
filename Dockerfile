FROM ubuntu:18.04
ENV DAEMON_USER_NAME='bitcoin' \
    DAEMON_USER_ID=1000 \
    DAEMON_GROUP_ID=1000

RUN apt-get update && \
    apt-get install build-essential autoconf libtool pkg-config libboost-all-dev libssl-dev libprotobuf-dev protobuf-compiler libevent-dev libqt4-dev libcanberra-gtk-module libdb-dev libdb++-dev bsdmainutils net-tools git jq vim -y && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/* && \
    groupadd -g ${DAEMON_GROUP_ID} ${DAEMON_USER_NAME} && \
    useradd -u ${DAEMON_USER_ID} -g ${DAEMON_USER_NAME} -s /bin/bash -d /opt/${DAEMON_USER_NAME} ${DAEMON_USER_NAME} && \
    usermod -p '*' ${DAEMON_USER_NAME} && usermod -U ${DAEMON_USER_NAME}

# Install bitcoin
RUN VERSION=v0.19.0.1 && \
    mkdir -p /opt/${DAEMON_USER_NAME}/bitcoin-src && \
    git clone https://github.com/bitcoin/bitcoin.git /opt/${DAEMON_USER_NAME}/bitcoin-src && \
    cd /opt/${DAEMON_USER_NAME}/bitcoin-src && \
    git checkout $VERSION && \
    ./autogen.sh && \
    ./configure --with-incompatible-bdb && \
    make && \
    mv /opt/${DAEMON_USER_NAME}/bitcoin-src/src/bitcoind /opt/${DAEMON_USER_NAME}/bitcoin-src/src/bitcoin-cli /opt/${DAEMON_USER_NAME}/bitcoin-src/src/bitcoin-tx /opt/${DAEMON_USER_NAME}/bitcoin-src/src/bitcoin-wallet /usr/local/bin/ && \
    strip /usr/local/bin/bitcoin* && \
    rm -rf /opt/${DAEMON_USER_NAME}/bitcoin-src

# Fix perms
RUN mkdir /opt/${DAEMON_USER_NAME}/.bitcoin && \
    chown -R ${DAEMON_USER_NAME}:${DAEMON_USER_NAME} /opt/${DAEMON_USER_NAME}/
USER ${DAEMON_USER_NAME}
WORKDIR /opt/${DAEMON_USER_NAME}/.bitcoin
