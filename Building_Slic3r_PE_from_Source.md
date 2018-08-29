This page is a work in progress, please use at your own risk until completed.

Linux
-----

### Ubuntu 18.x and 16.04

```
#!/bin/bash

## Build Slic3r P.E. from source

## install system dependencies

apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cpanminus \
    freeglut3-dev \
    git \
    libboost-all-dev \
    libboost-filesystem-dev \
    libboost-system-dev \
    libboost-thread-dev \
    libcurl4-openssl-dev \
    libeigen3-dev \
    libextutils-cppguess-perl \
    libextutils-typemaps-default-perl \
    libextutils-xspp-perl \
    libglew-dev \
    libgtk2.0-dev \
    liblocal-lib-perl \
    libmodule-build-perl \
    libopengl-perl \
    libtbb-dev \
    libwx-glcanvas-perl \
    libwx-perl \
    libwxgtk-media3.0-dev \
    libwxgtk3.0-dev \
    libxmu-dev \
    libxmu-dev \
    wx-common 

## WX requires a X DISPLAY to run its tests.   Configure this appropriately
## if you plan on build with gui funcionality
#export DISPLAY=:0.0
export DISPLAY=192.168.5.33:0.0

## if compiling headless add these: 
## apt-get install -y mesa-utils and libgl1-mesa-glx

## clone Slic3r from Prusa3d
git clone https://github.com/prusa3d/Slic3r.git
cd Slic3r
git checkout -b origin/master

export LDLOADLIBS=-lstdc++
perl Build.PL
perl Build.PL --gui

mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make
ctest --verbose
```