cmake_minimum_required(VERSION 2.8.7)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)
#-----------------------------------------------------------------------------
# Dashboard properties
#-----------------------------------------------------------------------------
set(HOSTNAME              "factory-south-ubuntu")
set(CTEST_DASHBOARD_ROOT  "$ENV{HOME}/Dashboards/Nightly/")

#-----------------------------------------------------------------------------
# Dashboard options
#-----------------------------------------------------------------------------
set(EXTENSIONS_BUILDSYSTEM_TESTING TRUE)
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
#set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY ) # for example: $ENV{HOME}/Projects/Doxygen
set(CTEST_BUILD_CONFIGURATION "Release")
set(CTEST_BUILD_FLAGS "-j5 -l4") # Use multiple CPU cores to build. For example "-j4 -l3" on unix

#
# Dashboard type
#
set(SCRIPT_MODE "nightly") # "experimental", "continuous", "nightly"


#-----------------------------------------------------------------------------
# Additional CMakeCache options
#-----------------------------------------------------------------------------
set(ADDITIONAL_CMAKECACHE_OPTION "
  ADDITIONAL_C_FLAGS:STRING=
  ADDITIONAL_CXX_FLAGS:STRING=
")

#-----------------------------------------------------------------------------
# Set any extra environment variables here
#-----------------------------------------------------------------------------
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()

#-----------------------------------------------------------------------------
# Git tag
#-----------------------------------------------------------------------------
set(EXTENSIONS_TRACK_QUALIFIER "master") # "master", 4.1, ...
set(EXTENSIONS_INDEX_GIT_TAG "origin/${EXTENSIONS_TRACK_QUALIFIER}") # origin/master, origin/4.1, ...

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicerextensions_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

#-----------------------------------------------------------------------------
# Build Name
#-----------------------------------------------------------------------------
# Update the following variable to match the chosen build options. This variable is used to
# generate both the build directory and the build name.
set(BUILD_OPTIONS_STRING "${MY_BITNESS}bits-QT${MY_QT_VERSION}-PythonQt-With-Tcl-CLI")

#-----------------------------------------------------------------------------
# Build directories
#-----------------------------------------------------------------------------
set(dir_suffix ${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE})

set(Slicer_DIR "${CTEST_DASHBOARD_ROOT}/Slicer-build-${dir_suffix}/Slicer-build")

set(testing_suffix "")
if(EXTENSIONS_BUILDSYSTEM_TESTING)
  set(testing_suffix "-Testing")
endif()

set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/SlicerExtensions-build-${dir_suffix}${testing_suffix}-${EXTENSIONS_TRACK_QUALIFIER}")

#-----------------------------------------------------------------------------
# Source directories
#-----------------------------------------------------------------------------
set(EXTENSIONS_BUILDSYSTEM_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer4/Extensions/CMake")

##########################################
# WARNING: DO NOT EDIT BEYOND THIS POINT #
##########################################

set(CTEST_NOTES_FILES "${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}")

#
# Project specific properties
#
set(CTEST_PROJECT_NAME "Slicer4")
set(CTEST_BUILD_NAME "${MY_OPERATING_SYSTEM}-${MY_COMPILER}-${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}")

#
# Download and include dashboard driver script
#
set(url http://svn.slicer.org/Slicer4/trunk/Extensions/CMake/SlicerExtensionsDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
include(${dest})
