#!/bin/bash
# this is a script shell for deploying a meshlab-portable app.
# Requires a properly built meshlab.
#
# Without given arguments, the folder that will be deployed is meshlab/distrib.
#
# You can give as argument the DISTRIB_PATH.
#
# After running this script, $DISTRIB_PATH/meshlab.app will be a portable meshlab application.

#realpath function
realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

SCRIPTS_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#checking for parameters
if [ "$#" -eq 0 ]
then
    INSTALL_PATH=$SCRIPTS_PATH/../../src/install
else
    INSTALL_PATH=$(realpath $1)
fi

APPNAME="meshlab.app"

echo "Hopefully I should find " $INSTALL_PATH/$APPNAME

if ! [ -e $INSTALL_PATH/$APPNAME -a -d $INSTALL_PATH/$APPNAME ]
then
    echo "Started in the wrong dir: I have not found the meshlab.app"
    exit -1
fi

#copy libIFX libraries and change rpath u3d plugin
#cp -a $DISTRIB_PATH/lib/meshlab/libIFX* $DISTRIB_PATH/$APPNAME/Contents/Frameworks
#rm $DISTRIB_PATH/$APPNAME/Contents/Frameworks/libIFXCoreStatic.a
#install_name_tool -change libIFXCore.1.so @rpath/libIFXCore.1.so $DISTRIB_PATH/$APPNAME/Contents/PlugIns/libio_u3d.dylib
#install_name_tool -change libIFXExporting.1.so @rpath/libIFXExporting.1.so $DISTRIB_PATH/$APPNAME/Contents/PlugIns/libio_u3d.dylib
#install_name_tool -change libIFXScheduling.1.so @rpath/libIFXScheduling.1.so $DISTRIB_PATH/$APPNAME/Contents/PlugIns/libio_u3d.dylib

if [ -e $QTDIR/bin/macdeployqt ]
then
    $QTDIR/bin/macdeployqt $INSTALL_PATH/$APPNAME
else
    macdeployqt $INSTALL_PATH/$APPNAME
fi
