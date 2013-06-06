#!/bin/bash

MAKE="make -j16"

rm BUILD/stamp-glibc64 -f

GLIBC_CONFIG="--with-zrt=yes" \
${MAKE} install-glibc64
