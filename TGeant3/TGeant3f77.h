#ifndef ROOT_TGeant3f77
#define ROOT_TGeant3f77 
/* Copyright(c) 1998-1999, ALICE Experiment at CERN, All rights reserved. *
 * See cxx source for full Copyright notice                               */

/* $Id: TGeant3f77.h,v 1.4 2002/12/10 07:58:36 brun Exp $ */

//////////////////////////////////////////////// 
//  C++/f77 interface to Geant3 basic routines    // 
//////////////////////////////////////////////// 

#include "TGeant3.h" 

class TGeant3f77 : public TGeant3 { 

public: 
  TGeant3f77(); 
  TGeant3f77(const char *title, Int_t nwgeant=0); 
  virtual ~TGeant3f77() {}
 

private:
  TGeant3f77(const TGeant3f77 &) {}
  TGeant3f77 & operator=(const TGeant3f77&) {return *this;}
  
  ClassDef(TGeant3f77,1)  //C++/f77 interface to Geant basic routines 
}; 
#endif //ROOT_TGeant3f77
