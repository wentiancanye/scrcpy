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

# 如果报错找不到 pkg-config 或其他的，时因为meson版本低了
# 运行下面的命令：
#sudo apt remove -y meson
#sudo pip3 install --upgrade meson

#2024-05-21 00:01:56
# 编译 scrcpy 需要安装 nasm 和 yasm —— SDL
# ffmpeg 编译命令 去掉 eanble zlib

#make -f release.mk prepare-deps-win64
#make -f release.mk build-win64
#cd build-win64/app
#ls -l

# 2024-11-28 03:21:49 编译新方法
# 创建 app/deps/work/install/win64-cross-shared
# 注释 release/build_windows.sh 里面的 sdl 和 ffmpeg 的内容
# 下载 变更版本 https://github.com/GyanD/codexffmpeg/releases/download/7.1/ffmpeg-7.1-full_build-shared.7z
# 下载 变更版本 https://github.com/libsdl-org/SDL/releases/download/release-2.30.9/SDL2-devel-2.30.9-mingw.tar.gz
# 复制 原来的 app/deps/work/install/win64-cross-shared/lib/pkgconfig 下面的 libavcodec.pc  libavformat.pc  libavutil.pc  libswresample.pc 到 app/deps/work/install/win64-cross-shared/lib/pkgconfig
# 项目根目录下面的 pkgconfig 可以做参考
# 然后编译即可
cd release
./build_windows.sh 64
