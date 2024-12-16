# Copyright (c) 2013-2017, Ruslan Baratov
# Copyright (c) 2018, Richard Hodges

# All rights reserved.

if(DEFINED POLLY_CXX20_CMAKE_)
  return()
else()
  set(POLLY_CXX20_CMAKE_ 1)
endif()

# Don't use polly_init (no generator expected)
set(POLLY_TOOLCHAIN_NAME "C++20 support")
set(POLLY_TOOLCHAIN_TAG "cxx20")

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")

set(CMAKE_CXX_STANDARD 20)
