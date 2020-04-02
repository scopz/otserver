## Installing required packages

Needed packages:
* git
* cmake
* gcc
* boost library
* lua 5.1 library
* gmp library
* libxml2 library
* luajit library (optional)
* mysql library (optional)
* sqlite library (optional)

For instance, if you have Ubuntu or a Debian based distribution you can install all the required packages with these commands using apt-get:

```sh
sudo apt-get install build-essential cmake git-core
sudo apt-get install libboost-all-dev libgmp3-dev liblua5.1-dev libxml2-dev
```

If you are going to use the default cmake options (it requires mysql, and sqlite), you'll also need the following:

```sh
sudo apt-get install libmysqlclient-dev mysql-server libsqlite3-dev
```

If you are using PostgreSQL, then you need:

```sh
sudo apt-get install libpq-dev libsqlite3-dev
```


## Downloading the sources
```sh
git clone git://github.com/opentibia/server.git
cd server
```

## Configuring

First create a build directory

```sh
mkdir build
cd build
```

### Via CMake command line

To use the default cmake options, just run:
```sh
cmake ..
```

Otherwise you can supply some available options like USE_LUAJIT, USE_MYSQL, USE_SQLITE, USE_CPP11, USE_PCH.
Example:
```sh
cmake -DUSE_LUAJIT=On -DUSE_MYSQL=On -DCMAKE_BUILD_TYPE=Performance ..
```

If you do not have the libraries installed in the default locations, use `-DCMAKE_INCLUDE_PATH=` and `-DCMAKE_LIBRARY_PATH` to specify the search paths.

### Via CMake graphical interface
You can use cmake-gui to configure before bulding, you will be able to change and check build options in the interface.

```sh
cmake-gui ..
```

## Compiling
Stay in the build folder and begin the compilation with make.
```sh
make -j4
```

**TIP**: If you have multiple cores, use -j4 option to build using 4 cores.

## Running
To run the server, just execute the otserv file.
```sh
cd ..
./build/src/otserv
```
