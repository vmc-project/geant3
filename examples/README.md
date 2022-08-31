### Examples

The directory examples includes a set of FORTRAN examples
like gexam1.F, gexam3.F, gexam4.F and model.F, plus the ROOT (C++) macros
E01.C, E02.C, E03.C

To build the examples gexam1,3 and 4 run the scripts bind_gexam1,3,4
bind_gexam1
```bash
  gexam1
  read 4
  stop
  root >  gMC->ProcessRun(10)
  root > .q
```
same for gexam3,4, model.

To run the E01.C, E02.C and E03.C examples (common to Geant3 and 4), do
root > .x E01.C

These scripts require the geant4_vmc file in a separate tar file.

At present, the geant3 package is tested only using the test suites defined
in geant4_vmc/examples.
