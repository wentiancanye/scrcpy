# On macOS

## Install

### From the official release

Download a static build of the [latest release]:

 - [`scrcpy-macos-v3.0.tar.gz`][direct-macos] (arm64)  
   <sub>SHA-256: `5db9821918537eb3aaf0333cdd05baf85babdd851972d5f1b71f86da0530b4bf`</sub>

[latest release]: https://github.com/Genymobile/scrcpy/releases/latest
[direct-macos]: https://github.com/Genymobile/scrcpy/releases/download/v3.0/scrcpy-macos-v3.0.tar.gz

and extract it.

_Static builds of scrcpy for macOS are still experimental._


### From a package manager

Scrcpy is available in [Homebrew]:

```bash
brew install scrcpy
```

[Homebrew]: https://brew.sh/

You need `adb`, accessible from your `PATH`. If you don't have it yet:

```bash
brew install --cask android-platform-tools
```

Alternatively, Scrcpy is also available in [MacPorts], which sets up `adb` for you:

```bash
sudo port install scrcpy
```

[MacPorts]: https://www.macports.org/

_See [build.md](build.md) to build and install the app manually._


## Run

_Make sure that your device meets the [prerequisites](/README.md#prerequisites)._

Once installed, run from a terminal:

```bash
scrcpy
```

or with arguments (here to disable audio and record to `file.mkv`):

```bash
scrcpy --no-audio --record=file.mkv
```

Documentation for command line arguments is available:
 - `man scrcpy`
 - `scrcpy --help`
 - on [github](/README.md)