packages:=boost openssl libevent zeromq
native_packages := native_ccache

qt_native_packages = native_protobuf

zlib_package=zlib
ifeq ($(host),aarch64-apple-darwin21)
zlib_package=zlib-aarch64-macos
endif
ifeq ($(host),aarch64-apple-darwin20)
zlib_package=zlib-aarch64-macos
endif

qt_packages = qrencode protobuf $(zlib_package)

qt_x86_64_linux_packages:=qt expat dbus libxcb xcb_proto libXau xproto freetype fontconfig libX11 xextproto libXext xtrans
qt_i686_linux_packages:=$(qt_x86_64_linux_packages)
qt_darwin_packages=qt
ifeq ($(host),aarch64-apple-darwin21)
qt_darwin_packages=qt-aarch64-macos
endif
ifeq ($(host),aarch64-apple-darwin20)
qt_darwin_packages=qt-aarch64-macos
endif
qt_mingw32_packages=qt

openssl_package=openssl
ifeq ($(host),aarch64-apple-darwin21)
openssl_package=openssl-aarch64-macos
endif
ifeq ($(host),aarch64-apple-darwin20)
openssl_package=openssl-aarch64-macos
endif
packages:=$(filter-out openssl,$(packages))
packages+=$(openssl_package)

wallet_packages=bdb
ifeq ($(host),aarch64-apple-darwin21)
wallet_packages=bdb-aarch64-macos
endif
ifeq ($(host),aarch64-apple-darwin20)
wallet_packages=bdb-aarch64-macos
endif

upnp_packages=miniupnpc

darwin_native_packages = native_biplist native_ds_store native_mac_alias
ifneq ($(build_os),darwin)
darwin_native_packages += native_cctools native_cdrkit native_libdmg-hfsplus
endif