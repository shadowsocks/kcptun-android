#!/bin/bash

function try () {
"$@" || exit -1
}

[ -z "$ANDROID_NDK_HOME" ] && ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MIN_API=$1
TARGET=$DIR/bin
DEPS=$(pwd)/.deps

ANDROID_ARM_TOOLCHAIN=$DEPS/android-toolchain-${MIN_API}-arm
ANDROID_ARM64_TOOLCHAIN=$DEPS/android-toolchain-${MIN_API}-arm64
ANDROID_X86_TOOLCHAIN=$DEPS/android-toolchain-${MIN_API}-x86

ANDROID_ARM_CC=$ANDROID_ARM_TOOLCHAIN/bin/arm-linux-androideabi-clang
ANDROID_ARM_STRIP=$ANDROID_ARM_TOOLCHAIN/bin/arm-linux-androideabi-strip

ANDROID_ARM64_CC=$ANDROID_ARM64_TOOLCHAIN/bin/aarch64-linux-android-clang
ANDROID_ARM64_STRIP=$ANDROID_ARM64_TOOLCHAIN/bin/aarch64-linux-android-strip

ANDROID_X86_CC=$ANDROID_X86_TOOLCHAIN/bin/i686-linux-android-clang
ANDROID_X86_STRIP=$ANDROID_X86_TOOLCHAIN/bin/i686-linux-android-strip

try mkdir -p $DEPS $TARGET/armeabi-v7a $TARGET/x86 $TARGET/arm64-v8a

if [ ! -d "$ANDROID_ARM_TOOLCHAIN" ]; then
    echo "Make standalone toolchain for ARM arch"
    $ANDROID_NDK_HOME/build/tools/make_standalone_toolchain.py --arch arm \
        --api $MIN_API --install-dir $ANDROID_ARM_TOOLCHAIN
fi

if [ ! -d "$ANDROID_ARM64_TOOLCHAIN" ]; then
    echo "Make standalone toolchain for ARM64 arch"
    $ANDROID_NDK_HOME/build/tools/make_standalone_toolchain.py --arch arm64 \
        --api 21 --install-dir $ANDROID_ARM64_TOOLCHAIN
fi

if [ ! -d "$ANDROID_X86_TOOLCHAIN" ]; then
    echo "Make standalone toolchain for X86 arch"
    $ANDROID_NDK_HOME/build/tools/make_standalone_toolchain.py --arch x86 \
        --api $MIN_API --install-dir $ANDROID_X86_TOOLCHAIN
fi

if [ ! -d "$DIR/go/bin" ]; then
    echo "Build the custom go"

    pushd $DIR/go/src
    try ./make.bash
    popd
fi

export GOROOT=$DIR/go
export GOPATH=$DEPS/gopath
export GOBIN=$GOPATH/bin
mkdir -p $GOBIN
export PATH=$GOROOT/bin:$PATH

pushd $DIR/kcptun/client

if [ ! -f "$TARGET/armeabi-v7a/libkcptun.so" ] || [ ! -f "$TARGET/arm64-v8a/libkcptun.so" ] ||
   [ ! -f "$TARGET/x86/libkcptun.so" ]; then

    echo "Get dependences for kcptun"
    go get -u github.com/xtaci/kcp-go
    go get -u github.com/xtaci/smux
    go get

    echo "Cross compile kcptun for arm"
    if [ ! -f "$TARGET/armeabi-v7a/liboverture.so" ]; then
        try env CGO_ENABLED=1 CC=$ANDROID_ARM_CC GOOS=android GOARCH=arm GOARM=7 go build -ldflags="-s -w"
        try $ANDROID_ARM_STRIP client
        try mv client $TARGET/armeabi-v7a/libkcptun.so
    fi

    echo "Cross compile kcptun for arm64"
    if [ ! -f "$TARGET/arm64-v8a/liboverture.so" ]; then
        try env CGO_ENABLED=1 CC=$ANDROID_ARM64_CC GOOS=android GOARCH=arm64 go build -ldflags="-s -w"
        try $ANDROID_ARM64_STRIP client
        try mv client $TARGET/arm64-v8a/libkcptun.so
    fi

    echo "Cross compile kcptun for x86"
    if [ ! -f "$TARGET/x86/liboverture.so" ]; then
        try env CGO_ENABLED=1 CC=$ANDROID_X86_CC GOOS=android GOARCH=386 go build -ldflags="-s -w"
        try $ANDROID_X86_STRIP client
        try mv client $TARGET/x86/libkcptun.so
    fi

    popd

fi

echo "Successfully build kcptun"
