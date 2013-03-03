#!/bin/bash

MAKE="make -j16"
TOOLCHAINLOC=~

rm BUILD/stamp-glibc64 -f

${MAKE} -C${ZRT_ROOT} cleandep
${MAKE} -C${ZRT_ROOT} zlibc_dep

if [ ! -f ${ZRT_ROOT}/lib/zrt.o ]
then
	echo "${ZRT_ROOT}/lib/zrt.o file not exist"
	exit
fi

${MAKE} install-glibc64 TOOLCHAINLOC=${TOOLCHAINLOC}

${MAKE} -C${ZRT_ROOT} cleandep

