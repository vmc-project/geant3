# $ Id:  $

############################### geant321 Makefile #############################

PACKAGE   = geant321

ifeq ($(PLATFORM),)
PLATFORM = $(shell uname)
endif

BINDIR  = tgt_$(PLATFORM)
LIBDIR  = $(shell pwd)/lib/tgt_$(PLATFORM)

include config/Makefile.$(PLATFORM)

############################### Sources #######################################

GDIRS:=	added gbase gcons gdraw geocad ggeom gheisha ghits ghrout ghutils \
	giface giopa gkine gparal gphys gscan gstrag gtrak matx55 miface \
	miguti neutron peanut fiface cgpack fluka block comad erdecks erpremc \
        minicern

include config/MakeRules

# Dummy library (should be avoidable!)

DSRCS          = TGeant3/TGeant3Dummy.cxx

# C++ Headers

DHDRS          = TGeant3/TGeant3.h TGeant3/geant3LinkDef.h

# Dummy library dictionary

DDICT          = $(BINDIR)/TGeant3/geant3DummyCint.cxx
DDICTH         = $(DDICT:.cxx=.h)
DDICTO         = $(patsubst %.cxx,%.o,$(DDICT))

# Dummy Geant Objects

DOBJS          = $(patsubst %.cxx,$(BINDIR)/%.o,$(DSRCS)) $(DDICTO)

# Library dictionary

GDICT    := $(BINDIR)/TGeant3/geant3Cint.cxx
GDICTH   := $(DICT:.cxx=.h)
GDICTO   := $(patsubst %.cxx,%.o,$(GDICT))

# Sources

FSRC	:= $(wildcard $(patsubst %,%/*.F,$(GDIRS))) gcinit.F TGeant3/galicef.F
FSRC	:= $(filter-out gtrak/grndm%.F,$(FSRC))
ifeq ($(PLATFORM),Linux)
	  FSRC += minicern/lnxgs/rdmin.F
endif
ifneq ($(PLATFORM),SunOS)
	  FSRC := $(filter-out minicern/uset.F,$(FSRC))
endif
CSRC	:= $(wildcard $(patsubst %,%/*.c,$(GDIRS))) 
ifeq ($(PLATFORM),Linux)
	  CSRC += minicern/lnxgs/ishftr.c
endif
ifeq ($(PLATFORM),HP-UX)
	  CSRC += minicern/hpxgs/traceqc.c
endif
ifneq ($(PLATFORM),HP-UX)
	  CSRC := $(filter-out minicern/lnblnk.c,$(CSRC)) 
endif
CXXSRC	:= $(wildcard $(patsubst %,%/*.cxx,$(GDIRS))) \
           $(filter-out TGeant3/TGeant3Dummy.cxx,$(wildcard TGeant3/*.cxx))
SRCS	:= $(FSRC) $(CSRC) $(CXXSRC)

# C++ Headers

HDRS    := $(CXXSRC:.cxx=.h) TGeant3/geant3LinkDef.h
HDRS	:= $(filter-out comad/gcadd.h,$(HDRS))  

# Objects

FOBJ	:= $(patsubst %.F,$(BINDIR)/%.o,$(FSRC))
COBJ	:= $(patsubst %.c,$(BINDIR)/%.o,$(CSRC))
CXXOBJ	:= $(patsubst %.cxx,$(BINDIR)/%.o,$(CXXSRC))
OBJS	:= $(FOBJ) $(COBJ) $(CXXOBJ) $(GDICTO)

# C++ compilation flags

CXXFLAGS := $(CXXOPTS) $(CLIBCXXOPTS) $(CLIBDEFS) -I. \
			-I$(ROOTSYS)/include -ITGeant3

# C compilation flags

CFLAGS      := $(COPT) $(CLIBCOPT) $(CLIBDEFS) -I. -Iminicern

# FORTRAN compilation flags

FFLAGS      := $(FOPT) $(CLIBFOPT) $(CLIBDEFS) -I. -Iminicern
ifeq ($(PLATFORM),Linux)
   FFLAGS      := $(filter-out -O%,$(FFLAGS))  
endif

DEPINC 		+= -I. -I$(ROOTSYS)/include

############################### Targets #######################################


SLIBRARY	= $(LIBDIR)/lib$(PACKAGE).$(SL) $(LIBDIR)/libG3mcDummy.$(SL) 
ALIBRARY	= $(LIBDIR)/lib$(PACKAGE).a

ifeq ($(PLATFORM),OSF1)
        default:	depend $(ALIBRARY) $(SLIBRARY) 
else
        default:	depend $(SLIBRARY)
endif

$(LIBDIR)/lib$(PACKAGE).$(SL):  $(OBJS)
$(LIBDIR)/lib$(PACKAGE).a:  $(OBJS)

$(LIBDIR)/libG3mcDummy.$(SL):	$(DOBJS)
$(LIBDIR)/libG3mcDummy.a:	$(DOBJS)

DICT:= $(GDICT) $(DDICT)

$(GDICT): $(HDRS)

$(DDICT): $(DHDRS)

depend:		$(SRCS)

TOCLEAN		= $(BINDIR)
TOCLEANALL		= $(BINDIR) $(LIBDIR)

include config/MakeMacros

############################### Dependencies ##################################

-include $(BINDIR)/Make-depend
