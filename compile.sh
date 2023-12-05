#!/bin/sh

if [ -f "/.dockerenv" ] || [ -f "/.dockerinit" ]; then
  OTSERVER_PATH=/otserver
  mkdir -p "$OTSERVER_PATH/build"
  cd "$OTSERVER_PATH/build"
  cmake -DUSE_MYSQL=On ..
  make -j${1:-$(nproc)}
else
  echo "# Running command on docker container 'ots'"
  docker exec -it ots compile.sh $1
fi
