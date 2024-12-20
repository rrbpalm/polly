# Copyright (c) 2014-2016, Ruslan Baratov
# All rights reserved.
cmake_minimum_required(VERSION 3.1)
set(IOS_DEPLOYMENT_SDK_VERSION "8.0")

if(DEFINED POLLY_IOS_NOCODESIGN_CMAKE_)
  return()
else()
  set(POLLY_IOS_NOCODESIGN_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_module_path.cmake")
include(polly_clear_environment_variables)
include(polly_init)

include("${CMAKE_CURRENT_LIST_DIR}/os/iphone-default-sdk.cmake") # -> IOS_SDK_VERSION, IOS_DEPLOYMENT_SDK_VERSION

set(POLLY_XCODE_COMPILER "clang")
polly_init(
    "iOS ${IOS_SDK_VERSION} / Deployment ${IOS_DEPLOYMENT_SDK_VERSION} / Universal (iphoneos + iphonesimulator) / \
${POLLY_XCODE_COMPILER} / \
c++14 support"
    "Xcode"
)

include(polly_common)

# Fix try_compile
include(polly_ios_bundle_identifier)
set(CMAKE_MACOSX_BUNDLE YES)

include("${CMAKE_CURRENT_LIST_DIR}/flags/ios_nocodesign.cmake")

# 32 bits support was dropped from iPhoneSdk11.0
if(TRUE)
  set(IPHONEOS_ARCHS arm64)
  set(IPHONESIMULATOR_ARCHS "")
  set(IOS TRUE)
elseif(IOS_SDK_VERSION VERSION_LESS "11.0")
  set(IPHONEOS_ARCHS armv7;armv7s;arm64)
  set(IPHONESIMULATOR_ARCHS i386;x86_64)
else()
  polly_status_debug("iPhone11.0+ SDK detected, forcing 64 bits builds.")
  set(IPHONEOS_ARCHS arm64)
  set(IPHONESIMULATOR_ARCHS x86_64)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx14.cmake")
