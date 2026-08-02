PACKAGE=qt-aarch64-macos
$(package)_version=5.7.1
$(package)_download_path=https://download.qt.io/new_archive/qt/5.7/5.7.1/submodules/
$(package)_suffix=opensource-src-$($(package)_version).tar.gz
$(package)_file_name=qtbase-$($(package)_suffix)
$(package)_sha256_hash=95f83e532d23b3ddbde7973f380ecae1bac13230340557276f75f2e37984e410
$(package)_dependencies=zlib-aarch64-macos openssl-aarch64-macos 
$(package)_linux_dependencies=freetype fontconfig libxcb libX11 xproto libXext
$(package)_build_subdir=qtbase
$(package)_qt_libs=corelib network widgets gui plugins testlib
$(package)_patches=macx-clang-qmake.conf
$(package)_patches+=fix_qt_pkgconfig.patch

$(package)_qttranslations_file_name=qttranslations-$($(package)_suffix)
$(package)_qttranslations_sha256_hash=3a15aebd523c6d89fb97b2d3df866c94149653a26d27a00aac9b6d3020bc5a1d

$(package)_qttools_file_name=qttools-$($(package)_suffix)
$(package)_qttools_sha256_hash=22d67de915cb8cd93e16fdd38fa006224ad9170bd217c2be1e53045a8dd02f0f

$(package)_extra_sources  = $($(package)_qttranslations_file_name)
$(package)_extra_sources += $($(package)_qttools_file_name)

define $(package)_set_vars
$(package)_config_opts_release = -release
$(package)_config_opts_debug = -debug
$(package)_config_opts += -bindir $(build_prefix)/bin
$(package)_config_opts += -c++std c++14
$(package)_config_opts += -confirm-license
$(package)_config_opts += -dbus-runtime
$(package)_config_opts += -hostprefix $(build_prefix)
$(package)_config_opts += -no-alsa
$(package)_config_opts += -no-audio-backend
$(package)_config_opts += -no-cups
$(package)_config_opts += -no-egl
$(package)_config_opts += -no-eglfs
$(package)_config_opts += -no-feature-style-windowsmobile
$(package)_config_opts += -no-feature-style-windowsce
$(package)_config_opts += -no-freetype
$(package)_config_opts += -no-gif
$(package)_config_opts += -no-glib
$(package)_config_opts += -no-gstreamer
$(package)_config_opts += -no-icu
$(package)_config_opts += -no-iconv
$(package)_config_opts += -no-kms
$(package)_config_opts += -no-linuxfb
$(package)_config_opts += -no-libudev
$(package)_config_opts += -no-mitshm
$(package)_config_opts += -no-mtdev
$(package)_config_opts += -no-pulseaudio
$(package)_config_opts += -no-openvg
$(package)_config_opts += -no-reduce-relocations
$(package)_config_opts += -no-qml-debug
$(package)_config_opts += -no-sql-db2
$(package)_config_opts += -no-sql-ibase
$(package)_config_opts += -no-sql-oci
$(package)_config_opts += -no-sql-tds
$(package)_config_opts += -no-sql-mysql
$(package)_config_opts += -no-sql-odbc
$(package)_config_opts += -no-sql-psql
$(package)_config_opts += -no-sql-sqlite
$(package)_config_opts += -no-sql-sqlite2
$(package)_config_opts += -no-use-gold-linker
$(package)_config_opts += -no-xinput2
$(package)_config_opts += -no-xrender
$(package)_config_opts += -nomake examples
$(package)_config_opts += -nomake tests
$(package)_config_opts += -no-pkg-config
$(package)_config_opts += -opensource
$(package)_config_opts += -openssl-linked
$(package)_config_opts += -optimized-qmake
$(package)_config_opts += -pch
$(package)_config_opts += -prefix $(host_prefix)
$(package)_config_opts += -qt-libpng
$(package)_config_opts += -qt-libjpeg
$(package)_config_opts += -qt-pcre
$(package)_config_opts += -system-zlib
$(package)_config_opts += -reduce-exports
$(package)_config_opts += -static
$(package)_config_opts += -silent
$(package)_config_opts += -v
$(package)_config_opts += -no-feature-printer
$(package)_config_opts += -no-feature-printdialog

ifeq ($(build_os),darwin)
ifeq ($(host),aarch64-apple-darwin21)

$(package)_config_opts_darwin = -platform macx-clang
$(package)_config_opts_darwin += -device-option MAC_SDK_PATH=$(SDKROOT)
$(package)_config_opts_darwin += -device-option MAC_SDK_VERSION=$(OSX_SDK_VERSION)
$(package)_config_opts_darwin += -device-option MAC_MIN_VERSION=11.0

else

$(package)_config_opts_darwin = -platform macx-clang
$(package)_config_opts_darwin += -xplatform macx-clang
$(package)_config_opts_darwin += -device-option MAC_SDK_PATH=$(OSX_SDK)
$(package)_config_opts_darwin += -device-option MAC_SDK_VERSION=$(OSX_SDK_VERSION)
$(package)_config_opts_darwin += -device-option MAC_MIN_VERSION=$(OSX_MIN_VERSION)

