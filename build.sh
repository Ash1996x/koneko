#!/bin/bash

# Koneko Build Script for Linux -> Windows Cross-compilation
# This script will install dependencies and build the project

set -e

echo "🐾 Koneko Build Script 🐾"
echo "=========================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    print_error "This script is designed for Linux systems only."
    exit 1
fi

# Detect package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
elif command -v dnf &> /dev/null; then
    PKG_MANAGER="dnf"
elif command -v pacman &> /dev/null; then
    PKG_MANAGER="pacman"
else
    print_error "Unsupported package manager. Please install dependencies manually."
    exit 1
fi

# Install dependencies
print_status "Installing cross-compilation dependencies..."

case $PKG_MANAGER in
    "apt")
        sudo apt-get update
        sudo apt-get install -y mingw-w64 cmake build-essential
        ;;
    "yum"|"dnf")
        sudo $PKG_MANAGER install -y mingw-w64-gcc mingw-w64-gcc-c++ cmake make gcc gcc-c++
        ;;
    "pacman")
        sudo pacman -S --noconfirm mingw-w64-gcc mingw-w64-gcc-c++ cmake make base-devel
        ;;
esac

print_success "Dependencies installed successfully!"

# Check if MinGW is available
if ! command -v x86_64-w64-mingw32-gcc &> /dev/null; then
    print_error "MinGW-w64 not found. Please check your installation."
    exit 1
fi

print_status "MinGW-w64 found: $(x86_64-w64-mingw32-gcc --version | head -n1)"

# Create build directory
print_status "Creating build directory..."
mkdir -p build
cd build

# Build with CMake
print_status "Building with CMake..."
if cmake ..; then
    print_success "CMake configuration successful!"
else
    print_error "CMake configuration failed!"
    exit 1
fi

if make -j$(nproc); then
    print_success "Build successful!"
else
    print_error "Build failed!"
    exit 1
fi

# Check if the executable was created
if [ -f "bin/Koneko.exe" ]; then
    print_success "Koneko.exe created successfully!"
    print_status "Executable location: $(pwd)/bin/Koneko.exe"
    
    # Show file information
    echo ""
    print_status "File information:"
    file bin/Koneko.exe
    ls -lh bin/Koneko.exe
    
    echo ""
    print_success "🎉 Build completed successfully! 🎉"
    print_status "The Windows executable is ready for use."
    print_warning "Note: This executable is designed to run on Windows systems only."
    
else
    print_error "Executable not found after build!"
    exit 1
fi

# Return to original directory
cd ..

echo ""
print_status "Build process completed. You can now use the Windows executable."