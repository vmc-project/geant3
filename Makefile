# $Id: Makefile,v 1.22 2005/07/13 09:36:17 brun Exp $

############################### geant321 Makefile #############################

PACKAGE   = geant321
PACKAGE2  = dummies

ifeq ($(PLATFORM),)
PLATFORM = $(shell root-config --arch)
endif

BINDIR  = tgt_$(PLATFORM)
LIBDIR  = $(shell pwd)/lib/tgt_$(PLATFORM)
CONFDIR = $(shell pwd)/config

ifeq ($(ROOTSYS),)
ROOT_INCDIR = $(shell root-config --incdir)
ROOT_BINDIR = $(shell root-config --prefix)/bin
else
ROOT_INCDIR = $(ROOTSYS)/include
ROOT_BINDIR = $(ROOTSYS)/bin
endif

include $(CONFDIR)/Makefile.$(PLATFORM)

ifneq ($(findstring gcc,$(CC)),)
GCC_MAJOR    := $(shell $(CC) -dumpversion 2>&1 | cut -d'.' -f1)
GCC_MINOR    := $(shell $(CC) -dumpversion 2>&1 | cut -d'.' -f2)
GCC_VERS     := gcc-$(GCC_MAJOR).$(GCC_MINOR)
endif


############################### Sources #######################################

GDIRS:=	added gbase gcons geocad ggeom gheisha ghits ghrout ghutils \
	giface giopa gkine gparal gphys gscan gstrag gtrak matx55 miface \
	miguti neutron peanut fiface cgpack fluka block comad erdecks erpremc \
        minicern gdraw

include $(CONFDIR)/MakeRules


# C++ Headers

DHDRS          = TGeant3/TGeant3.h 


# Dummy Geant Objects

DOBJS          = $(patsubst %.cxx,$(BINDIR)/%.o,$(DSRCS))

# Library dictionary

GDICT    := $(BINDIR)/TGeant3/geant3Cint.cxx
GDICTH   := $(DICT:.cxx=.h)
GDICTO   := $(patsubst %.cxx,%.o,$(GDICT))

# Sources

FSRC	:= $(wildcard $(patsubst %,%/*.F,$(GDIRS))) gcinit.F TGeant3/galicef.F TGeant3/rdummies.F
FSRC	:= $(filter-out gtrak/grndm%.F,$(FSRC))
ifeq ($(PLATFORM),linux)
	  FSRC += minicern/lnxgs/rdmin.F
endif
ifneq ($(PLATFORM),solarisCC5)
	  FSRC := $(filter-out minicern/uset.F,$(FSRC))
endif
CSRC	:= $(wildcard $(patsubst %,%/*.c,$(GDIRS))) 
CSRC     := $(filter-out minicern/lnblnk.c,$(CSRC)) 
ifeq ($(PLATFORM),linux)
	  CSRC += minicern/lnxgs/ishftr.c
endif
ifeq ($(PLATFORM),macosx)
	  CSRC += minicern/lnxgs/ishftr.c
endif
ifeq ($(PLATFORM),linuxicc)
	  CSRC += minicern/lnxgs/ishftr.c
endif
ifeq ($(PLATFORM),linuxia64ecc)
	  CSRC += minicern/lnxgs/ishftr.c
endif
ifeq ($(PLATFORM),linuxx8664gcc)
	  CSRC += minicern/lnxgs/ishftr.c
endif
ifeq ($(PLATFORM),linuxia64gcc)
          CSRC += minicern/lnxgs/ishftr.c
endif
ifeq ($(PLATFORM),hpuxacc)
	  CSRC += minicern/hpxgs/traceqc.c
endif
ifeq ($(PLATFORM),hpuxacc)
	  CSRC += minicern/lnblnk.c
endif
ifeq ($(PLATFORM),macosx)
	  CSRC += minicern/lnblnk.c
endif
CSRC	:= $(filter-out added/dummies2.c,$(CSRC))

CXXSRC	:= $(wildcard $(patsubst %,%/*.cxx,$(GDIRS))) \
           $(wildcard TGeant3/*.cxx)
SRCS	:= $(FSRC) $(CSRC) $(CXXSRC)

# C++ Headers

HDRS    := $(CXXSRC:.cxx=.h) TGeant3/geant3LinkDef.h
HDRS	:= $(filter-out comad/gcadd.h,$(HDRS))  

# Objects

FOBJ	:= $(patsubst %.F,$(BINDIR)/%.o,$(FSRC))
COBJ	:= $(patsubst %.c,$(BINDIR)/%.o,$(CSRC))
CXXOBJ	:= $(patsubst %.cxx,$(BINDIR)/%.o,$(CXXSRC))
OBJS	:= $(FOBJ) $(COBJ) $(CXXOBJ) $(GDICTO)

# Dummies objects separated from geant321.so library

CSRC2	:= added/dummies2.c
COBJ2	:= $(patsubst %.c,$(BINDIR)/%.o,$(CSRC2))
OBJS2	:= $(COBJ2)


# C++ compilation flags

CXXFLAGS := $(CXXOPTS) $(CLIBCXXOPTS) -I. -I$(ROOT_INCDIR) -ITGeant3

# C compilation flags

CFLAGS      := $(COPT) $(CLIBCOPT) -I. -Iminicern

# FORTRAN compilation flags

FFLAGS      := $(FOPT) $(CLIBFOPT) -I. -Iminicern
# ifeq ($(PLATFORM),linux)
#    FFLAGS      := $(filter-out -O%,$(FFLAGS))  
# endif

DEPINC 		+= -I. -I$(ROOT_INCDIR)

############################### Targets #######################################


SLIBRARY	= $(LIBDIR)/lib$(PACKAGE).$(SL) $(LIBDIR)/lib$(PACKAGE2).$(SL)
ALIBRARY	= $(LIBDIR)/lib$(PACKAGE).a $(LIBDIR)/lib$(PACKAGE2).a

ifeq ($(PLATFORM),OSF1)
        default:	depend $(ALIBRARY) $(SLIBRARY) 
else
        default:	depend $(SLIBRARY)
endif

$(LIBDIR)/lib$(PACKAGE).$(SL):  $(OBJS)
$(LIBDIR)/lib$(PACKAGE).a:  $(OBJS)

$(LIBDIR)/lib$(PACKAGE2).$(SL):  $(OBJS2)
$(LIBDIR)/lib$(PACKAGE2).a:  $(OBJS2)

DICT:= $(GDICT) $(DDICT)

$(GDICT): $(HDRS)

$(DDICT): $(DHDRS)

depend:		$(SRCS)

TOCLEAN		= $(BINDIR)
TOCLEANALL	= $(BINDIR) $(LIBDIR)

MAKEDIST	= $(CONFDIR)/makedist.sh $(GCC_VERS) lib
MAKEDISTSRC	= $(CONFDIR)/makedist.sh $(GCC_VERS)

include $(CONFDIR)/MakeMacros

############################### Dependencies ##################################

-include $(BINDIR)/Make-depend
