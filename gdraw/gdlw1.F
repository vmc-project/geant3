*
* $Id: gdlw1.F,v 1.1.1.1 2002/06/16 15:18:37 hristov Exp $
*
* $Log: gdlw1.F,v $
* Revision 1.1.1.1  2002/06/16 15:18:37  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:03  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:20:23  cernlib
* Geant
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 29/03/94  15.41.26  by  S.Giani
*-- Author :
      SUBROUTINE GDLW1(LW)
C.
C.    ******************************************************************
C.    *                                                                *
C.    *       Change phisically the line width to LW                   *
C.    *                                                                *
C.    *    ==>Called by : GDRAWP, GDRAWT                               *
C.    *       Author : P.Zanarini   *********                          *
C.    *                                                                *
C.    ******************************************************************
C.
      SAVE IOLD
      DATA IOLD/-1/
C.
C.    ------------------------------------------------------------------
C.
      LINW=MOD(IABS(LW),8)
C
      IF (LINW.NE.IOLD)THEN
         IOLD=LINW
         CALL ISLWSC(FLOAT(LINW))
      ENDIF
      END
