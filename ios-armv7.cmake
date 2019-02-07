# Copyright (c) 2016, Ruslan Baratov
# All rights reserved.
set(IOS_SDK_VERSION 12.1)
set(IOS_DEPLOYMENT_SDK_VERSION 8.0)

if(DEFINED POLLY_IOS_CMAKE_)
  return()
else()
  set(POLLY_IOS_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_module_path.cmake")
include(polly_clear_environment_variables)
include(polly_init)
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone-default-sdk.cmake") # -> IOS_SDK_VERSION

set(POLLY_XCODE_COMPILER "clang")
polly_init(
  "iOS ${IOS_SDK_VERSION} Universal (iphoneos + iphonesimulator) / \
${POLLY_XCODE_COMPILER} / \
c++14 support"
  "Xcode"
)

include(polly_common)
include(polly_fatal_error)

# # Fix try_compile
include(polly_ios_bundle_identifier)
set(CMAKE_MACOSX_BUNDLE YES)

set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer")

# 32 bits support was dropped from iPhoneSdk11.0
if(TRUE)
  set(IPHONEOS_ARCHS armv7)
  #set(IPHONESIMULATOR_ARCHS i386;x86_64)
else()
  polly_status_debug("iPhone11.0+ SDK detected, forcing 64 bits builds.")
  set(IPHONEOS_ARCHS arm64)
  set(IPHONESIMULATOR_ARCHS x86_64)
endif()

if(IOS_ARCHS MATCHES "arm64")
  set(AARCH64 1)
elseif(IOS_ARCHS MATCHES "armv")
  set(ARM 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")

if(NOT IOS_SDK_VERSION VERSION_LESS 10.0)
  include(polly_ios_development_team)
endif()
