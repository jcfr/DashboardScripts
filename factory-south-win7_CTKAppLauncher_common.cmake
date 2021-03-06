
message("-- Including ${CTEST_INCLUDED_SCRIPT_NAME}")

set(CTEST_TEST_TIMEOUT 20)

set(MY_QT_VERSION "4.7.4")
set(QT_QMAKE_EXECUTABLE   "C:/D/Support/qt-static-release-i386-4.7.4/bin/qmake.exe")

set(MIDAS_PACKAGES_CREDENTIAL_FILE "C:/D/Support/Kitware-MidasPackagesCredential.cmake")

#-----------------------------------------------------------------------------
# Display variables
#-----------------------------------------------------------------------------
foreach(var CTEST_TEST_TIMEOUT MY_QT_VERSION QT_QMAKE_EXECUTABLE
            MIDAS_PACKAGES_CREDENTIAL_FILE
            )
  message("-- ${var}: ${${var}}")
endforeach()

#-----------------------------------------------------------------------------
# Common settings
#-----------------------------------------------------------------------------
set(CTEST_INCLUDED_SCRIPT_NAME ${HOSTNAME}_common.cmake)
include(${CTEST_SCRIPT_DIRECTORY}/${CTEST_INCLUDED_SCRIPT_NAME})

