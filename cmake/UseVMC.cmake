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

if (NOT VMC_FOUND)
  find_package(VMC REQUIRED)
endif(NOT VMC_FOUND)

set(VMC_LIBRARIES)

if(ROOT_FOUND)
  include_directories(${ROOT_INCLUDE_DIRS})
endif(ROOT_FOUND)

if(Geant4_FOUND)
  add_definitions(-DUSE_GEANT4) 
  include(${Geant4_USE_FILE})
  
  if(Geant4VMC_FOUND)
    include_directories(${Geant4VMC_INCLUDE_DIRS})
    set(VMC_LIBRARIES ${VMC_LIBRARIES} ${Geant4VMC_LIBRARIES})
  endif(Geant4VMC_FOUND)

  if(G4Root_FOUND)
    set(VMC_LIBRARIES ${VMC_LIBRARIES} ${G4Root_LIBRARIES})
  endif(G4Root_FOUND)

  if(VGM_FOUND)
    set(VMC_LIBRARIES ${VMC_LIBRARIES} ${VGM_LIBRARIES})
  endif(VGM_FOUND)

  set(VMC_LIBRARIES ${VMC_LIBRARIES} ${Geant4_LIBRARIES})

endif(Geant4_FOUND)

if(Geant3_FOUND)
  add_definitions(-DUSE_GEANT3) 
  include_directories(${Geant3_INCLUDE_DIRS})
  
  #Pythia6
  if(Pythia6_FOUND)
    set(VMC_LIBRARIES ${VMC_LIBRARIES} ${Pythia6_LIBRARIES} ${Geant3_LIBRARIES})
  else()
    set(VMC_LIBRARIES ${Geant3_LIBRARIES} ${VMC_LIBRARIES})
  endif(Pythia6_FOUND)
    
endif(Geant3_FOUND)

# MTRoot
if (MTRoot_FOUND)
  include_directories(${MTRoot_INCLUDE_DIRS})
  set(VMC_LIBRARIES ${MTRoot_LIBRARIES} ${VMC_LIBRARIES})
endif(MTRoot_FOUND)

# Finally add Root libraries
set(VMC_LIBRARIES ${VMC_LIBRARIES} ${ROOT_LIBRARIES} -lVMC -lEG)

#message(STATUS "VMC_LIBRARIES ${VMC_LIBRARIES}")
