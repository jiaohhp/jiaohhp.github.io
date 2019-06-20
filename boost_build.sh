#!/bin/sh
#build and install to sysroot

SDK=${PWD}/../HI3516
CROSS_COMPILE_PREFIX=arm-hisiv100-linux-uclibcgnueabi-
BOOST_SOURCE=${PWD}
###################################################################################
MYSYSROOT=${SDK}/target
MYTOOLCHAINROOT=${SDK}
FLAGS_SYSROOT="--sysroot=${MYTOOLCHAINROOT}"
BOOST_BUILD_DIR=${PWD}

#gen 
${BOOST_SOURCE}/bootstrap.sh

#mod
cat <<EOF >user-config.jam
using gcc : 4.4 : ${CROSS_COMPILE_PREFIX}g++ ;
EOF

#build
export PATH=${SDK}/bin:${PATH}

#test
${CROSS_COMPILE_PREFIX}gcc -v

./b2 install toolset=gcc-4.4 --user-config=./user-config.jam cxxflags=${FLAGS_SYSROOT} cflags=${FLAGS_SYSROOT} linkflags=${FLAGS_SYSROOT} --debug-configuration --prefix=${MYSYSROOT}/usr/local --build-dir=${BOOST_BUILD_DIR} -sBOOST_ROOT=${BOOST_SOURCE} target-os=linux --with-thread
