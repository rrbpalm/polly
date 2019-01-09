# Copyright (c) 2018, Redrock Biometrics
# All rights reserved.

if(DEFINED POLLY_FLAGS_NOLOGO_CMAKE)
  return()
else()
  set(POLLY_FLAGS_NOLOGO_CMAKE 1)
endif()

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_CXX_FLAGS "/nologo")
polly_add_cache_flag(CMAKE_C_FLAGS "/nologo")
