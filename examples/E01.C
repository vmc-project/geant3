// $Id: E01.C,v 1.1 2003/11/28 12:00:25 brun Exp $
//
// Macro for running Example01 with Geant3 

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
