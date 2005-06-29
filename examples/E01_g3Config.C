// $Id: E01_g3Config.C,v 1.1 2003/11/28 12:00:25 brun Exp $
//
// Configuration macro for Geant3 VMC for Example01 

void Config()
{
  if (strstr(gEnv->GetValue("TVirtualMC",""),"TGeant3TGeo")) {
     new  TGeant3TGeo("C++ Interface to Geant3 using TGeo");
     cout << "TGeant3TGeo has been created." << endl;
  } else {
     new  TGeant3("C++ Interface to Geant3");
     cout << "TGeant3 has been created." << endl;
  }
}


