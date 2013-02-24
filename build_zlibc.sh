#!/bin/bash

MAKE="make -j8"
TOOLCHAINLOC=~

rm BUILD/stamp-glibc64 -f
echo ${MAKE} -C${ZRT_ROOT} zlibc_dep
${MAKE} -C${ZRT_ROOT} zlibc_dep
ls ${ZRT_ROOT}/lib/zrt.o -l

#${MAKE} BUILD/stamp-glibc64 TOOLCHAINLOC=${TOOLCHAINLOC}
#${MAKE} export-headers TOOLCHAINLOC=${TOOLCHAINLOC}
#${MAKE} glibc-adhoc-files TOOLCHAINLOC=${TOOLCHAINLOC}

echo ${MAKE} install-glibc64 TOOLCHAINLOC=${TOOLCHAINLOC}
${MAKE} install-glibc64 TOOLCHAINLOC=${TOOLCHAINLOC}

echo ${MAKE} -C${ZRT_ROOT} cleanzrt0
${MAKE} -C${ZRT_ROOT} cleanzrt0

