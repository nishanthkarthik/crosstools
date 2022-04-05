#!/bin/bash

set -e

CONFIG=$1
CONFIG_NAME=$(basename "$CONFIG")
WORK_DIR="/build/toolchains/$CONFIG_NAME.d"

mkdir --parents "$WORK_DIR" && cd "$WORK_DIR"
cp "$CONFIG" $PWD/.config
/build/ct-ng-bin/bin/ct-ng build
tar -I zstd -C $PWD/x-tools -caf /build/$CONFIG_NAME.tar.zstd .
