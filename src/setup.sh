#!/bin/bash

set -e

apt update && apt upgrade --assume-yes
apt install --assume-yes autoconf git make wget tree g++-5 flex bison texinfo bzip2 xz-utils unzip help2man file gawk libtool-bin libncurses5-dev sudo
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 10
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 10

# user setup
useradd builder
usermod -aG sudo builder
echo "builder ALL=(ALL:ALL) NOPASSWD: ALL" >/etc/sudoers.d/builder

# build ct-ng
mkdir /build && chown builder:builder /build

sudo --user builder sh << EOF
mkdir /build/ct-ng /build/ct-ng-bin
cd /build/ct-ng
wget -qO- "https://github.com/crosstool-ng/crosstool-ng/archive/refs/tags/crosstool-ng-1.25.0-rc1.tar.gz" | tar xvz --strip-components=1
./bootstrap && ./configure --prefix=/build/ct-ng-bin && make -j$(nproc) && make install
EOF
