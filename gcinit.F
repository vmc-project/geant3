      SUBROUTINE G3CINIT
#include "geant321/pilot.h"
#include "geant321/gcbank.inc"
*
* Initialise geant system with a default dimension of NWGEANT
*
      CALL G3ZEBRA(NWGEANT)
      CALL G3INIT()
      CALL G3ZINIT()
*
      END
