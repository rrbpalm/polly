# Copyright (c) 2015-2017, Ruslan Baratov
# Copyright (c) 2015, David Hirvonen
# All rights reserved.

if(DEFINED POLLY_ANDROID_NDK_R18B_API_19_ARMEABI_V7A_NEON_CLANG_LIBCXX17_CMAKE_)
  return()
else()
  set(POLLY_ANDROID_NDK_R18B_API_19_ARMEABI_V7A_NEON_CLANG_LIBCXX17_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_clear_environment_variables.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

set(ANDROID_NDK_VERSION "r18b")
set(CMAKE_SYSTEM_VERSION "19")
set(CMAKE_ANDROID_ARCH_ABI "armeabi-v7a")
set(CMAKE_ANDROID_ARM_NEON TRUE)
set(CMAKE_ANDROID_ARM_MODE TRUE) # 32-bit ARM
set(CMAKE_ANDROID_NDK_TOOLCHAIN_VERSION "clang")
set(CMAKE_ANDROID_STL_TYPE "c++_static") # LLVM libc++ static

polly_init(
    "Android NDK ${ANDROID_NDK_VERSION} / \
API ${CMAKE_SYSTEM_VERSION} / ${CMAKE_ANDROID_ARCH_ABI} / \
NEON / 32-bit ARM / Clang / c++17 support / libc++ static"
    "Unix Makefiles"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx17.cmake") # before toolchain!

include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/os/android.cmake")
