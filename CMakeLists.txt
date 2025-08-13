cmake_minimum_required(VERSION 3.16)
project(Koneko)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Cross-compilation is configured via mingw-toolchain.cmake
# Use: cmake -DCMAKE_TOOLCHAIN_FILE=mingw-toolchain.cmake ..

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Add source files
set(SOURCES
    main.cpp
    callstackspoof.cpp
    sleep.cpp
    syscalls.cpp
    stubs.cpp
)

# Assembly files temporarily disabled - using C++ stubs instead
# set(ASM_SOURCES
#     callme.asm
#     callr12.asm
#     spoof.asm
# )

# Initialize ASM_OBJECTS list
set(ASM_OBJECTS "")

# Create the executable
add_executable(Koneko ${SOURCES})

# Set target properties
set_target_properties(Koneko PROPERTIES
    WIN32_EXECUTABLE TRUE
    OUTPUT_NAME "Koneko"
)

# Add include directories
target_include_directories(Koneko PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/headers
)

# Link Windows libraries
target_link_libraries(Koneko
    -lkernel32
    -lntdll
    -luser32
    -ladvapi32
)

# Compiler flags
target_compile_options(Koneko PRIVATE
    -fno-stack-protector
    -fno-exceptions
    -fno-rtti
    -O2
    -D_WIN32_WINNT=0x0601
    -DWIN32_LEAN_AND_MEAN
)

# Assembly compilation temporarily disabled - using C++ stubs instead
# foreach(ASM_FILE ${ASM_SOURCES})
#     set(ASM_OBJ "${CMAKE_CURRENT_BINARY_DIR}/${ASM_FILE}.o")
#     add_custom_command(
#         OUTPUT ${ASM_OBJ}
#         COMMAND x86_64-w64-mingw32-as --64 ${CMAKE_CURRENT_SOURCE_DIR}/${ASM_FILE} -o ${ASM_OBJ}
#         DEPENDS ${ASM_FILE}
#         COMMENT "Assembling ${ASM_FILE} with NASM"
#     )
#     list(APPEND ASM_OBJECTS ${ASM_OBJ})
# endforeach()

# Add assembly objects as custom targets
# add_custom_target(asm_objects ALL DEPENDS ${ASM_OBJECTS})

# Link assembly objects
# if(ASM_OBJECTS)
#     target_link_libraries(Koneko ${ASM_OBJECTS})
#     add_dependencies(Koneko asm_objects)
# endif()