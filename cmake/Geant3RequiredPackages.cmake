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
# Cannot mix VMC standalone and vmc in ROOT (deprecated)
if(ROOT_vmc_FOUND)
  message(FATAL_ERROR
          "Cannot use VMC standalone with ROOT built with vmc.")
endif()
#set(ROOT_DEPS ROOT::Core ROOT::RIO ROOT::Tree ROOT::Rint ROOT::Physics
#    ROOT::MathCore ROOT::Thread ROOT::Geom ROOT::EG ROOT::EGPythia6)
set(ROOT_DEPS ROOT::Core ROOT::RIO ROOT::Tree ROOT::Rint ROOT::Physics
    ROOT::MathCore ROOT::Thread ROOT::Geom ROOT::EG)
include(${ROOT_USE_FILE})

#-- VMC (required) ------------------------------------------------------------
find_package(VMC CONFIG REQUIRED)
set(VMC_DEPS ${VMC_LIBRARIES})
