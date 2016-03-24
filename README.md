# Docker Libvips

**[Libvips](https://github.com/jcupitt/libvips)** Docker image with Ubuntu 14.04 as base image

**Libvips** and critical libs (libjpeg-turbo, libtiff, libgif, libpng, libwebp) are built from source

> Note that some libvips features are disabled (Python binding, ImageMagick, PangoFT2, MatIO, CFITSIO, OpenEXR, OpenSlide, libPoppler, libRSVG)

## Usage

```bash
$ docker run --rm -ti creativearea/libvips vips -v
```
