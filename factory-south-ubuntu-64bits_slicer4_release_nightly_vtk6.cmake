cmake_minimum_required(VERSION 2.8.2)

include(${CTEST_SCRIPT_DIRECTORY}/CMakeDashboardScriptUtils.cmake)

#
# Dashboard properties
#
set(HOSTNAME              "factory-south-ubuntu")
set(CTEST_DASHBOARD_ROOT  "$ENV{HOME}/Dashboards/Nightly/")

#
# Dashboard options
#
set(WITH_KWSTYLE FALSE)
set(WITH_MEMCHECK FALSE)
set(WITH_COVERAGE FALSE)
set(WITH_DOCUMENTATION FALSE)
set(DOCUMENTATION_ARCHIVES_OUTPUT_DIRECTORY )
set(WITH_PACKAGES TRUE)
set(WITH_EXTENSIONS FALSE) # Indicates if 'trusted' Slicer extensions should be
                          # built, tested, packaged and uploaded.
set(CTEST_BUILD_CONFIGURATION "Release")
set(CTEST_BUILD_FLAGS "-j5 -l4") # Use multiple CPU cores to build. For example "-j4 -l3" on unix

set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_slicer_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

set(SCRIPT_MODE "nightly") # "experimental", "continuous", "nightly"

# You could invoke the script with the following syntax:
#  ctest -S karakoram_Slicer4_nightly.cmake -V

#
# Additional CMakeCache options
#
set(ADDITIONAL_CMAKECACHE_OPTION "
  ADDITIONAL_C_FLAGS:STRING=
  ADDITIONAL_CXX_FLAGS:STRING=
  Slicer_USE_VTK_DEBUG_LEAKS:BOOL=OFF
  Slicer_BUILD_CLI:BOOL=ON
  Slicer_USE_SimpleITK:BOOL=ON
  DOXYGEN_EXECUTABLE:FILEPATH=/home/kitware/Dashboards/Support/doxygen-1.7.4/bin/doxygen
  Slicer_USE_PYTHONQT_WITH_OPENSSL:BOOL=ON
  VTK_VERSION_MAJOR:STRING=6
")

set(BUILD_OPTIONS_STRING "64bits-QT${MY_QT_VERSION}-PythonQt-With-Tcl-CLI-VTK6")

#
# Project specific properties
#
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer4")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/Slicer-build-${BUILD_OPTIONS_STRING}-${CTEST_BUILD_CONFIGURATION}-${SCRIPT_MODE}")

# List of test that should be explicitly disabled on this machine
set(TEST_TO_EXCLUDE_REGEX "qMRMLLayoutManagerTest3")

# set any extra environment variables here
if(UNIX)
  set(ENV{DISPLAY} ":0")
endif()


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
# Display build info
#
message("site name: ${CTEST_SITE}")
message("build name: ${CTEST_BUILD_NAME}")
message("script mode: ${SCRIPT_MODE}")
message("coverage: ${WITH_COVERAGE}, memcheck: ${WITH_MEMCHECK}")

#
# Download and include dashboard driver script
#
set(url http://svn.slicer.org/Slicer4/trunk/CMake/SlicerDashboardDriverScript.cmake)
set(dest ${CTEST_SCRIPT_DIRECTORY}/${CTEST_SCRIPT_NAME}.driver)
download_file(${url} ${dest})
INCLUDE(${dest})
