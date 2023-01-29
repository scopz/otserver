#!/bin/bash

OTSERVER_PATH=/otserver

mkdir -p "$OTSERVER_PATH/build"
cd "$OTSERVER_PATH/build"
cmake -DUSE_MYSQL=On ..
make -j$(nproc)