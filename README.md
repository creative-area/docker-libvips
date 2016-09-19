# Docker Libvips


[![](https://images.microbadger.com/badges/image/creativearea/libvips.svg)](https://microbadger.com/images/creativearea/libvips)

**[Libvips](https://github.com/jcupitt/libvips)** Docker image with Ubuntu 14.04 as base image

**Libvips** and critical libs are built from source

> Note that some libvips features are disabled (Python binding, ImageMagick, PangoFT2, MatIO, CFITSIO, OpenEXR, OpenSlide, libPoppler)

## Usage

The primary goal of this image is to provide a base image for projects based on libvips (there is no default `CMD`). Checkout this [Node Libvips repo](https://github.com/creative-area/docker-node-libvips) and his [Docker Hub automated build](https://hub.docker.com/r/creativearea/node-libvips/).

but it can also be used as is :

`docker run --rm -t creativearea/libvips vips -v` or `docker run --rm -t creativearea/libvips vipsthumbnail -h`
