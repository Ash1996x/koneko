# MinGW-w64 Cross-compilation Toolchain for Linux -> Windows
# This file should be used with: cmake -DCMAKE_TOOLCHAIN_FILE=mingw-toolchain.cmake ..

# Target system
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Cross-compilers
set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)
set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)

# Root path for finding libraries
set(CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32)

# Adjust find behavior
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Compiler flags
set(CMAKE_C_FLAGS "-D_WIN32_WINNT=0x0601 -DWIN32_LEAN_AND_MEAN")
set(CMAKE_CXX_FLAGS "-D_WIN32_WINNT=0x0601 -DWIN32_LEAN_AND_MEAN")

# Linker flags
set(CMAKE_EXE_LINKER_FLAGS "-static-libgcc -static-libstdc++")