*
* $Id: gphini.F,v 1.1.1.1 2002/06/16 15:18:41 hristov Exp $
*
* $Log: gphini.F,v $
* Revision 1.1.1.1  2002/06/16 15:18:41  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:20  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:21:29  cernlib
* Geant
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 29/03/94  15.41.22  by  S.Giani
*-- Author :
      SUBROUTINE GPHINI
C.
C.    ******************************************************************
C.    *                                                                *
C     *       Initialize material constants for                        *
C.    *       the photoelectric effect                                 *
C.    *                                                                *
C.    *    ==>Called by : GPHYSI                                       *
C.    *       Author    J. Chwastowski                                 *
C.    *                                                                *
C.    ******************************************************************
C.
      CALL GPHRIN
      CALL GSHLIN
      CALL GPHXIN
      END
