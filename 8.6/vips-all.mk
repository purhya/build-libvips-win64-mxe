PKG             := vips-all
$(PKG)_WEBSITE  := https://jcupitt.github.io/libvips/
$(PKG)_DESCR    := A fast image processing library with low memory needs.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 8.6.3
$(PKG)_CHECKSUM := f85adbb9f5f0f66b34a40fd2d2e60d52f6e992831f54af706db446f582e10992
$(PKG)_GH_CONF  := jcupitt/libvips/releases/latest,v
$(PKG)_SUBDIR   := $(subst -all,,$(PKG))-$($(PKG)_VERSION)
$(PKG)_FILE     := $(subst -all,,$(PKG))-$($(PKG)_VERSION).tar.gz
$(PKG)_DEPS     := cc matio libwebp librsvg giflib poppler glib pango fftw libgsf \
                   libjpeg-turbo tiff openslide lcms libexif imagemagick libpng

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(SOURCE_DIR)/configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-debug=no \
        --without-OpenEXR \
        --disable-introspection \
        --with-jpeg-includes='$(PREFIX)/$(TARGET)/include/libjpeg-turbo' \
        --with-jpeg-libraries='$(PREFIX)/$(TARGET)/lib/libjpeg-turbo' \
        CFLAGS='-O3' \
        CXXFLAGS='-O3'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install
endef