#!/bin/bash

release=$1
cp app/build/outputs/apk/release/app-armeabi-v7a-release.apk kcptun-armeabi-v7a-${release}.apk
cp app/build/outputs/apk/release/app-arm64-v8a-release.apk kcptun-arm64-v8a-${release}.apk
cp app/build/outputs/apk/release/app-x86-release.apk kcptun-x86-${release}.apk
cp app/build/outputs/apk/release/app-x86_64-release.apk kcptun-x86_64-${release}.apk
cp app/build/outputs/apk/release/app-universal-release.apk kcptun--universal-${release}.apk
