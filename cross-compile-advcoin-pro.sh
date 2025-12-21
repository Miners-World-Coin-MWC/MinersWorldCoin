#!/bin/bash

set -Eeuo pipefail
trap cleanup EXIT INT TERM
trap 'error "Error on line $LINENO"; exit 1' ERR

# --- Colors ---
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RED="\033[0;31m"
BOLD="\033[1m"
NC="\033[0m" # No Color

# --- Spinner Function ---
function spinner {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while kill -0 "$pid" 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b" # Clear spinner after done
}

# --- Helper Functions ---
function info { echo -e "${CYAN}[INFO]${NC} $*"; }
function success { echo -e "${GREEN}[SUCCESS]${NC} $*"; }
function warn { echo -e "${YELLOW}[WARNING]${NC} $*"; }
function error { echo -e "${RED}[ERROR]${NC} $*"; }

function cleanup {
    trap - EXIT INT TERM
}

# --- Timer Functions ---
function now { date +%s; }
function elapsed {
    local duration=$1
    printf "%02d:%02d" $((duration / 60)) $((duration % 60))
}

# --- Step Tracker ---
STEP_NUM=0
TOTAL_START=$(now)
LOG_DIR="$HOME/coin_build_logs"
mkdir -p "$LOG_DIR"

declare -a STEP_DESCRIPTIONS
declare -a STEP_ESTIMATES
declare -a STEP_ACTUALS

function run_step {
    STEP_NUM=$((STEP_NUM + 1))
    local description="$1"
    local est_time="$2"
    shift 2
    local log_file="$LOG_DIR/$(printf "%02d" $STEP_NUM)_$(echo "$description" | tr ' ' '_' | tr '[:upper:]' '[:lower:]').log"

    info "Step $STEP_NUM: $description (estimated ${est_time}m)"
    local start_time=$(now)

    ( "$@" &> "$log_file" ) &
    spinner
    wait $! || {
        error "$description failed. See $log_file."
        exit 1
    }

    local end_time=$(now)
    local duration=$((end_time - start_time))
    local duration_fmt=$(elapsed "$duration")

    success "$description completed in ${duration_fmt} (est. ${est_time}m)"

    STEP_DESCRIPTIONS+=("$description")
    STEP_ESTIMATES+=("$est_time")
    STEP_ACTUALS+=("$duration")

    echo ""
}

# --- CPU Threads Detection ---
if command -v nproc &>/dev/null; then
    CPU_CORES=$(nproc)
else
    CPU_CORES=2
fi

# --- Start ---
echo ""
echo "=== MinersWorldCoin Pro Cross-Compile Script ==="
echo ""

# --- Variables ---
SRCDIR="/media/sf_E_DRIVE/GitHub/Coin-scripts/Coin_Creation/MinersWorldCoin"
BUILDDIR="$HOME/MinersWorldCoin"
QT_VERSION="5.15.2"
QT_ARCHIVE="qt-everywhere-src-$QT_VERSION.tar.xz"
QT_URL="https://download.qt.io/archive/qt/5.15/$QT_VERSION/single/$QT_ARCHIVE"
QT_CACHE_DIR="$HOME/qt-cache"
QT_SRC_DIR="$QT_CACHE_DIR/qt-everywhere-src-$QT_VERSION"
HOST_LINUX="$(gcc -dumpmachine)"

# Windows variables
HOST_WIN64="x86_64-w64-mingw32"
HOST_WIN32="i686-w64-mingw32"
PREFIX_WIN64="$BUILDDIR/depends/$HOST_WIN64"
PREFIX_WIN32="$BUILDDIR/depends/$HOST_WIN32"

# Raspberry Pi variables
HOST_PI32="arm-linux-gnueabihf"
HOST_PI64="aarch64-linux-gnu"
PREFIX_PI32="$BUILDDIR/depends/$HOST_PI32"
PREFIX_PI64="$BUILDDIR/depends/$HOST_PI64"

# Native QMake (if needed)
NATIVE_QMAKE_PATH=""

# --- Flags ---
SKIP_LINUX=false
SKIP_WINDOWS=false
SKIP_CLEAN=false
NO_STRIP=false
SKIP_WIN32=false
SKIP_WIN64=false
SKIP_PI=false
SKIP_PI32=false
SKIP_PI64=false

