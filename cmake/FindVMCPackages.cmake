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
option(VMC_INSTALL_EXAMPLES "Install examples libraries and programs" ON)
option(BUILD_SHARED_LIBS    "Build the dynamic libraries" ON)

#---Find required packages------------------------------------------------------

# ROOT (required)
find_package(ROOT CONFIG REQUIRED)
# Cannot mix VMC standalone and vmc in ROOT (deprecated)
if(ROOT_vmc_FOUND)
  message(FATAL_ERROR
          "Cannot use VMC standalone with ROOT built with vmc.")
endif()
include(${ROOT_USE_FILE})
set (ROOT_LIBRARIES ${ROOT_LIBRARIES} -lEG -lGeom)

#-- VMC (required) ------------------------------------------------------------
find_package(VMC CONFIG REQUIRED)

# If all required packages above were found we can update VMC_FOUND
set(VMCPackages_FOUND TRUE)
