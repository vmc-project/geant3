// $Id: E01.C,v 1.2 2003/12/08 14:12:35 brun Exp $
//
// Macro for running Example01 with Geant3 
// Before running this macro, the libexampl01.so library
// must have been built. To build it, go to your geant4_vmc/examples directory
// and run make.
// Note that this macro is a simplified version of the equivalent macro
// in the geant4_vmc/examples/E01 directory

{
  // Load basic libraries
  gSystem->Load("libGeom");
  gSystem->Load("libVMC");
  gSystem->Load("libPhysics");
  gSystem->Load("libEG"); 
  gSystem->Load("libEGPythia6");
  gSystem->Load("libPythia6");  
  new TGeoManager("E01","test"); 
  
  // Load Geant3 libraries
  gSystem->Load("../lib/tgt_Linux/libdummies");
  gSystem->Load("../lib/tgt_Linux/libgeant321");
  
  // Load this example library
  gSystem->Load("~/geant4_vmc/lib/tgt_Linux/libexample01");

  // MC application
  Ex01MCApplication* appl 
    = new Ex01MCApplication("Example01", "The example01 VMC application");

  appl->InitMC("E01_g3Config.C");
  appl->RunMC(1);
}  
