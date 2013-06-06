#!/bin/bash

MAKE="make -j16"
TOOLCHAINLOC=~

rm BUILD/stamp-glibc64 -f

GLIBC_CONFIG="--enable-shared=no --with-zrt=yes" \
${MAKE} install-glibc64 TOOLCHAINLOC=${TOOLCHAINLOC}
