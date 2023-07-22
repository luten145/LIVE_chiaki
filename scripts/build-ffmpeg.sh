#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")/..
cd "./$1"
shift
ROOT="`pwd`"

TAG=n4.3.1



DIR="ffmpeg"

if [ -d "$DIR" ]; then
  echo "$DIR exists."
  # 디렉터리가 존재하면 실행할 명령어를 여기에 작성하세요.
    
make -j4 || exit 1
make install || exit 1
else
  echo "$DIR does not exist."
  # 디렉터리가 존재하지 않으면 실행할 명령어를 여기에 작성하세요.
  git clone https://git.ffmpeg.org/ffmpeg.git --depth 1 -b $TAG && cd ffmpeg || exit 1

  ./configure --disable-all --enable-avcodec --enable-decoder=h264 --enable-decoder=hevc --enable-hwaccel=h264_vaapi --enable-hwaccel=hevc_vaapi --prefix="$ROOT/ffmpeg-prefix" "$@" || exit 1
make -j4 || exit 1
make install || exit 1

fi

