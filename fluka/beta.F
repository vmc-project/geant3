*
* $Id: beta.F,v 1.1.1.1 2002/06/16 15:18:36 hristov Exp $
*
* $Log: beta.F,v $
* Revision 1.1.1.1  2002/06/16 15:18:36  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:15  fca
* AliRoot sources
*
* Revision 1.1.1.1  1995/10/24 10:19:59  cernlib
* Geant
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 29/03/94  15.41.44  by  S.Giani
*-- Author :
*$ CREATE BETA.FOR
*COPY BETA
*
*=== beta =============================================================*
*
      FUNCTION BETA(X1,X2,BET)
 
#include "geant321/dblprc.inc"
#include "geant321/dimpar.inc"
#include "geant321/iounit.inc"
      AX=0.D0
      BETX1=BET*X1
      IF(BETX1.LT.70.D0) AX=-1.D0/BET**2*(BETX1+1.D0)*EXP(-BETX1)
      AY=1.D0/BET**2*(BET*X2+1.D0)*EXP(-BET*X2)
      BETA=AX+AY
      RETURN
      END
