#!/bin/sh
# $Id: $
# ---------------------------------------------------------------------
# Script to produce source and optionally binary distribution of geant3.
# Called by main Makefile.
#
# According to: 
# $ROOTSYS/build/unix/makedist.sh
# Author: Fons Rademakers, 29/2/2000
#
# Usage: makedist.sh [lib]
#
# By I.Hrivnacova, 7/10/2002

CURDIR=`pwd`

# gmake is called from geant3
cd ..

MAKELIB=$1
VERSION=`cat geant3/config/version_number`
MACHINE=`uname`
OSREL=`uname -r`
if [ "$MAKELIB" = "lib" ] ; then  
  TYPE=$MACHINE.$OSREL.
else   
  TYPE=""
fi  
TARFILE="geant321+_vmc".$VERSION.$TYPE"tar"

TAR=`which gtar`
dum=`echo $TAR | grep "no gtar"`
stat=$?
if [ "$TAR" = '' ] || [ $stat = 0 ]; then
   TAR="tar cvf"
   rm -f $TARFILE.gz
   EXCLUDE=
else 
   TAR=$TAR" zcvf"
   rm -f $TARFILE.gz
   TARFILE=$TARFILE".gz"
   EXCLUDE="--exclude CVS"
fi

SOURCES=`ls geant3`
SOURCES=`echo $SOURCES | sed s/"tgt_$MACHINE"//g`
if [ "$MAKELIB" != "lib" ] ; then  
  SOURCES=`echo $SOURCES | sed s/lib//g`
fi
for param in $SOURCES; do
  PSOURCES="$PSOURCES geant3/$param"
done      

$TAR $TARFILE $EXCLUDE $PSOURCES
cd $CURDIR

exit 0
