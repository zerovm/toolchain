#!/bin/bash

MAKE="make -j16"
TOOLCHAINLOC=~

rm BUILD/stamp-glibc64 -f

GLIBC_CONFIG="--with-zrt=yes" \
GLIBC_CFLAGS="-DLIBC_ENOSYS_DEBUG" \
${MAKE} install-glibc64 TOOLCHAINLOC=${TOOLCHAINLOC}
