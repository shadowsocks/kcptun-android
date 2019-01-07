## kcptun for Android

[![CircleCI](https://circleci.com/gh/shadowsocks/kcptun-android.svg?style=svg)](https://circleci.com/gh/shadowsocks/kcptun-android)
[![API](https://img.shields.io/badge/API-21%2B-brightgreen.svg?style=flat)](https://android-arsenal.com/api?level=21)
[![Releases](https://img.shields.io/github/downloads/shadowsocks/kcptun-android/total.svg)](https://github.com/shadowsocks/kcptun-android/releases)
[![Language: Kotlin](https://img.shields.io/github/languages/top/shadowsocks/kcptun-android.svg)](https://github.com/shadowsocks/kcptun-android/search?l=kotlin)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/46b34df6fe624ef9a46507126f407880)](https://www.codacy.com/app/shadowsocks/kcptun-android?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=shadowsocks/kcptun-android&amp;utm_campaign=Badge_Grade)
[![License](https://img.shields.io/github/license/shadowsocks/kcptun-android.svg)](https://github.com/shadowsocks/kcptun-android/blob/master/LICENSE)

[kcptun](https://github.com/shadowsocks/kcptun) plugin for [shadowsocks-android](https://github.com/shadowsocks/shadowsocks-android).

<a href="https://play.google.com/store/apps/details?id=com.github.shadowsocks.plugin.kcptun"><img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" height="48"></a>

### PREREQUISITES

* JDK 1.8
* Go 1.11+
* Android SDK
  - Android NDK r19+

### BUILD

You can check whether the latest commit builds under UNIX environment by checking CI status.

* Set environment variable `ANDROID_HOME` to `/path/to/android-sdk`
* (optional) Set environment variable `ANDROID_NDK_HOME` to `/path/to/android-ndk` (default: `$ANDROID_HOME/ndk-bundle`)
* Clone the repo using `git clone --recurse-submodules <repo>` or update submodules using `git submodule update --init --recursive`
* Build it using Android Studio or gradle script

### TRANSLATE

This plugin is an official plugin thus you can see [shadowsocks-android](https://github.com/shadowsocks/shadowsocks-android/blob/master/README.md#translate)'s instructions to translate this plugin's UI.

## OPEN SOURCE LICENSES

<ul>
    <li>kcptun: <a href="https://github.com/shadowsocks/kcptun/blob/shadowsocks/LICENSE.md">MIT</a></li>
</ul>

### LICENSE

Copyright (C) 2017 by Max Lv <<max.c.lv@gmail.com>>  
Copyright (C) 2017 by Mygod Studio <<contact-shadowsocks-android@mygod.be>>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
