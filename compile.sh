#!/bin/bash

if [ -f "/.dockerenv" ] || [ -f "/.dockerinit" ]; then
  OTSERVER_PATH=/otserver
  mkdir -p "$OTSERVER_PATH/build"
  cd "$OTSERVER_PATH/build"
  cmake -DUSE_MYSQL=On ..
  make -j$(nproc)
else
  echo "# Running command on docker container 'ots'"
  docker exec ots /otserver/compile.sh
fi
