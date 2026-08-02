# macOS settings
# Default Intel/older macOS
OSX_MIN_VERSION=10.8
OSX_SDK_VERSION=10.11

OSX_SDK=$(SDK_PATH)/MacOSX$(OSX_SDK_VERSION).sdk

LD64_VERSION=253.9

# ==========================================================
# Apple Silicon cross compile
# ==========================================================
ifeq ($(host),aarch64-apple-darwin21)

OSX_MIN_VERSION=11.0
OSX_SDK_VERSION=11.3

LD64_VERSION=609
endif

ifeq ($(host),aarch64-apple-darwin20)
OSX_MIN_VERSION=11.0
OSX_SDK_VERSION=11.3

LD64_VERSION=609
endif

ifeq ($(host),aarch64-apple-darwin21)
darwin_CC=clang -arch arm64 -mmacosx-version-min=11.0 --sysroot $(OSX_SDK)
darwin_CXX=clang++ -arch arm64 -mmacosx-version-min=11.0 --sysroot $(OSX_SDK) -stdlib=libc++
else
darwin_CC=clang -target $(host) -mmacosx-version-min=$(OSX_MIN_VERSION) --sysroot $(OSX_SDK) -mlinker-version=$(LD64_VERSION)
darwin_CXX=clang++ -target $(host) -mmacosx-version-min=$(OSX_MIN_VERSION) --sysroot $(OSX_SDK) -mlinker-version=$(LD64_VERSION) -stdlib=libc++
endif

darwin_CFLAGS=-pipe
darwin_CXXFLAGS=$(darwin_CFLAGS)

darwin_release_CFLAGS=-O2
darwin_release_CXXFLAGS=$(darwin_release_CFLAGS)

darwin_debug_CFLAGS=-O1
darwin_debug_CXXFLAGS=$(darwin_debug_CFLAGS)

darwin_native_toolchain=native_cctools