for arg in "$@"; do
    case $arg in
        --skip-linux) SKIP_LINUX=true ;;
        --skip-windows) SKIP_WINDOWS=true ;;
        --skip-clean) SKIP_CLEAN=true ;;
        --no-strip) NO_STRIP=true ;;
        --skip-win32) SKIP_WIN32=true ;;
        --skip-win64) SKIP_WIN64=true ;;
        --skip-windows) SKIP_WINDOWS=true ;;  # covers both win builds
        --skip-pi32) SKIP_PI32=true ;;
        --skip-pi64) SKIP_PI64=true ;;
        --skip-pi) SKIP_PI=true ;;  # covers both Pi builds
        --quick) SKIP_CLEAN=true ;;
        *)
            warn "Unknown argument: $arg"
            ;;
    esac
done

# --- NSIS Installer Generation Function ---
function generate_nsis_installer {
    local installer_name="$1"
    local binary_dir="$2"
    local script_file="/tmp/${installer_name}.nsi"

    if ! command -v makensis &>/dev/null; then
        warn "makensis not found. Skipping NSIS installer generation for ${installer_name}."
        return 1
    fi

    cat > "$script_file" <<EOF
!define PRODUCT_NAME "MinersWorldCoin Wallet"
!define PRODUCT_VERSION "1.0"
!define PRODUCT_PUBLISHER "MinersWorldCoin"
!define PRODUCT_DIR_REGKEY "Software\\MinersWorldCoin"

OutFile "${installer_name}.exe"
InstallDir "\$PROGRAMFILES\\MinersWorldCoin Wallet"
RequestExecutionLevel admin

Section "Install"
  SetOutPath "\$INSTDIR"
  File /r "${binary_dir}/*"
SectionEnd
EOF

    makensis "$script_file"
    if [ -f "${installer_name}.exe" ]; then
        success "NSIS installer ${installer_name}.exe created successfully."
    else
        warn "Failed to create NSIS installer for ${installer_name}."
    fi
}

# --- Setup Build Directories ---
info "Setting up build directories..."
mkdir -p "$BUILDDIR" "$QT_CACHE_DIR"
rsync -a --delete "$SRCDIR/" "$BUILDDIR/"
cd "$BUILDDIR"
chmod -R u+rwX .

# --- Clean Previous Builds ---
function safe_clean {
    if [[ -f "Makefile" || -f "makefile" ]]; then
        make clean || true
    else
        warn "No Makefile found, skipping clean."
    fi
}

if ! $SKIP_CLEAN; then
    read -rp "⚡ Confirm cleaning previous builds? [y/N]: " confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        run_step "Cleaning previous builds" 1 safe_clean
        cd depends
        run_step "Cleaning previous depends build" 1 safe_clean
        cd "$BUILDDIR"
    else
        warn "User chose not to clean. Continuing..."
    fi
else
    warn "Skipping clean step (Quick mode)..."
fi

# --- Linux Build ---
if ! $SKIP_LINUX; then
    info "Building MinersWorldCoin Wallet for Linux..."

    cd "$BUILDDIR/depends"
    run_step "Building Linux depends" 5 make HOST="$HOST_LINUX" -j"$CPU_CORES" NO_QT=1

    cd "$BUILDDIR"
    run_step "Running autogen for Linux" 1 ./autogen.sh
    run_step "Configuring wallet for Linux" 2 ./configure --prefix="$BUILDDIR/depends/$HOST_LINUX" --disable-tests --disable-bench CXXFLAGS="-std=c++11" \
        --with-gui=qt5 --without-gui-tests --enable-static --enable-upnp-default
    run_step "Building wallet for Linux" 20 make -j"$CPU_CORES"

    info "Bundling Linux binaries..."
    cd src
    if ! $NO_STRIP; then
        strip minersworldcoind minersworldcoin-cli minersworldcoin-tx || warn "Stripping failed, continuing."
        if [ -f qt/minersworldcoin-qt ]; then
            strip qt/minersworldcoin-qt || warn "Stripping failed, continuing."
        else
            echo "Qt binary not found, skipping Qt strip."
        fi
    fi

    cd "$BUILDDIR"
    tar czvf MinersWorldCoin-Linux-release.tar.gz src/minersworldcoind src/minersworldcoin-cli src/minersworldcoin-tx src/qt/minersworldcoin-qt
