*
* $Id$
*
* $Log: gcbank.inc,v $
* Revision 1.1.1.1  2002/06/16 15:18:38  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:16  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:20:31  cernlib
* Geant
*
*
#ifndef CERNLIB_GEANT321_GCBANK_INC
#define CERNLIB_GEANT321_GCBANK_INC
*
*
* gcbank.inc
*
#if !defined(CERNLIB_INCLUDE)
#if defined(CERNLIB_TYPE)
#include "geant321/gtbank.inc"
#endif
      PARAMETER (KWBANK=69000,KWWORK=5200)
      PARAMETER (NWGEANT=5000000)
      COMMON / GCBANK / GMEM(NWGEANT)
      EQUIVALENCE (NZEBRA,GMEM(1)), (GVERSN,GMEM(2)), (ZVERSN, GMEM(3))
      EQUIVALENCE (IXSTOR,GMEM(4)), (IXDIV,GMEM(5)), (IXCONS,GMEM(6))
      DIMENSION FENDQ(16)
      EQUIVALENCE (FENDQ(1),GMEM(7)), (LMAIN,GMEM(23)), (LR1,GMEM(24))
      DIMENSION WS(KWBANK)
      EQUIVALENCE (WS(1),GMEM(25))
      DIMENSION IQ(2),Q(2),LQ(8000),IWS(2)
      EQUIVALENCE (Q(1),IQ(1),LQ(9)),(LQ(1),LMAIN),(IWS(1),WS(1))
      EQUIVALENCE (JCG,JGSTAT)
#include "geant321/gclink.inc"
#endif
*
* gcbank.inc
*
#if defined(CERNLIB_INCLUDE)
*
#include "geant321/incbeg.inc"
     +   gcbank
#include "geant321/incend.inc"
#endif

#endif
