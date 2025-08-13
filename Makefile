# Cross-compilation Makefile for Koneko
# Target: Windows x64

# Compiler and flags
CC = x86_64-w64-mingw32-gcc
CXX = x86_64-w64-mingw32-g++
AS = x86_64-w64-mingw32-as
LD = x86_64-w64-mingw32-ld
WINDRES = x86_64-w64-mingw32-windres

# Flags
CXXFLAGS = -std=c++17 -O2 -fno-stack-protector -fno-exceptions -fno-rtti \
           -D_WIN32_WINNT=0x0601 -DWIN32_LEAN_AND_MEAN \
           -I./headers
CFLAGS = -O2 -fno-stack-protector -D_WIN32_WINNT=0x0601 -DWIN32_LEAN_AND_MEAN
LDFLAGS = -lkernel32 -lntdll -luser32 -ladvapi32 -mwindows

# Source files
CPP_SOURCES = main.cpp callstackspoof.cpp sleep.cpp syscalls.cpp
ASM_SOURCES = callme.asm callr12.asm spoof.asm

# Object files
CPP_OBJECTS = $(CPP_SOURCES:.cpp=.o)
ASM_OBJECTS = $(ASM_SOURCES:.asm=.o)
OBJECTS = $(CPP_OBJECTS) $(ASM_OBJECTS)

# Target executable
TARGET = Koneko.exe

# Default target
all: $(TARGET)

# Link the executable
$(TARGET): $(OBJECTS)
	$(CXX) -o $@ $^ $(LDFLAGS)

# Compile C++ files
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Compile assembly files
%.o: %.asm
	$(AS) -o $@ $<

# Clean build artifacts
clean:
	rm -f $(OBJECTS) $(TARGET)

# Install dependencies (Ubuntu/Debian)
install-deps:
	sudo apt-get update
	sudo apt-get install -y mingw-w64 cmake build-essential

# Build with CMake
cmake-build:
	mkdir -p build
	cd build && cmake .. && make

.PHONY: all clean install-deps cmake-build