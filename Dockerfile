FROM ubuntu:15.10
MAINTAINER Moritz Heiber <hello@heiber.im>

ENV BUILD_DIR /tmp

ARG version
ARG uid

RUN apt-get update && \
  apt-get -y install checkinstall cmake libgcrypt20-dev libqt5x11extras5-dev make qt4-default qtbase5-dev qttools5-dev qttools5-dev-tools zlib1g-dev curl

WORKDIR ${BUILD_DIR}
RUN curl -L https://www.keepassx.org/releases/${version}/keepassx-${version}.tar.gz | tar xzf - --strip-components=1 && \
  mkdir -p ${BUILD_DIR}/build

WORKDIR ${BUILD_DIR}/build
RUN  cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. && \
  make

RUN echo "magnetikonline: KeePassX v${version}" > description-pak && \
  checkinstall -Dy \
  --install=no \
  --strip \
  --requires="libc6 \(\>= 2.14\),libgcrypt20 \(\>= 1.6.1\),libqtcore4 \(\>= 4:4.8.0\),libqtgui4 \(\>= 4:4.8.0\),libstdc++6 \(\>= 4.1.1\),libx11-6,libxi6,libxtst6,zlib1g \(\>= 1:1.1.4\)" \
  --nodoc \
  --pkgname=keepassx \
  --pkgversion=${version} \
  make -i install

VOLUME /package
RUN useradd --uid ${uid} -mU keepassxbuild
RUN chown keepassxbuild /package

USER keepassxbuild
CMD cp ${BUILD_DIR}/build/keepassx_*-1_amd64.deb /package/
