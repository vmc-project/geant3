*
* $Id: eustep.F,v 1.1.1.1 2002/07/24 15:56:26 rdm Exp $
*
* $Log: eustep.F,v $
* Revision 1.1.1.1  2002/07/24 15:56:26  rdm
* initial import into CVS
*
* Revision 1.1.1.1  2002/06/16 15:18:36  hristov
* Separate distribution  of Geant3
*
* Revision 1.1.1.1  1999/05/18 15:55:15  fca
* AliRoot sources
*
* Revision 1.1.1.1  1996/03/06 15:37:35  mclareni
* Add geane321 source directories
*
*
#include "geant321/pilot.h"
*CMZ :  3.21/02 29/03/94  15.41.49  by  S.Giani
*-- Author :
      SUBROUTINE EUSTEP
* modified by A.Rotondi & A.Fontana 
* may 2007
* (to be used to find the closest approach to a point
*  and to a wire)
*
#include "geant321/gcflag.inc"
#include "geant321/gctrak.inc"
#include "geant321/gconst.inc"
#include "geant321/gccuts.inc"
#include "geant321/gcmore.inc"
*
      INTEGER*4 ICC,CFLAG
      SAVE ICC
      REAL*4 DIST2,PRDIST2
      INTEGER*4 COUNT
      REAL*4 PZ(3)
      SAVE PRDIST2,COUNT
      REAL*4 D2X,D2Y,D2Z,AMODD
      DATA ICC/0/,COUNT/0/
*
      CFLAG=ICLOSE
      IF (IDEBUG*ISWIT(2).NE.0) CALL ERXYZC
      IF(CFLAG.EQ.1) THEN
            DO K=1,3
	       PZ(K)=0.
	    ENDDO
            IF(ICC.EQ.0) PRDIST2=BIG
            DIST2 = (VECT(1)-PFINAL(1))**2+(VECT(2)-PFINAL(2))**2
     +            + (VECT(3)-PFINAL(3))**2
           IF((SQRT(DIST2)-SQRT(PRDIST2)).LT.1.E-3) THEN
	       PRDIST2 = DIST2
               ICC=ICC+1
 	    ELSE
	       ISTOP = 2
	    ENDIF
	    COUNT = COUNT + 1
	    CLENG(1) = CLENG(2)
	    CLENG(2) = CLENG(3)   
	    CLENG(3) = SLENG
            CALL UCOPY(P2,P1,3)
	    CALL UCOPY(P3,P2,3)
	    CALL UCOPY(VECT,P3,3)
	    IF(COUNT.EQ.3.OR.ISTOP.EQ.2) THEN	  
	       COUNT = 0
	    ENDIF
	    IF(ISTOP.EQ.2) THEN
	       IF(ICC.LE.3) THEN
	          CALL UCOPY(VECT,P1,3)	    
                  CALL UCOPY(PZ,P2,3)
	          CALL UCOPY(PZ,P3,3)
	          PRINT *,'Warning! User requested less than 3 steps.'  
	       ENDIF
	       ICC=0
	    ENDIF
      ELSE IF(CFLAG.EQ.2) THEN
            DO K=1,3
	       PZ(K)=0.
	    ENDDO
            IF(ICC.EQ.0) PRDIST2=BIG
            D2X = (WIRE2(2)-WIRE1(2))*(WIRE1(3)-VECT(3))
     +          - (WIRE2(3)-WIRE1(3))*(WIRE1(2)-VECT(2)) 
            D2Y = (WIRE2(3)-WIRE1(3))*(WIRE1(1)-VECT(1))
     +          - (WIRE2(1)-WIRE1(1))*(WIRE1(3)-VECT(3)) 
            D2Z = (WIRE2(1)-WIRE1(1))*(WIRE1(2)-VECT(2))
     +          - (WIRE2(2)-WIRE1(2))*(WIRE1(1)-VECT(1)) 
	    AMODD = (WIRE2(1)-WIRE1(1))**2 + (WIRE2(2)-WIRE1(2))**2 
     +            + (WIRE2(3)-WIRE1(3))**2   
	    DIST2 = (D2X**2 + D2Y**2 + D2Z**2)/AMODD
           IF((SQRT(DIST2)-SQRT(PRDIST2)).LT.1.E-3) THEN
	       PRDIST2 = DIST2
               ICC=ICC+1
 	    ELSE
	       ISTOP = 2
	    ENDIF
	    COUNT = COUNT + 1  
	    CLENG(1) = CLENG(2)
	    CLENG(2) = CLENG(3)   
	    CLENG(3) = SLENG
            CALL UCOPY(P2,P1,3)
	    CALL UCOPY(P3,P2,3)
	    CALL UCOPY(VECT,P3,3)
	    IF(COUNT.EQ.3.OR.ISTOP.EQ.2) THEN	  
	       COUNT = 0
	    ENDIF
	    IF(ISTOP.EQ.2) THEN
	       IF(ICC.LE.3) THEN
	          CALL UCOPY(VECT,P1,3)	    
                  CALL UCOPY(PZ,P2,3)
	          CALL UCOPY(PZ,P3,3)
	          PRINT *,'Warning! User requested less than 3 steps.'  
	       ENDIF
	       ICC=0
	    ENDIF
       ENDIF
*
      END
