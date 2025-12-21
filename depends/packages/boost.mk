package=boost
$(package)_version=1_74_0
$(package)_download_path=https://archives.boost.io/release/1.74.0/source/
$(package)_file_name=$(package)_$($(package)_version).tar.bz2
$(package)_sha256_hash=83bfc1507731a0906e387fc28b7ef5417d591429e51e788417fe9ff025e116b1

define $(package)_set_vars
$(package)_config_opts_release=variant=release
$(package)_config_opts_debug=variant=debug

# Common Boost build configuration
$(package)_config_opts=--layout=tagged --build-type=complete --user-config=user-config.jam
$(package)_config_opts+=threading=multi link=static -sNO_BZIP2=1 -sNO_ZLIB=1

# Linux native build
$(package)_config_opts_linux=threadapi=pthread runtime-link=shared

# IMPORTANT: macOS must NOT use darwin toolset!
# Boost darwin toolset is incompatible with Linux cross-compile.
$(package)_config_opts_darwin=--toolset=gcc runtime-link=shared

# Windows builds
$(package)_config_opts_mingw32=binary-format=pe target-os=windows threadapi=win32 runtime-link=static
$(package)_config_opts_x86_64_mingw32=address-model=64
$(package)_config_opts_i686_mingw32=address-model=32

# 32-bit Linux
$(package)_config_opts_i686_linux=address-model=32 architecture=x86

# Boost toolset assignments
$(package)_toolset_$(host_os)=gcc
$(package)_archiver_$(host_os)=$($(package)_ar)

# Mac fallback variables (not used but required to exist)
$(package)_toolset_darwin=gcc
$(package)_archiver_darwin=$($(package)_ar)

boost_toolset_darwin=$($(package)_toolset_darwin)
boost_archiver_darwin=$($(package)_archiver_darwin)

$(package)_config_libraries=chrono,filesystem,program_options,system,thread,test

$(package)_cxxflags=-std=c++11 -fvisibility=hidden
$(package)_cxxflags_linux=-fPIC
endef

# ==========================================================
# PREPROCESS: Create Boost user-config.jam
# IMPORTANT: Always use 'gcc' toolset but inject Clang compiler
# ==========================================================
define $(package)_preprocess_cmds
  echo "using gcc : : $($(package)_cxx) \
      : <cxxflags>\"$($(package)_cxxflags) $($(package)_cppflags)\" \
        <linkflags>\"$($(package)_ldflags)\" \
        <archiver>\"$($(package)_ar)\" \
        <ranlib>\"$(host_RANLIB)\" \
        <striper>\"$(host_STRIP)\" \
      ;" > user-config.jam
endef

define $(package)_config_cmds
  ./bootstrap.sh --without-icu --with-libraries=$(boost_config_libraries)
endef

define $(package)_build_cmds
  ./b2 -d2 -j2 --prefix=$($(package)_staging_prefix_dir) $($(package)_config_opts) stage
endef

define $(package)_stage_cmds
  ./b2 -d0 -j2 --prefix=$($(package)_staging_prefix_dir) $($(package)_config_opts) install
endef
