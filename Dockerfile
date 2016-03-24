FROM ubuntu:14.04.4

MAINTAINER CREATIVE AREA <contact@creative-area.net>

# build dependencies
RUN apt-get update && apt-get install -y \
	build-essential \
	pkg-config \
	glib2.0-dev \
	libxml2-dev \
	curl \
	yasm

# libjpeg-turbo
ENV LIBJPEG_TURBO_VERSION 1.4.90
WORKDIR /tmp
RUN curl -sOL http://prdownloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-$LIBJPEG_TURBO_VERSION.tar.gz \
	&& tar xzf libjpeg-turbo-$LIBJPEG_TURBO_VERSION.tar.gz \
	&& cd libjpeg-turbo-$LIBJPEG_TURBO_VERSION \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

# libtiff
ENV LIBTIFF_VERSION 4.0.6
WORKDIR /tmp
RUN curl -sOL http://download.osgeo.org/libtiff/tiff-$LIBTIFF_VERSION.tar.gz \
	&& tar xzf tiff-$LIBTIFF_VERSION.tar.gz \
	&& cd tiff-$LIBTIFF_VERSION \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

# libgif
ENV GIFLIB_VERSION 5.1.3
WORKDIR /tmp
RUN curl -sOL http://prdownloads.sourceforge.net/giflib/giflib-$GIFLIB_VERSION.tar.gz \
	&& tar xzf giflib-$GIFLIB_VERSION.tar.gz \
	&& cd giflib-$GIFLIB_VERSION \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

# libpng
ENV LIBPNG_VERSION 1.6.21
WORKDIR /tmp
RUN curl -sOL http://prdownloads.sourceforge.net/libpng/libpng-$LIBPNG_VERSION.tar.gz \
	&& tar xzf libpng-$LIBPNG_VERSION.tar.gz \
	&& cd libpng-$LIBPNG_VERSION \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

# libwebp
ENV LIBWEBP_VERSION 0.5.0
WORKDIR /tmp
RUN curl -sOL https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$LIBWEBP_VERSION.tar.gz \
	&& tar xzf libwebp-$LIBWEBP_VERSION.tar.gz \
	&& cd libwebp-$LIBWEBP_VERSION \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

# libvips dependencies
RUN apt-get update && apt-get install -y \
	libexif-dev \
	liblcms2-dev \
	libgsf-1-dev \
	libfftw3-dev \
	liborc-0.4-dev

# libvips
WORKDIR /tmp
ENV LIBVIPS_VERSION_MAJOR 8
ENV LIBVIPS_VERSION_MINOR 2
ENV LIBVIPS_VERSION_PATCH 2
ENV LIBVIPS_VERSION $LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR.$LIBVIPS_VERSION_PATCH
RUN curl -sOL http://www.vips.ecs.soton.ac.uk/supported/$LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR/vips-$LIBVIPS_VERSION.tar.gz \
	&& tar zvxf vips-$LIBVIPS_VERSION.tar.gz \
	&& cd vips-$LIBVIPS_VERSION \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

WORKDIR /

# Cleanup
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
