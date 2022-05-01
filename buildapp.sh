#!/bin/sh
# 编译之前根据release.mk的dist-win64或dist-win32节中需要的ffmpeg和SDL2下载相应的版本放入prebuilt-deps文件夹中
# 也可以根据cross_win64.txt和cross_win64.txt中的properties节中需要的版本进行下载,放入prebuilt-deps文件夹中
# 但是现在(2021-03-28)ffmpeg已经不再提供32位版本,并且dev和shared已经合并,可以直接下载shared版本,将其拷贝为deV
# 但是当只有当prepare-win64失效时才需要手动下载

#cd prebuilt-deps/
#make prepare-win64
#cd ..
#meson x --buildtype release --strip -Db_lto=true -Dcrossbuild_windows=true --cross-file=cross_win64.txt -Dcompile_server=false -Dcompile_app=true -Dportable=true
#ninja -Cx

make -f release.mk prepare-deps-win64
make -f release.mk build-win64
cd build-win64/app
ls -l

