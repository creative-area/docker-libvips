FROM alpine:3.3

MAINTAINER CREATIVE AREA <contact@creative-area.net>

RUN apk --update add --virtual build-deps \
	build-base \
	curl \
	automake \
	libtool \
	tar \
	gettext \
	file \
	yasm

RUN apk --update add --virtual libvips-deps \
	glib-dev \
	libexif-dev \
	libxml2-dev \
	lcms2-dev \
	orc-dev \
	fftw-dev

# libjpeg-turbo
ENV LIBJPEG_TURBO_VERSION 1.4.90
WORKDIR /tmp
RUN curl -sOL http://prdownloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-$LIBJPEG_TURBO_VERSION.tar.gz \
	&& tar xzf libjpeg-turbo-$LIBJPEG_TURBO_VERSION.tar.gz \
	&& cd libjpeg-turbo-$LIBJPEG_TURBO_VERSION \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install

	# libtiff
	ENV LIBTIFF_VERSION 4.0.6
	WORKDIR /tmp
	RUN curl -sOL http://download.osgeo.org/libtiff/tiff-$LIBTIFF_VERSION.tar.gz \
		&& tar xzf tiff-$LIBTIFF_VERSION.tar.gz \
		&& cd tiff-$LIBTIFF_VERSION \
		&& ./configure --prefix=/usr/local --with-jpeg-include-dir=/usr/local/include --with-jpeg-lib-dir=/usr/local/lib \
		&& make \
		&& make install

# libgif
ENV GIFLIB_VERSION 5.1.3
WORKDIR /tmp
RUN curl -sOL http://prdownloads.sourceforge.net/giflib/giflib-$GIFLIB_VERSION.tar.gz \
	&& tar xzf giflib-$GIFLIB_VERSION.tar.gz \
	&& cd giflib-$GIFLIB_VERSION \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install

# libpng
ENV LIBPNG_VERSION 1.6.21
WORKDIR /tmp
RUN curl -sOL http://prdownloads.sourceforge.net/libpng/libpng-$LIBPNG_VERSION.tar.gz \
	&& tar xzf libpng-$LIBPNG_VERSION.tar.gz \
	&& cd libpng-$LIBPNG_VERSION \
	&& ./configure --prefix=/usr/local \
	&& make \
	&& make install

# libwebp
ENV LIBWEBP_VERSION 0.5.0
WORKDIR /tmp
RUN curl -sOL https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$LIBWEBP_VERSION.tar.gz \
	&& tar xzf libwebp-$LIBWEBP_VERSION.tar.gz \
	&& cd libwebp-$LIBWEBP_VERSION \
	&& ./configure --prefix=/usr/local --with-pngincludedir=/usr/local/include --with-pnglibdir=/usr/local/lib --with-jpegincludedir=/usr/local/include --with-jpeglibdir=/usr/local/lib --with-tiffincludedir=/usr/local/include --with-tifflibdir=/usr/local/lib --with-gifincludedir=/usr/local/include --with-giflibdir=/usr/local/lib \
	&& make \
	&& make install

	# Build libvips
	WORKDIR /tmp
	ENV LIBVIPS_VERSION_MAJOR 8
	ENV LIBVIPS_VERSION_MINOR 2
	ENV LIBVIPS_VERSION_PATCH 2
	ENV LIBVIPS_VERSION $LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR.$LIBVIPS_VERSION_PATCH
	ENV LIBWEBP_CFLAGS -I=/usr/local/include -L=/usr/local/lib
	ENV LIBWEBP_LIBS -L=/usr/local/lib -lwebp
	RUN curl -sOL http://www.vips.ecs.soton.ac.uk/supported/$LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR/vips-$LIBVIPS_VERSION.tar.gz \
		&& tar zvxf vips-$LIBVIPS_VERSION.tar.gz \
		&& cd vips-$LIBVIPS_VERSION \
		&& ./configure --prefix=/usr/local --without-python --without-gsf --with-tiff-includes=/usr/local/include --with-tiff-libraries=/usr/local/lib --with-png-includes=/usr/local/include --with-png-libraries=/usr/local/lib --with-jpeg-includes=/usr/local/include --with-jpeg-libraries=/usr/local/lib \
		&& make \
		&& make install

WORKDIR /usr/local/bin

# Cleanup
RUN apk del --purge build-deps && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*
