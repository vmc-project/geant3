// $Id: E03.C,v 1.2 2003/12/08 14:12:35 brun Exp $
//
// Macro for running Example03 with Geant3 
// Before running this macro, the libexampl03.so library
// must have been built. To build it, go to your geant4_vmc/examples directory
// and run make.
// Note that this macro is a simplified version of the equivalent macro
// in the geant4_vmc/examples/E03 directory

{
  // Load basic libraries
  gSystem->Load("libGeom");
  gSystem->Load("libVMC");
  gSystem->Load("libPhysics");
  gSystem->Load("libEG"); 
  gSystem->Load("libEGPythia6");
  gSystem->Load("libPythia6");  
  new TGeoManager("E02","test"); 
  
  // Load Geant3 libraries
  gSystem->Load("../lib/tgt_Linux/libdummies");
  gSystem->Load("../lib/tgt_Linux/libgeant321.so");
  
  // Load this example library
  gSystem->Load("~/geant4_vmc/lib/tgt_Linux/libexample03");

  // MC application
  Ex03MCApplication* appl 
    =  new Ex03MCApplication("Example03", "The example03 VMC application");
  appl->GetPrimaryGenerator()->SetNofPrimaries(20);
  appl->SetPrintModulo(1);

  appl->InitMC("E03_g3Config.C");

  // visualization setting
  gMC->Gsatt("*", "seen", 16);
  gMC->Gsatt("ABSO", "seen", 5);
  gMC->Gsatt("GAPX", "seen", 6);

  appl->RunMC(5);
}  