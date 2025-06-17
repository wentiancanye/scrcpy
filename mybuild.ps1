#!/usr/bin/pwsh
$env:http_proxy = "http://192.168.1.100:10809"
$env:https_proxy = "http://192.168.1.100:10809"

$regex = [regex]::new("(?<=VERSION=)\d+\.\d+(?:\.\d+)?")

$filePath = "app/deps/ffmpeg.sh"
$content = Get-Content $filePath -Raw
$match = $regex.Match($content)
if (!$match.Success) {
    Write-Host -ForegroundColor Red "未从[$filePath]中匹配到版本，即将退出！"
    exit
}
$ffmpegVer = $match.Value
Write-Host -ForegroundColor Green "从[$filePath]中匹配到版本[$ffmpegVer]"

$filePath = "app/deps/sdl.sh"
$content = Get-Content $filePath -Raw
$match = $regex.Match($content)
if (!$match.Success) {
    Write-Host -ForegroundColor Red "未从[$filePath]中匹配到版本，即将退出！"
    exit
}
$sdlVer = $match.Value
Write-Host -ForegroundColor Green "从[$filePath]中匹配到版本[$sdlVer]"

$ffmpegUrl = "https://github.com/GyanD/codexffmpeg/releases/download/${ffmpegVer}/ffmpeg-${ffmpegVer}-full_build-shared.zip"
$sdlUrl = "https://github.com/libsdl-org/SDL/releases/download/release-${sdlVer}/SDL2-devel-${sdlVer}-mingw.tar.gz"

$sharedPath = "app/deps/work/install/win64-cross-shared"
Remove-Item $sharedPath -Recurse -Force
New-Item -Force -ItemType Directory $sharedPath
Write-Host -ForegroundColor Green "即将下载[$ffmpegUrl]"
$ffmpegFile = $ffmpegUrl.Split("/")[-1]
wget -O "$sharedPath/$ffmpegFile" $ffmpegUrl
Write-Host -ForegroundColor Green "即将下载[$sdlUrl]"
$sdlFile = $sdlUrl.Split("/")[-1]
wget -O "$sharedPath/$sdlFile" $sdlUrl

Set-Location $sharedPath

unzip $ffmpegFile
Move-Item "ffmpeg-${ffmpegVer}-full_build-shared/bin" ./
Move-Item "ffmpeg-${ffmpegVer}-full_build-shared/lib" ./
Move-Item "ffmpeg-${ffmpegVer}-full_build-shared/include" ./

tar -zxvf $sdlFile
Move-Item "SDL2-${sdlVer}/x86_64-w64-mingw32/bin/*" ./bin/
Move-Item "SDL2-${sdlVer}/x86_64-w64-mingw32/lib/*" ./lib/
Move-Item "SDL2-${sdlVer}/x86_64-w64-mingw32/include/*" ./include/
Move-Item "SDL2-${sdlVer}/x86_64-w64-mingw32/share" ./

Set-Location -
Copy-Item pkgconfig/libavcodec.pc app/deps/work/install/win64-cross-shared/lib/pkgconfig/
Copy-Item pkgconfig/libavformat.pc app/deps/work/install/win64-cross-shared/lib/pkgconfig/
Copy-Item pkgconfig/libavutil.pc app/deps/work/install/win64-cross-shared/lib/pkgconfig/
Copy-Item pkgconfig/libswresample.pc app/deps/work/install/win64-cross-shared/lib/pkgconfig/

Remove-Item ffmpeg-* -Recurse -Force
Remove-Item SDL2-* -Recurse -Force

Set-Location release
./build_windows.sh 64
