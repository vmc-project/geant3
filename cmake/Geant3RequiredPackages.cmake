#------------------------------------------------
# The Virtual Monte Carlo packages
# Copyright (C) 2019 Ivana Hrivnacova
# All rights reserved.
#
# For the licensing terms see geant4_vmc/LICENSE.
# Contact: root-vmc@cern.ch
#-------------------------------------------------

# Configuration file for CMake build for geant3
# which finds all required packages.
#
# I. Hrivnacova, 15/04/2019

#-- ROOT (required) ------------------------------------------------------------
find_package(ROOT CONFIG COMPONENTS EG Geom REQUIRED)
set(ROOT_DEPS ROOT::Core ROOT::RIO ROOT::Tree ROOT::Rint ROOT::Physics
    ROOT::MathCore ROOT::Thread ROOT::Geom ROOT::EG ROOT::EGPythia6)
include(${ROOT_USE_FILE})

#-- VMC (required) ------------------------------------------------------------
find_package(VMC CONFIG)
# first try VMC standalone (default)
if(VMC_FOUND)
  set(VMC_DEPS VMCLibrary)
  if(NOT VMC_FIND_QUIETLY)
    message(STATUS "Found VMC ${VMC_VERSION} in ${VMC_DIR}")
  endif()
else()
  # otherwise fallback to ROOT's internal if possible (deprecated)
  if(ROOT_vmc_FOUND)
    message(WARNING "Using VMC built with ROOT - Deprecated")
    set(VMC_DEPS ROOT::VMC)
    add_definitions(-DUSE_ROOT_VMC)
  else()
    message(FATAL_ERROR
            "Could not find VMC package. "
            "VMC package is not provided with ROOT since v6.26/00. "
            "Please, install it from https://github.com/vmc-project/vmc. ")
  endif()
endif()
