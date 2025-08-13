# Building Koneko from Linux

This document explains how to cross-compile the Koneko project from Linux to create a Windows executable.

## Prerequisites

- Linux system (Ubuntu, Debian, CentOS, Fedora, or Arch Linux)
- sudo privileges for package installation
- Internet connection for downloading dependencies

## Quick Build

The easiest way to build the project is to use the automated build script:

```bash
./build.sh
```

This script will:
1. Install all necessary dependencies
2. Configure the build environment
3. Compile the project
4. Create the Windows executable

## Manual Build

If you prefer to build manually or the automated script fails, follow these steps:

### 1. Install Dependencies

#### Ubuntu/Debian:
```bash
sudo apt-get update
sudo apt-get install -y mingw-w64 cmake build-essential
```

#### CentOS/RHEL/Fedora:
```bash
sudo dnf install -y mingw-w64-gcc mingw-w64-gcc-c++ cmake make gcc gcc-c++
```

#### Arch Linux:
```bash
sudo pacman -S --noconfirm mingw-w64-gcc mingw-w64-gcc-c++ cmake make base-devel
```

### 2. Verify MinGW Installation

Check that the cross-compiler is available:
```bash
x86_64-w64-mingw32-gcc --version
```

### 3. Build with CMake

```bash
mkdir build
cd build
cmake ..
make -j$(nproc)
```

### 4. Build with Makefile (Alternative)

```bash
make clean
make all
```

## Build Output

After successful compilation, you'll find:
- **CMake build**: `build/bin/Koneko.exe`
- **Makefile build**: `Koneko.exe` (in project root)

## Project Structure

```
Koneko/
├── headers/           # Header files
├── main.cpp          # Main application code
├── callstackspoof.cpp # Call stack spoofing implementation
├── sleep.cpp         # Sleep function modifications
├── syscalls.cpp      # System call implementations
├── *.asm            # Assembly files for low-level operations
├── CMakeLists.txt   # CMake build configuration
├── Makefile         # Alternative build configuration
├── build.sh         # Automated build script
└── BUILD.md         # This file
```

## Troubleshooting

### Common Issues

1. **MinGW not found**: Ensure you've installed the `mingw-w64` package
2. **Permission denied**: Make sure the build script is executable (`chmod +x build.sh`)
3. **Build failures**: Check that all dependencies are installed and try cleaning the build directory

### Clean Build

To start fresh:
```bash
# For CMake builds
rm -rf build/

# For Makefile builds
make clean
```

## Cross-Compilation Details

This project uses:
- **Target**: Windows x64
- **Compiler**: MinGW-w64 GCC/G++
- **C++ Standard**: C++17
- **Libraries**: Windows API (kernel32, ntdll, user32, advapi32)

## Security Note

⚠️ **Important**: This project is designed for security testing and research purposes only. The resulting executable should only be used in controlled, authorized environments.

## Support

If you encounter build issues:
1. Check that all dependencies are properly installed
2. Verify your Linux distribution is supported
3. Ensure you have sufficient disk space for the build
4. Check the console output for specific error messages