#------------------------------------------------
# The Virtual Monte Carlo packages
# Copyright (C) 2014 Ivana Hrivnacova
# All rights reserved.
#
# For the licensing terms see geant4_vmc/LICENSE.
# Contact: root-vmc@cern.ch
#-------------------------------------------------

# Configuration file for CMake build for VMC applications.
# It finds the ROOT package (required) and MtRoot package (according
# to user selection) and sets VMCPackages_FOUND
#
# I. Hrivnacova, 26/02/2014

#---Options---------------------------------------------------------------------
option(VMC_WITH_MTRoot      "Build with MTRoot" ON)
option(VMC_INSTALL_EXAMPLES "Install examples libraries and programs" ON)
option(BUILD_SHARED_LIBS    "Build the dynamic libraries" ON)

#---Find required packages------------------------------------------------------

# ROOT (required)
find_package(ROOT CONFIG REQUIRED)
include(${ROOT_USE_FILE})
set (ROOT_LIBRARIES ${ROOT_LIBRARIES} -lEG -lGeom)

#-- VMC (required) ------------------------------------------------------------
# first try VMC standalone (default)
find_package(VMC CONFIG)
if(VMC_FOUND)
  if(NOT VMC_FIND_QUIETLY)
    message(STATUS "Found VMC ${VMC_VERSION} in ${VMC_DIR}")
  endif()
else()
  # otherwise fallback to ROOT's internal if possible (deprecated)
  if(ROOT_vmc_FOUND)
    message(WARNING "Using VMC built with ROOT - Deprecated")
    set(VMC_LIBRARIES "VMC")
  else()
    message(FATAL_ERROR
            "Could not find VMC package. "
            "VMC package is not provided with ROOT since v6.26/00. "
            "Please, install it from https://github.com/vmc-project/vmc. ")
  endif()
endif()

# MTRoot
if(VMC_WITH_MTRoot)
  # Do not search for MTRoot if building within Geant4VMC
  if (NOT Geant4VMC_BUILD_MTRoot)
    find_package(MTRoot REQUIRED)
  endif()
endif()

# If all required packages above were found we can update VMC_FOUND
set(VMCPackages_FOUND TRUE)