endif
endif

$(package)_build_env = \
    QT_RCC_TEST=1 \
    MAKEFLAGS="V=1 VERBOSE=1"
endef

define $(package)_fetch_cmds
$(call fetch_file,$(package),$($(package)_download_path),$($(package)_download_file),$($(package)_file_name),$($(package)_sha256_hash)) && \
$(call fetch_file,$(package),$($(package)_download_path),$($(package)_qttranslations_file_name),$($(package)_qttranslations_file_name),$($(package)_qttranslations_sha256_hash)) && \
$(call fetch_file,$(package),$($(package)_download_path),$($(package)_qttools_file_name),$($(package)_qttools_file_name),$($(package)_qttools_sha256_hash))
endef

define $(package)_extract_cmds
  mkdir -p $($(package)_extract_dir) && \
  echo "$($(package)_sha256_hash)  $($(package)_source)" > $($(package)_extract_dir)/.$($(package)_file_name).hash && \
  echo "$($(package)_qttranslations_sha256_hash)  $($(package)_source_dir)/$($(package)_qttranslations_file_name)" >> $($(package)_extract_dir)/.$($(package)_file_name).hash && \
  echo "$($(package)_qttools_sha256_hash)  $($(package)_source_dir)/$($(package)_qttools_file_name)" >> $($(package)_extract_dir)/.$($(package)_file_name).hash && \
  $(build_SHA256SUM) -c $($(package)_extract_dir)/.$($(package)_file_name).hash && \
  mkdir qtbase && \
  tar --strip-components=1 -xf $($(package)_source) -C qtbase && \
  mkdir qttranslations && \
  tar --strip-components=1 -xf $($(package)_source_dir)/$($(package)_qttranslations_file_name) -C qttranslations && \
  mkdir qttools && \
  tar --strip-components=1 -xf $($(package)_source_dir)/$($(package)_qttools_file_name) -C qttools
endef

define $(package)_preprocess_cmds
  export LC_ALL=C && \
  export LANG=C && \
  sed -i.old "s|updateqm.commands = \$$$$\$$$$LRELEASE|updateqm.commands = $($(package)_extract_dir)/qttools/bin/lrelease|" qttranslations/translations/translations.pro && \
  sed -i.old "/updateqm.depends =/d" qttranslations/translations/translations.pro && \
  sed -i.old "s/src_plugins.depends = src_sql src_xml src_network/src_plugins.depends = src_xml src_network/" qtbase/src/src.pro && \
  FILE="qtbase/src/corelib/global/qtypetraits.h"; \
    perl -0pi -e 's/#include <utility>/#include <utility>\n#include <type_traits>/;' $$$$FILE; \
    perl -0pi -e 's/template <typename T>\nstruct is_unsigned\n\s*: integral_constant<bool, \(T\(0\) < T\(-1\)\)> \{\};/template <typename T>\nstruct is_unsigned\n    : integral_constant<bool, (std::is_unsigned<T>::value)> {};/s;' $$$$FILE; \
  if [ "$(host)" = "aarch64-apple-darwin21" ]; then \
      perl -0pi -e 's/\bQFixed::QFixed\(/QFixed(/g' \
          qtbase/src/platformsupport/fontdatabases/mac/qfontengine_coretext.mm; \
  fi && \
  if [ "$(host)" = "aarch64-apple-darwin21" ]; then \
      perl -0pi -e 's/OSStatus qt_mac_drawCGImage\(CGContextRef inContext, const CGRect \*inBounds, CGImageRef inImage\)\n\{.*?\n\}/OSStatus qt_mac_drawCGImage(CGContextRef inContext, const CGRect *inBounds, CGImageRef inImage)\n{\n    if (inContext == NULL || inBounds == NULL || inImage == NULL)\n        return paramErr;\n\n    CGContextSaveGState(inContext);\n    CGContextTranslateCTM(inContext, 0, inBounds->origin.y + CGRectGetMaxY(*inBounds));\n    CGContextScaleCTM(inContext, 1, -1);\n\n    CGContextDrawImage(inContext, *inBounds, inImage);\n\n    CGContextRestoreGState(inContext);\n\n    return noErr;\n}/s' \
          qtbase/src/plugins/platforms/cocoa/qcocoahelpers.mm; \
  fi && \
  cp -f $($(package)_patch_dir)/macx-clang-qmake.conf \
      qtbase/mkspecs/macx-clang/qmake.conf && \
  if [ "$(host)" = "aarch64-apple-darwin21" ]; then \
      perl -0pi -e 's/#define QGLOBAL_H/#define QGLOBAL_H\n#ifndef ARCH_PROCESSOR\n#define ARCH_PROCESSOR "arm64"\n#endif/' \
          qtbase/config.tests/arch/arch.cpp; \
  fi && \
  find qtbase -type f \( -name "*.conf" -o -name "*.prf" -o -name "*.pri" \) \
      -exec perl -0pi -e 's/--enable-new-dtags//g' {} \; && \
  perl -0pi -e 's/--enable-new-dtags//g' qtbase/configure && \
  perl -0pi -e 's/--enable-new-dtags//g' qtbase/configure.prf 2>/dev/null || true && \
  perl -0pi -e 's/^QMAKE_APPLE_DEVICE_ARCHITECTURES.*/QMAKE_APPLE_DEVICE_ARCHITECTURES = arm64/m' \
      qtbase/mkspecs/macx-clang/qmake.conf && \
  echo "" >> qtbase/mkspecs/macx-clang/qmake.conf && \
  echo "QMAKE_TARGET.arch = arm64" >> qtbase/mkspecs/macx-clang/qmake.conf && \
  patch -p1 < $($(package)_patch_dir)/fix_qt_pkgconfig.patch && \
  echo "!host_build: QMAKE_CFLAGS   += $($(package)_cflags) $($(package)_cppflags)" >> qtbase/mkspecs/common/gcc-base.conf && \
  echo "!host_build: QMAKE_CXXFLAGS += $($(package)_cxxflags) $($(package)_cppflags)" >> qtbase/mkspecs/common/gcc-base.conf && \
  echo "!host_build: QMAKE_LFLAGS   += $($(package)_ldflags)" >> qtbase/mkspecs/common/gcc-base.conf
