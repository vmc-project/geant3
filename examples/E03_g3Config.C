// $Id: g3Config.C,v 1.1 2003/03/17 14:56:50 brun Exp $
//
// Configuration macro for Geant3 VirtualMC for Example03

void Config()
{
  TGeant3* geant3
    = new  TGeant3("C++ Interface to Geant3"); 
  
  cout << "Geant3 has been created." << endl;

  geant3->SetDRAY(1);
  geant3->SetLOSS(1);
  geant3->SetHADR(0);
}


