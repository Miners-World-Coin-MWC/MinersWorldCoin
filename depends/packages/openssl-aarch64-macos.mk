package=openssl-aarch64-macos
$(package)_version=1.0.2u
$(package)_download_path=https://www.openssl.org/source
$(package)_file_name=openssl-$($(package)_version).tar.gz
$(package)_sha256_hash=ecd0c6ffb493dd06707d38b14bb4d8c2288bb7033735606569d8f90f89669d16

define $(package)_set_vars
$(package)_config_env=AR="$($(package)_ar)" RANLIB="$($(package)_ranlib)" CC="$($(package)_cc)"

$(package)_config_opts=darwin64-arm64-cc
$(package)_config_opts+=--prefix=$(host_prefix)
$(package)_config_opts+=--openssldir=$(host_prefix)/etc/openssl
$(package)_config_opts+=no-asm
$(package)_config_opts+=no-camellia
$(package)_config_opts+=no-capieng
$(package)_config_opts+=no-cast
$(package)_config_opts+=no-dso
$(package)_config_opts+=no-dtls1
$(package)_config_opts+=enable-ec_nistp_64_gcc_128
$(package)_config_opts+=no-gost
$(package)_config_opts+=no-heartbeats
$(package)_config_opts+=no-idea
$(package)_config_opts+=no-md2
$(package)_config_opts+=no-mdc2
$(package)_config_opts+=no-rc5
$(package)_config_opts+=no-rdrand
$(package)_config_opts+=no-rfc3779
$(package)_config_opts+=no-sctp
$(package)_config_opts+=no-seed
$(package)_config_opts+=no-shared
$(package)_config_opts+=no-ssl-trace
$(package)_config_opts+=no-ssl2
$(package)_config_opts+=no-ssl3
$(package)_config_opts+=no-unit-test
$(package)_config_opts+=no-weak-ssl-ciphers
$(package)_config_opts+=no-whirlpool
$(package)_config_opts+=no-zlib
$(package)_config_opts+=no-zlib-dynamic

$(package)_config_opts+=$($(package)_cflags)
$(package)_config_opts+=$($(package)_cppflags)
endef

define $(package)_preprocess_cmds
  export LC_ALL=C && \
  export LANG=C && \
  if [ "$(host)" = "aarch64-apple-darwin21" ]; then \
    cp Configure Configure.orig && \
    perl -0pe 's|("darwin64-x86_64-cc".*?\n)|$$1"darwin64-arm64-cc","cc:-arch arm64 -O3 -DL_ENDIAN -Wall::-D_REENTRANT:MACOSX:-Wl,-search_paths_first%:SIXTY_FOUR_BIT_LONG RC4_CHUNK DES_INT DES_UNROLL::macosx:dlfcn:darwin-shared:-fPIC -fno-common:-arch arm64 -dynamiclib:.\\$$(SHLIB_MAJOR).\\$$(SHLIB_MINOR).dylib",\n|s' \
      Configure.orig > Configure && \
    chmod +x Configure && \
    grep -n "darwin64-arm64-cc" Configure; \
  fi
endef

define $(package)_config_cmds
  ./Configure $($(package)_config_opts)
endef

define $(package)_build_cmds
  $(MAKE) depend && \
  $(MAKE) -j1 build_all && \
  ls -l apps
endef

define $(package)_stage_cmds
  echo "========================================" && \
  echo "   STAGING APPLE SILICON OPENSSL" && \
  echo "========================================" && \
  echo "host=$(host)" && \
  echo "host_prefix=$(host_prefix)" && \
  echo "staging_dir=$($(package)_staging_dir)" && \
  $(MAKE) INSTALL_PREFIX=$($(package)_staging_dir) install_sw && \
  echo "" && \
  echo "===== EXACT STAGING TREE =====" && \
  find "$($(package)_staging_dir)" -maxdepth 8 -print | sort && \
  echo "========================================"
endef

define $(package)_postprocess_cmds
  echo "========================================" && \
  echo "   OPENSSL POSTPROCESS CHECK" && \
  echo "========================================" && \
  echo "host=$(host)" && \
  echo "host_prefix=$(host_prefix)" && \
  echo "" && \
  echo "===== STAGED OPENSSL =====" && \
  find $($(package)_staging_dir) -name opensslv.h -print 2>/dev/null || true && \
  find $($(package)_staging_dir) -name libssl.a -print 2>/dev/null || true && \
  find $($(package)_staging_dir) -name libcrypto.a -print 2>/dev/null || true && \
  echo "========================================"
endef