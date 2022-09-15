set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(tools $ENV{HOME}/tools/cross-pi-gcc-10.2.0-2)
set(rpi_root $ENV{HOME}/rpi-root)

set(CMAKE_SYSROOT ${rpi_root})
set(CMAKE_FIND_ROOT_PATH ${rpi_root})
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_LIBRARY_ARCHITECTURE arm-linux-gnueabihf)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fPIC -Wl,-rpath-link,${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE} -L${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}")
set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -Wl,-rpath-link,${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE} -L${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -Wl,-rpath-link,${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE} -L${CMAKE_SYSROOT}/usr/lib/${CMAKE_LIBRARY_ARCHITECTURE}")

SET(BIN_PREFIX ${tools}/bin/arm-linux-gnueabihf)
SET(CMAKE_C_COMPILER ${BIN_PREFIX}-gcc)
SET(CMAKE_CXX_COMPILER ${BIN_PREFIX}-g++)

set(ENABLE_COMPILE_FLAGS_FOR_TARGET "armhf")

message(STATUS "CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")

message(STATUS "CMAKE_SYSROOT: ${CMAKE_SYSROOT}")
message(STATUS "CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")
message(STATUS "CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")

add_definitions(-DHPDF_DLL)

# Manually link local libcamera
set(LIBCAMERA_VERSION 0.0.0)
set(LIBCAMERA_LINK_LIBRARIES ${CMAKE_SYSROOT}/usr/local/lib/${CMAKE_LIBRARY_ARCHITECTURE}/libcamera.so ${CMAKE_SYSROOT}/usr/local/lib/${CMAKE_LIBRARY_ARCHITECTURE}/libcamera-base.so)
set(LIBCAMERA_INCLUDE_DIRS ${CMAKE_SYSROOT}/usr/local/include/libcamera)
message(STATUS "libcamera version: ${LIBCAMERA_VERSION}")

include_directories(${CMAKE_SOURCE_DIR} ${LIBCAMERA_INCLUDE_DIRS})

# Manually include missing paths
include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_SYSROOT}/usr/include/${CMAKE_LIBRARY_ARCHITECTURE})
include_directories(${CMAKE_SOURCE_DIR} ${CMAKE_SYSROOT}/usr/include/libdrm)
include_directories(${CMAKE_SOURCE_DIR} lib)

# Fix for spdlog
set(CMAKE_THREAD_LIBS_INIT "-lpthread")

# Disable QT
set(ENABLE_QT 0)
