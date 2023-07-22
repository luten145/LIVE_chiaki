#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")/..
cd "./$1"
shift
ROOT="`pwd`"

TAG=n4.3.1

export PATH="/c/msys64/mingw64/bin:${PATH}"
export PATH="/c/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64:$PATH"
export CC="/c/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.29.30133/bin/Hostx64/x64/cl.exe"

git clone https://git.ffmpeg.org/ffmpeg.git --depth 1 -b $TAG && cd ffmpeg || exit 1

./configure --disable-all --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_vaapi --enable-hwaccel=hevc_vaapi --prefix="$ROOT/ffmpeg-prefix" "$@" || exit 1
make -j4 || exit 1
make install || exit 1
