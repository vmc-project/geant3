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
  ${PROJECT_SOURCE_DIR}/TGeant3/include 
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
#set(directories
#    added gbase gcons geocad ggeom gheisha ghits ghrout ghutils giface giopa gkine gparal gphys gscan #gstrag gtrak matx55 miface miguti neutron peanut fiface cgpack fluka block comad erdecks erpremc minicern gdraw
#    )
set(directories gbase
    )

# Fortran sources
set(fortran_sources)
foreach(_directory ${directories})
  file(GLOB add_f_sources 
       ${PROJECT_SOURCE_DIR}/${_directory}/*.F)
  list(APPEND fortran_sources ${add_f_sources})
endforeach()
message(STATUS "fortran_sources ${fortran_sources}")
       
# Fortran *.o
set(fortran_objects)
foreach(_fortran_source ${fortran_sources})
  # get file name here
  get_filename_component(_name ${_fortran_source} NAME)
  message(STATUS "fortran file _name ${_name}")
  add_custom_command(
       OUTPUT  ${PROJECT_BINARY_DIR}/${_name}.o
       COMMAND gfortran -I${PROJECT_SOURCE_DIR} -I${PROJECT_SOURCE_DIR}/minicern
       ARGS  -c ${_fortran_source})
  #list(APPEND fortran_objects ${PROJECT_BINARY_DIR}/${_name}.o)
  list(APPEND fortran_objects ${OUTPUT})
endforeach()
message(STATUS "fortran_objects ${fortran_objects}")
       
# C sources
set(c_sources)
foreach(_directory ${directories})
  file(GLOB add_c_sources 
       ${PROJECT_SOURCE_DIR}/${_directory}/*.c)
  list(APPEND c_sources ${add_c_sources})
endforeach()
message(STATUS "c_sources ${c_sources}")
       
# C++ sources
file(GLOB cxx_sources 
     ${PROJECT_SOURCE_DIR}/TGeant3/*.cxx)
message(STATUS "cxx_sources ${cxx_sources}")
       
#-------------------------------------------------------------------------------
# Locate headers for this project
#

file(GLOB headers ${PROJECT_SOURCE_DIR}/TGeant3/*.h)

#---Add library-----------------------------------------------------------------
add_library(geant3 ${c_sources} ${cxx_sources} ${fortran_objects} geant3vmcDict.cxx ${headers})
target_link_libraries(geant3 ${ROOT_LIBRARIES} -lVMC -lEG)

#----Installation---------------------------------------------------------------
#install(DIRECTORY 
#  ${PROJECT_SOURCE_DIR}/global/include/
#  ${PROJECT_SOURCE_DIR}/geometry/include/ 
#  ${PROJECT_SOURCE_DIR}/digits+hits/include/ 
#  ${PROJECT_SOURCE_DIR}/physics/include/
#  ${PROJECT_SOURCE_DIR}/physics_list/include/ 
#  ${PROJECT_SOURCE_DIR}/event/include/
#  ${PROJECT_SOURCE_DIR}/run/include/
#  ${PROJECT_SOURCE_DIR}/visualization/include/ 
#  DESTINATION include/geant3)
install(TARGETS geant3 EXPORT Geant3Targets DESTINATION ${CMAKE_INSTALL_LIBDIR})
