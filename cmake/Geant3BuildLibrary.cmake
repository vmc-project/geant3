#------------------------------------------------
# The Virtual Monte Carlo packages
# Copyright (C) 2014 Ivana Hrivnacova
# All rights reserved.
#
# For the licensing terms see geant4_vmc/LICENSE.
# Contact: vmc@pcroot.cern.ch
#-------------------------------------------------

# CMake Configuration file for geant4_vmc
# I. Hrivnacova, 13/06/2014

#---CMake required version -----------------------------------------------------
cmake_minimum_required(VERSION 2.6 FATAL_ERROR)

#-- ROOT (required) ------------------------------------------------------------
if(NOT ROOT_FOUND)
  find_package(ROOT REQUIRED)
endif(NOT ROOT_FOUND)  
include_directories(${ROOT_INCLUDE_DIRS})

#-------------------------------------------------------------------------------
# Setup project include directories; compile definitions; link libraries
#
include_directories(
  ${PROJECT_SOURCE_DIR}
  ${PROJECT_SOURCE_DIR}/minicern
  ${PROJECT_SOURCE_DIR}/TGeant3 
  ${CMAKE_CURRENT_BINARY_DIR})

#-------------------------------------------------------------------------------
# Generate Root dictionaries
#
ROOT_GENERATE_DICTIONARY(
  geant3vmcDict
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/G3Material.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/G3Medium.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/G3Node.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/G3Volume.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/TCallf77.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/TG3Application.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/TGeant3f77.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/TGeant3gu.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/TGeant3.h
  ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/TGeant3TGeo.h
  LINKDEF ${CMAKE_CURRENT_SOURCE_DIR}/TGeant3/geant3LinkDef.h)

#-------------------------------------------------------------------------------
# Locate sources for this project
#
set(directories
    added gbase gcons geocad ggeom gheisha ghits ghrout ghutils giface giopa gkine gparal gphys gscan gstrag gtrak matx55 miface miguti neutron peanut fiface cgpack fluka block comad erdecks erpremc minicern gdraw
    )

# Fortran sources
set(fortran_sources gcinit.F)
foreach(_directory ${directories})
  file(GLOB add_f_sources 
       ${PROJECT_SOURCE_DIR}/${_directory}/*.F)
  list(APPEND fortran_sources ${add_f_sources})
endforeach()
list(APPEND fortran_sources ${PROJECT_SOURCE_DIR}/minicern/lnxgs/rdmin.F)

# Exclude some files from the list
list(REMOVE_ITEM fortran_sources ${PROJECT_SOURCE_DIR}/gtrak/grndm.F)
list(REMOVE_ITEM fortran_sources ${PROJECT_SOURCE_DIR}/gtrak/grndmq.F)
list(REMOVE_ITEM fortran_sources ${PROJECT_SOURCE_DIR}/erdecks/eustep.F)

message(STATUS "fortran_sources ${fortran_sources}")
       
# C sources
set(c_sources)
foreach(_directory ${directories})
  file(GLOB add_c_sources 
       ${PROJECT_SOURCE_DIR}/${_directory}/*.c)
  list(APPEND c_sources ${add_c_sources})
endforeach()
list(APPEND c_sources ${PROJECT_SOURCE_DIR}/minicern/lnxgs/ishftr.c)
# Linux specific, the file is kept on macosx, macosx64)
list(REMOVE_ITEM c_sources ${PROJECT_SOURCE_DIR}/minicern/lnblnk.c)

message(STATUS "c_sources ${c_sources}")
       
# C++ sources
file(GLOB cxx_sources 
     ${PROJECT_SOURCE_DIR}/comad/gcadd.cxx
     ${PROJECT_SOURCE_DIR}/TGeant3/*.cxx)
message(STATUS "cxx_sources ${cxx_sources}")
       
#-------------------------------------------------------------------------------
# Locate headers for this project
#
file(GLOB headers ${PROJECT_SOURCE_DIR}/TGeant3/*.h)

#---Add definitions-------------------------------------------------------------
# TODO: make this properly !!
add_definitions(-DCERNLIB_LXIA64 -DCERNLIB_BLDLIB -DCERNLIB_CZ -DCERNLIB_GFORTRAN)

#---Add library-----------------------------------------------------------------
add_library(geant321 ${fortran_sources} ${c_sources} ${cxx_sources} geant3vmcDict.cxx ${headers})
target_link_libraries(geant321 ${ROOT_LIBRARIES} -lVMC -lEG)

#----Installation---------------------------------------------------------------
install(FILES ${headers} DESTINATION include/TGeant3)
install(TARGETS geant321 EXPORT Geant3Targets DESTINATION ${CMAKE_INSTALL_LIBDIR})
