# Web Converion Scripts
This repository is for scripts that will help make your content more web friendly. Currently, this involves only one script, to convert images and videos within a folder to either **webm** or **webp**.

To use this script, download it from the repo and move it to the target folder and execute:
```
$ mv ~/Downloads/web-conversion.bash /my/target/directory
$ bash web-conversion.bash
```

You will be prompted as to whether you need to keep other content.

## Prerequisites

You will need to have the appropriate command line tools installed:

* [ffmpeg](https://www.webmproject.org/tools/): ```brew install ffmpeg –with-libvpx –with-libvorbis –with-fdk-aacc```
* [cwebp](https://developers.google.com/speed/webp/docs/precompiled)
