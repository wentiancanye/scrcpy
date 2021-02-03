#!/bin/sh
meson x --buildtype release --strip -Db_lto=true -Dcrossbuild_windows=true --cross-file=cross_win64.txt -Dcompile_server=false -Dcompile_app=true -Dportable=true
ninja -Cx
