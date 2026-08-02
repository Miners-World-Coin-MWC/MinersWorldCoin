dnl Copyright (c) 2013-2015 The Bitcoin Core developers
dnl Distributed under the MIT software license, see the accompanying
dnl file COPYING or http://www.opensource.org/licenses/mit-license.php.

AC_DEFUN([BITCOIN_FIND_BDB48],[
  AC_ARG_VAR(BDB_CFLAGS, [C compiler flags for BerkeleyDB, bypasses autodetection])
  AC_ARG_VAR(BDB_LIBS, [Linker flags for BerkeleyDB, bypasses autodetection])

  if test "x$BDB_CFLAGS" = "x"; then
    AC_MSG_CHECKING([for Berkeley DB C++ headers])

    BDB_CPPFLAGS=
    bdbpath=X
    bdb48path=X
    bdb53path=X
    bdbdirlist=

    for _vn in 5.3 5 4.8 48 4 ''; do
      for _pfx in b lib ''; do
        bdbdirlist="$bdbdirlist ${_pfx}db${_vn}"
      done
    done

    for searchpath in $bdbdirlist ''; do
      test -n "${searchpath}" && searchpath="${searchpath}/"

      dnl Any supported Berkeley DB >=4.8
      AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
        #include <${searchpath}db_cxx.h>
      ]],[[
        #if !((DB_VERSION_MAJOR == 4 && DB_VERSION_MINOR >= 8) || DB_VERSION_MAJOR > 4)
        #error Unsupported Berkeley DB
        #endif
      ]])],[
        if test "x$bdbpath" = "xX"; then
          bdbpath="${searchpath}"
        fi
      ],[
        continue
      ])

      dnl Detect Berkeley DB 5.3+
      AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
        #include <${searchpath}db_cxx.h>
      ]],[[
        #if !(DB_VERSION_MAJOR == 5 && DB_VERSION_MINOR >= 3)
        #error Not Berkeley DB 5.3
        #endif
      ]])],[
        bdb53path="${searchpath}"
      ],[])

      dnl Detect Berkeley DB 4.8 exactly
      AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
        #include <${searchpath}db_cxx.h>
      ]],[[
        #if !(DB_VERSION_MAJOR == 4 && DB_VERSION_MINOR == 8)
        #error Not Berkeley DB 4.8
        #endif
      ]])],[
        bdb48path="${searchpath}"
      ],[])
    done

    if test "x$bdbpath" = "xX"; then
      AC_MSG_RESULT([no])
      AC_MSG_ERROR([libdb_cxx headers missing, ]AC_PACKAGE_NAME[ requires this library for wallet functionality (--disable-wallet to disable wallet functionality)])

    elif test "x$bdb53path" != "xX"; then
      AC_MSG_RESULT([Berkeley DB 5.3])
      BITCOIN_SUBDIR_TO_INCLUDE(BDB_CPPFLAGS,[${bdb53path}],db_cxx)
      bdbpath="${bdb53path}"

    elif test "x$bdb48path" != "xX"; then
      AC_MSG_RESULT([Berkeley DB 4.8])
      BITCOIN_SUBDIR_TO_INCLUDE(BDB_CPPFLAGS,[${bdb48path}],db_cxx)
      bdbpath="${bdb48path}"

    else
      BITCOIN_SUBDIR_TO_INCLUDE(BDB_CPPFLAGS,[${bdbpath}],db_cxx)

      AC_ARG_WITH([incompatible-bdb],
        [AS_HELP_STRING([--with-incompatible-bdb],
        [allow using an unsupported Berkeley DB version])],[
          AC_MSG_WARN([Using an unsupported Berkeley DB version. Wallet portability is not guaranteed.])
        ],[
          AC_MSG_ERROR([Found an unsupported Berkeley DB version. Supported versions are 4.8 and 5.3. Use --with-incompatible-bdb to override.])
        ])
    fi

  else
    BDB_CPPFLAGS=${BDB_CFLAGS}
  fi

  AC_SUBST(BDB_CPPFLAGS)

  if test "x$BDB_LIBS" = "x"; then

    dnl Prefer newer libraries first.
    for searchlib in \
        db_cxx-5.3 \
        db_cxx53 \
        db5_cxx \
        db_cxx-5 \
        db_cxx \
        db4_cxx \
        db_cxx-4.8
    do
      AC_CHECK_LIB([$searchlib],[main],[
        BDB_LIBS="-l${searchlib}"
        break
      ])
    done

    if test "x$BDB_LIBS" = "x"; then
      AC_MSG_ERROR([libdb_cxx missing, ]AC_PACKAGE_NAME[ requires this library for wallet functionality (--disable-wallet to disable wallet functionality)])
    fi
  fi

  AC_SUBST(BDB_LIBS)
])