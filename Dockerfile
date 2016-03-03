# --privileged=trueをつけてrunしないと動かない
FROM ubuntu:15.10

MAINTAINER chocoyama

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y build-essential wget clang libedit-dev python2.7 python2.7-dev libicu55 rsync libxml2 git && \
    apt-get clean

ENV SWIFT_PACKAGE_NAME swift-2.2-SNAPSHOT-2016-03-01-a-ubuntu15.10

# Swiftを入手
RUN wget https://swift.org/builds/swift-2.2-branch/ubuntu1510/swift-2.2-SNAPSHOT-2016-03-01-a/$SWIFT_PACKAGE_NAME.tar.gz\
         https://swift.org/builds/swift-2.2-branch/ubuntu1510/swift-2.2-SNAPSHOT-2016-03-01-a/$SWIFT_PACKAGE_NAME.tar.gz.sig\
         -P /usr/local/src

# セットアップ
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -
RUN gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
RUN gpg --verify /usr/local/src/$SWIFT_PACKAGE_NAME.tar.gz.sig
RUN tar xzf /usr/local/src/$SWIFT_PACKAGE_NAME.tar.gz -C /usr/local/src

ENV PATH $PATH:/usr/local/src/$SWIFT_PACKAGE_NAME/usr/bin