endef

define $(package)_config_cmds
  export LC_ALL=C && \
  export LANG=C && \
  echo "========================================" && \
  echo "       QT OPENSSL DEPENDENCY CHECK" && \
  echo "========================================" && \
  echo "host=$(host)" && \
  echo "host_prefix=$(host_prefix)" && \
  echo "" && \
  echo "===== HOST PREFIX DIRECTORY =====" && \
  ls -la "$(host_prefix)" && \
  echo "" && \
  echo "===== HOST PREFIX INCLUDE =====" && \
  ls -la "$(host_prefix)/include" && \
  echo "" && \
  echo "===== HOST PREFIX LIB =====" && \
  ls -la "$(host_prefix)/lib" && \
  echo "" && \
  echo "===== OPENSSL HEADER =====" && \
  ls -lh "$(host_prefix)/include/openssl/opensslv.h" && \
  grep 'OPENSSL_VERSION_TEXT' "$(host_prefix)/include/openssl/opensslv.h" | head -2 && \
  echo "" && \
  echo "===== OPENSSL LIBRARIES =====" && \
  ls -lh "$(host_prefix)/lib/libssl.a" && \
  ls -lh "$(host_prefix)/lib/libcrypto.a" && \
  echo "" && \
  echo "===== OPENSSL ARCHITECTURE =====" && \
  file "$(host_prefix)/lib/libssl.a" && \
  file "$(host_prefix)/lib/libcrypto.a" && \
  echo "" && \
  echo "===== DIRECT OPENSSL COMPILE/LINK TEST =====" && \
  printf '%s\n' \
    '#include <openssl/ssl.h>' \
    '#include <openssl/crypto.h>' \
    'int main(void) {' \
    '    SSL_library_init();' \
    '    OPENSSL_add_all_algorithms_conf();' \
    '    return 0;' \
    '}' > openssl_qt_test.c && \
  $($(package)_cc) \
    -arch arm64 \
    -mmacosx-version-min=11.0 \
    -isysroot "$(SDKROOT)" \
    -I"$(host_prefix)/include" \
    -L"$(host_prefix)/lib" \
    openssl_qt_test.c \
    -lssl \
    -lcrypto \
    -o openssl_qt_test && \
  file openssl_qt_test && \
  rm -f openssl_qt_test openssl_qt_test.c && \
  echo "" && \
  echo "===== QT CONFIGURE =====" && \
  ./configure \
    -I"$(host_prefix)/include" \
    -L"$(host_prefix)/lib" \
    $($(package)_config_opts)
endef

define $(package)_build_cmds
    $(MAKE) && \
    cd ../qttools/src/linguist/lrelease && \
    ../../../../qtbase/bin/qmake lrelease.pro && \
    $(MAKE) && \
    cd ../../../../qttranslations && \
    ../qtbase/bin/qmake qttranslations.pro && \
    $(MAKE)
endef

define $(package)_stage_cmds
    $(MAKE) install INSTALL_ROOT=$($(package)_staging_dir) && \
    cd ../qttranslations && \
    $(MAKE) install INSTALL_ROOT=$($(package)_staging_dir) && \
    cd ../qttools/src/linguist/lrelease && \
    $(MAKE) install INSTALL_ROOT=$($(package)_staging_dir)
endef

define $(package)_postprocess_cmds
  rm -rf native/mkspecs/ native/lib/ lib/cmake/ && \
  rm -f lib/lib*.la lib/*.prl plugins/*/*.prl
endef