#!/bin/bash

function try () {
"$@" || exit -1
}
ANDROID_NDK_HOME=/opt/android/sdk/ndk/21.4.7075529
[ -z "$ANDROID_NDK_HOME" ] && ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
TOOLCHAIN=$(find $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/* -maxdepth 1 -type d -print -quit)/bin

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MIN_API=$1
TARGET=$DIR/bin

try mkdir -p $TARGET/armeabi-v7a $TARGET/x86 $TARGET/arm64-v8a $TARGET/x86_64

export GOPATH=$DIR

pushd $DIR/kcptun/client

if [ ! -f "$TARGET/armeabi-v7a/libkcptun.so" ] || [ ! -f "$TARGET/arm64-v8a/libkcptun.so" ] ||
   [ ! -f "$TARGET/x86/libkcptun.so" ] || [ ! -f "$TARGET/x86_64/libkcptun.so" ]; then

    echo "Get dependences for kcptun"
    go get -v
    echo "Cross compile kcptun for arm"
    if [ ! -f "$TARGET/armeabi-v7a/libkcptun.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/armv7a-linux-androideabi${MIN_API}-clang GOOS=android GOARCH=arm GOARM=7 go build -ldflags="-s -w"
        strip_exe=arm-linux-androideabi-strip
        try $TOOLCHAIN/${strip_exe} client
        try mv client $TARGET/armeabi-v7a/libkcptun.so
    fi

    echo "Cross compile kcptun for arm64"
    if [ ! -f "$TARGET/arm64-v8a/libkcptun.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/aarch64-linux-android${MIN_API}-clang GOOS=android GOARCH=arm64 go build -ldflags="-s -w"
        strip_exe=aarch64-linux-android-strip
        try $TOOLCHAIN/${strip_exe} client
        try mv client $TARGET/arm64-v8a/libkcptun.so
    fi

    echo "Cross compile kcptun for 386"
    if [ ! -f "$TARGET/x86/libkcptun.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/i686-linux-android${MIN_API}-clang GOOS=android GOARCH=386 go build -ldflags="-s -w"
        strip_exe=i686-linux-android-strip
        try $TOOLCHAIN/${strip_exe} client
        try mv client $TARGET/x86/libkcptun.so
    fi

    echo "Cross compile kcptun for amd64"
    if [ ! -f "$TARGET/x86_64/libkcptun.so" ]; then
        try env CGO_ENABLED=1 CC=$TOOLCHAIN/x86_64-linux-android${MIN_API}-clang GOOS=android GOARCH=amd64 go build -ldflags="-s -w"
        strip_exe=x86_64-linux-android-strip
        try $TOOLCHAIN/${strip_exe} client
        try mv client $TARGET/x86_64/libkcptun.so
    fi

    popd

fi

echo "Successfully build kcptun"
