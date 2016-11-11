# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_OS_ANDROID_CMAKE_)
  return()
else()
  set(POLLY_OS_ANDROID_CMAKE_ 1)
endif()

include(polly_fatal_error)

string(COMPARE EQUAL "${ANDROID_NDK_VERSION}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("ANDROID_NDK_VERSION is not defined")
endif()

set(_env_ndk "$ENV{ANDROID_NDK_${ANDROID_NDK_VERSION}}")
string(COMPARE EQUAL "${_env_ndk}" "" _is_empty)
if(_is_empty)
  polly_fatal_error(
      "Environment variable 'ANDROID_NDK_${ANDROID_NDK_VERSION}' not set"
  )
endif()

set(ANDROID_NDK "${_env_ndk}")

string(COMPARE EQUAL "${CMAKE_SYSTEM_VERSION}" "" _is_empty)
if(_is_empty)
  polly_fatal_error("CMAKE_SYSTEM_VERSION is not defined")
endif()

set(CMAKE_SYSTEM_NAME "Android")

if(CMAKE_VERSION VERSION_LESS 3.7)
  polly_fatal_error("Minimum CMake version for Android is 3.7")
endif()

macro(find_host_program)
 set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
 set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
 set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
 if(CMAKE_HOST_WIN32)
  set(WIN32 1)
  set(UNIX)
 elseif(CMAKE_HOST_APPLE)
  set(APPLE 1)
  set(UNIX)
 endif()
 find_program(${ARGN})
 set(WIN32)
 set(APPLE)
 set(UNIX 1)
 set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM ONLY)
 set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
 set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
endmacro()
