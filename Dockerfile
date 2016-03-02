FROM ubuntu:15.10

MAINTAINER chocoyama

# 必要なパッケージのインストール
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install wget clang libicu-dev

ENV SWIFT_PACKAGE_NAME swift-2.2-SNAPSHOT-2016-03-01-a-ubuntu15.10

# Swiftを入手
RUN wget https://swift.org/builds/swift-2.2-branch/ubuntu1510/swift-2.2-SNAPSHOT-2016-03-01-a/$SWIFT_PACKAGE_NAME.tar.gz\
         https://swift.org/builds/swift-2.2-branch/ubuntu1510/swift-2.2-SNAPSHOT-2016-03-01-a/$SWIFT_PACKAGE_NAME.tar.gz.sig\
         -P /usr/local/src

# セットアップ
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -\
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift\
    gpg --verify /usr/local/src/$SWIFT_PACKAGE_NAME.tar.gz.sig\
    tar xzf /usr/local/src/$SWIFT_PACKAGE_NAME.tar.gz -C /usr/local/src

ENV PATH $PATH:/usr/local/src/$SWIFT_PACKAGE_NAME/usr/bin
