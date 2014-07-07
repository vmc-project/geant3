#------------------------------------------------
# The Virtual Monte Carlo packages
# Copyright (C) 2014 Ivana Hrivnacova
# All rights reserved.
#
# For the licensing terms see geant4_vmc/LICENSE.
# Contact: vmc@pcroot.cern.ch
#-------------------------------------------------

# Configuration file for CMake build for VMC applications.
# It defines include directories, compile definitions and link libraries
# (VMC_LIBRARIES) for all required and optional packages.
#
# I. Hrivnacova, 26/02/2014

#message(STATUS "Processing UseVMC.cmake")

# ROOT (required)
if (NOT ROOT_FOUND)
  find_package(ROOT REQUIRED)
endif(NOT ROOT_FOUND)

# MTRoot (optional)
if(VMC_WITH_MTRoot)
  if (NOT MTRoot_FOUND)
    find_package(MTRoot REQUIRED)
  endif(NOT MTRoot_FOUND)
endif(VMC_WITH_MTRoot)
#find_package(MTRoot REQUIRED)

set(VMC_LIBRARIES)

if(ROOT_FOUND)
  include_directories(${ROOT_INCLUDE_DIRS})
endif(ROOT_FOUND)

# MTRoot
if (MTRoot_FOUND)
  include_directories(${MTRoot_INCLUDE_DIRS})
  set(VMC_LIBRARIES ${MTRoot_LIBRARIES} ${VMC_LIBRARIES})
endif(MTRoot_FOUND)

# Finally add Root libraries
set(VMC_LIBRARIES ${VMC_LIBRARIES} ${ROOT_LIBRARIES} -lVMC -lEG)

#message(STATUS "VMC_LIBRARIES ${VMC_LIBRARIES}")