else
    warn "Skipping Linux build..."
fi

# --- Raspberry Pi Builds ---
if ! $SKIP_PI; then

    # --- Raspberry Pi 32-bit (armv7) Build ---
if ! $SKIP_PI32; then
    info "Cross-compiling MinersWorldCoin Wallet for Raspberry Pi 32-bit (armv7)..."

    # Save original compiler environment
    ORIGINAL_CC="${CC:-}"
    ORIGINAL_CXX="${CXX:-}"
    ORIGINAL_AR="${AR:-}"
    ORIGINAL_RANLIB="${RANLIB:-}"

    # Set ARM cross-compiler environment
    export CC=arm-linux-gnueabihf-gcc
    export CXX=arm-linux-gnueabihf-g++
    export AR=arm-linux-gnueabihf-ar
    export RANLIB=arm-linux-gnueabihf-ranlib

    cd "$BUILDDIR/depends"
    run_step "Building Pi32 depends" 5 make HOST="$HOST_PI32" -j"$CPU_CORES"

    cd "$BUILDDIR"

    run_step "Cleaning libtool files for Pi32" 1 find . -name "libtool" -exec rm -f {} +

    run_step "Running autogen for Pi32" 1 ./autogen.sh
    run_step "Configuring wallet for Pi32" 2 ./configure --prefix="$PREFIX_PI32" --enable-glibc-back-compat --enable-reduce-exports --host="$HOST_PI32" \
        --disable-tests --disable-bench \
        --without-gui-tests --enable-static --enable-upnp-default \
        CXXFLAGS="-std=c++11 -Wno-psabi"

    run_step "Cleaning previous Pi32 builds" 1 make clean

    run_step "Building wallet for Pi32" 20 make -j"$CPU_CORES"

    info "Bundling Pi32 binaries..."
    cd src
    if ! $NO_STRIP; then
        arm-linux-gnueabihf-strip minersworldcoind minersworldcoin-cli minersworldcoin-tx || warn "Stripping failed, continuing."
        if [ -f qt/minersworldcoin-qt ]; then
            arm-linux-gnueabihf-strip qt/minersworldcoin-qt || warn "Stripping failed, continuing."
        else
            echo "Qt binary not found, skipping Qt strip."
        fi
    fi

    cd "$BUILDDIR"
    tar czvf MinersWorldCoin-Pi32-release.tar.gz src/minersworldcoind src/minersworldcoin-cli src/minersworldcoin-tx src/qt/minersworldcoin-qt

    # Restore original compiler environment
    export CC="$ORIGINAL_CC"
    export CXX="$ORIGINAL_CXX"
    export AR="$ORIGINAL_AR"
    export RANLIB="$ORIGINAL_RANLIB"
    else
        warn "Skipping Raspberry Pi 32-bit build..."
    fi

    # --- Raspberry Pi 64-bit (aarch64) Build ---
if ! $SKIP_PI64; then
    info "Cross-compiling MinersWorldCoin Wallet for Raspberry Pi 64-bit (aarch64)..."

    cd "$BUILDDIR/depends"
    run_step "Building Pi64 depends" 5 make HOST="$HOST_PI64" -j"$CPU_CORES"

    cd "$BUILDDIR"
    run_step "Running autogen for Pi64" 1 ./autogen.sh
    run_step "Configuring wallet for Pi64" 2 ./configure --prefix="$PREFIX_PI64" --host="$HOST_PI64" --disable-tests --disable-bench \
        CXX="${HOST_PI64}-g++" CXXFLAGS="-std=c++11" --without-gui-tests --enable-static --enable-upnp-default
    run_step "Building wallet for Pi64" 20 make -j"$CPU_CORES"

    info "Bundling Pi64 binaries..."
    cd src
    if ! $NO_STRIP; then
        aarch64-linux-gnu-strip minersworldcoind minersworldcoin-cli minersworldcoin-tx || warn "Stripping failed, continuing."
        if [ -f qt/minersworldcoin-qt ]; then
            aarch64-linux-gnu-strip qt/minersworldcoin-qt || warn "Stripping failed, continuing."
        else
            echo "Qt binary not found, skipping Qt strip."
        fi
    fi

    cd "$BUILDDIR"
    tar czvf MinersWorldCoin-Pi64-release.tar.gz src/minersworldcoind src/minersworldcoin-cli src/minersworldcoin-tx 
    if [ -f qt/minersworldcoin-qt ]; then
    tar czvf MinersWorldCoin-Pi64-qt.tar.gz qt/minersworldcoin-qt
