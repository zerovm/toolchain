#!/bin/bash

if [ "$ZEROVM_PORTS" = "" ]
then
ZEROVM_PORTS=~/git/zerovm-ports
fi

echo install zrt
cd $ZRT_ROOT
make clean all install || exit 1

cd $ZEROVM_PORTS/zlib
bash fetch_build_install.sh || exit 1

cd $ZEROVM_PORTS/bzip2
bash fetch_build_install.sh  || exit 1

cd $ZEROVM_PORTS/fuse
bash fetch_patch_build_install.sh || exit 1

cd $ZEROVM_PORTS/libarchive
bash fetch_patch_build_install.sh || exit 1

cd $ZEROVM_PORTS/archivemount
bash fetch_patch_build_install.sh || exit 1

echo install zrt fuse-ext
cd $ZRT_ROOT
FUSEGLUE_LDFLAGS="-archivemount" FUSEGLUE_EXT=1 make clean build install autotests || exit 1


