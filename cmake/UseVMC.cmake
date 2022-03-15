#------------------------------------------------
# The Virtual Monte Carlo packages
# Copyright (C) 2014 - 2017 Ivana Hrivnacova
# All rights reserved.
#
# For the licensing terms see geant4_vmc/LICENSE.
# Contact: root-vmc@cern.ch
#-------------------------------------------------

# Configuration file for CMake build for VMC applications.
# It defines include directories, compile definitions and link libraries
# (VMCPackages_LIBRARIES) for all required and optional packages.
# It also defines the default build mode a default build configuration.
#
# I. Hrivnacova, 26/02/2014

#message(STATUS "Processing UseVMC.cmake")

#-------------------------------------------------------------------------------
# Default project build mode
#
include(VMCBuildMode)

#-------------------------------------------------------------------------------
# Define include directories, compile definitions and link libraries
# (VMCPackages_LIBRARIES) for all required and optional packages.
#

if (NOT VMCPackages_FOUND)
  find_package(VMCPackages REQUIRED)
endif()

set(VMCPackages_LIBRARIES)

# ROOT (required)
include_directories(${ROOT_INCLUDE_DIRS})

# VMC (required)
include_directories(${VMC_INCLUDE_DIRS})

# Finally add Root libraries
set(VMCPackages_LIBRARIES ${VMCPackages_LIBRARIES} ${VMC_LIBRARIES})

# Finally add Root libraries
set(VMCPackages_LIBRARIES ${VMCPackages_LIBRARIES} ${ROOT_LIBRARIES})

# Utility to defined installation lib directory
if("${CMAKE_INSTALL_LIBDIR}" MATCHES "")
  include(VMCInstallLibDir)
endif()

#message(STATUS "VMCPackages_LIBRARIES ${VMCPackages_LIBRARIES}")