else
    echo "Qt binary not found, skipping Qt tar creation."
fi

else
    warn "Skipping Raspberry Pi 64-bit build..."
fi

else
    warn "Skipping all Raspberry Pi builds..."
fi

# --- Windows Builds ---
if ! $SKIP_WINDOWS; then

    # --- Windows 64-bit Build ---
    if ! $SKIP_WIN64; then
    info "Cross-compiling MinersWorldCoin Wallet for Windows 64-bit..."

    echo "1" | sudo update-alternatives --config x86_64-w64-mingw32-g++

    cd "$BUILDDIR"
    run_step "Running autogen for Windows 64-bit" 1 ./autogen.sh

    cd "$BUILDDIR/depends"
    run_step "Cleaning previous Windows 64-bit depends" 1 safe_clean
    run_step "Building Windows 64-bit depends" 35 make HOST="$HOST_WIN64" -j"$CPU_CORES"

    cd "$BUILDDIR"

    ORIGINAL_LDFLAGS="${LDFLAGS:-}"
    ORIGINAL_CXXFLAGS="${CXXFLAGS:-}"
    ORIGINAL_CPPFLAGS="${CPPFLAGS:-}"
    # ORIGINAL_LIBS="${LIBS:-}"

    BOOST_INCLUDE="$BUILDDIR/depends/$HOST_WIN64/include"
    BOOST_LIB="$BUILDDIR/depends/$HOST_WIN64/lib"
    QT_LIB_PATH="$BUILDDIR/depends/$HOST_WIN64/lib"
    QT_INCLUDE_PATH="$BUILDDIR/depends/$HOST_WIN64/include"

    export CXXFLAGS="${CXXFLAGS:+$CXXFLAGS } -DBOOST_ALL_NO_LIB=1 -static -static-libstdc++ -static-libgcc -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0"
    export CPPFLAGS="-I$BOOST_INCLUDE -I$QT_INCLUDE_PATH"
    export LDFLAGS="-static -L$BOOST_LIB -L$QT_LIB_PATH"
    # export LIBS="-lboost_system -lboost_filesystem -lboost_program_options -lQt5Core -lQt5Widgets -lQt5Gui -lQt5Network -lws2_32 -lshlwapi -liphlpapi -lz -lpsapi"

    run_step "Configuring wallet for Windows 64-bit" 2 ./configure --prefix="$PREFIX_WIN64" --host="$HOST_WIN64" \
        --disable-tests --disable-bench \
        --without-gui-tests --with-gui=qt5 --enable-static --disable-shared --enable-upnp-default \
        CXX="${HOST_WIN64}-g++" \
        CXXFLAGS="$CXXFLAGS" \
        CPPFLAGS="$CPPFLAGS" \
        LDFLAGS="$LDFLAGS" \
        --with-boost="$BUILDDIR/depends/$HOST_WIN64" \
        --with-boost-libdir="$BOOST_LIB" \
        --with-qt-incdir="$QT_INCLUDE_PATH" \
        --with-qt-libdir="$QT_LIB_PATH"

    run_step "Building wallet for Windows 64-bit" 20 make -j"$CPU_CORES"

    export LDFLAGS="$ORIGINAL_LDFLAGS"
    export CXXFLAGS="$ORIGINAL_CXXFLAGS"
    export CPPFLAGS="$ORIGINAL_CPPFLAGS"
    # export LIBS="$ORIGINAL_LIBS"

    info "Bundling Windows 64-bit binaries..."
    cd src
    if ! $NO_STRIP; then
        BINARIES=(minersworldcoind.exe minersworldcoin-cli.exe minersworldcoin-tx.exe)
        if [ -f qt/minersworldcoin-qt.exe ]; then
            BINARIES+=(qt/minersworldcoin-qt.exe)
        else
            echo "Qt binary not found, skipping Qt strip."
        fi

        for BIN in "${BINARIES[@]}"; do
            x86_64-w64-mingw32-strip "$BIN" || warn "Stripping $BIN failed, continuing."
        done
    fi

    cd "$BUILDDIR"
    zip -r MinersWorldCoin-Win64-release.zip src/minersworldcoind.exe src/minersworldcoin-cli.exe src/minersworldcoin-tx.exe src/qt/minersworldcoin-qt.exe

    if command -v makensis >/dev/null; then
        generate_nsis_installer "MinersWorldCoin-Win64-Installer" "$BUILDDIR/src"
    else
        warn "NSIS not found, skipping installer generation."
    fi
