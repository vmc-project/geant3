#include "TG3Application.h"
#include "TRint.h"
extern "C" 
{
   void uginit_();
   void uglast_();   
}
//______________________________________________________________________________
int main(int argc, char **argv)
{
   // Create an interactive ROOT application
   TG3Application g3("G3","dummy");
   
   uginit_();
   
   TRint theApp("Rint", &argc, argv);

   // and enter the event loop...
   theApp.Run(kTRUE);

   uglast_();

   return 0;
}