else
    warn "Skipping Windows 64-bit build..."
fi


    # --- Windows 32-bit Build ---
if ! $SKIP_WIN32; then
    info "Cross-compiling MinersWorldCoin Wallet for Windows 32-bit..."

    # Set the default mingw32 g++ compiler option to POSIX
    echo "1" | sudo update-alternatives --config i686-w64-mingw32-g++

    cd "$BUILDDIR/depends"
    run_step "Cleaning previous Windows 32-bit depends" 1 safe_clean
    run_step "Building Windows 32-bit depends" 5 make HOST="$HOST_WIN32" -j"$CPU_CORES"

    cd "$BUILDDIR"
    run_step "Running autogen for Windows 32-bit" 1 ./autogen.sh
    run_step "Configuring wallet for Windows 32-bit" 2 ./configure --prefix="$PREFIX_WIN32" --host="$HOST_WIN32" --disable-tests --disable-bench \
        CXX="${HOST_WIN32}-g++" CXXFLAGS="-std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0" --without-gui-tests --enable-static --enable-upnp-default --with-gui=qt5
    run_step "Building wallet for Windows 32-bit" 20 make -j"$CPU_CORES"

    info "Bundling Windows 32-bit binaries..."
    cd src
    if ! $NO_STRIP; then
            i686-w64-mingw32-strip minersworldcoind.exe minersworldcoin-cli.exe minersworldcoin-tx.exe || warn "Stripping failed, continuing."
            if [ -f qt/minersworldcoin-qt.exe ]; then
                i686-w64-mingw32-strip qt/minersworldcoin-qt.exe || warn "Stripping failed, continuing."
            else
                echo "Qt binary not found, skipping Qt strip."
            fi
        fi

    cd "$BUILDDIR"
    zip -r MinersWorldCoin-Win32-release.zip src/minersworldcoind.exe src/minersworldcoin-cli.exe src/minersworldcoin-tx.exe src/qt/minersworldcoin-qt.exe
    # Generate NSIS installer for Win32
    generate_nsis_installer "MinersWorldCoin-Win32-Installer" "$BUILDDIR/src"
else
    warn "Skipping Windows 32-bit build..."
fi

else
    warn "Skipping all Windows builds..."
fi

# --- Final Summary ---
echo ""
echo -e "${BOLD}Build Summary Table:${NC}"
printf "\n| %-3s | %-40s | %-10s | %-10s |\n" "No" "Step" "Est. (m)" "Actual"
printf "|%s|\n" "$(printf -- '-%.0s' {1..65})"

total_est=0
total_actual=0
for i in "${!STEP_DESCRIPTIONS[@]}"; do
    desc="${STEP_DESCRIPTIONS[$i]}"
    est="${STEP_ESTIMATES[$i]}"
    act="${STEP_ACTUALS[$i]}"
    act_fmt=$(elapsed "$act")
    printf "| %-3s | %-40s | %-10s | %-10s |\n" "$((i+1))" "$desc" "${est}m" "$act_fmt"
    total_est=$((total_est + est))
    total_actual=$((total_actual + act))
done

printf "|%s|\n" "$(printf -- '-%.0s' {1..65})"
printf "| ${BOLD}%-3s${NC} | ${BOLD}%-40s${NC} | ${BOLD}%-10s${NC} | ${BOLD}%-10s${NC} |\n" "ALL" "TOTAL" "${total_est}m" "$(elapsed "$total_actual")"

# --- Grand Final ---
TOTAL_END=$(now)
TOTAL_DURATION=$((TOTAL_END - TOTAL_START))
TOTAL_FMT=$(elapsed "$TOTAL_DURATION")

echo ""
success "🏁 Full build finished in ${TOTAL_FMT}."
success "🗂 Logs saved in $LOG_DIR/"
echo ""
