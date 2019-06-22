#SDK/
#   |__ bin/
#   |__ include/
#   |__ lib/
#   |__ libexec/
#   |__ target/
#            |__ usr
#                   |__ include/
#                      |__ boost/
#                   |__ lib/
#
PWD=$(shell pwd)
SDK:=${PWD}/../Hi3516
CROSS_COMPILE_PREFIX:="arm-hisiv100-linux-uclibcgnueabi-"

######################################
MYTOOLCHAINROOT=${SDK}
MYSYSROOT=${SDK}/target
cflags="--sysroot=${MYSYSROOT}"
cxxflags=${cflags}
linkflags=${cflags}

NCPU=1
GCCVER=0.0
TARGET_OS=linux
define Exec_bootstrap
	cat <<EOF >user-config.jam 
	EOF
endef
.PHONY:install

install:b2
	PATH=${MYTOOLCHAINROOT}/bin:${PATH}	\
	./b2 -q                        					\
         --ignore-site-config           			\
	 --user-config=./user-config.jam	\
	-j${NCPU}		         				\
	 target-os=${TARGET_OS}	      	\
         toolset=gcc-${GCCVER}        		\
	 cflags=${cflags}            			\
         cxxflags=${cxxflags} 			\
	 linkflags=${linkflags}			\
         link=static                    				\
         threading=multi                			\
         --layout=versioned             			\
         ${WITHOUT_LIBRARIES}           	\
	 --prefix=${MYSYSROOT}/usr/local 	\
	 --debug-configuration			\
         install 

b2:
	./bootstrap.sh
	echo  "using gcc : ${GCCVER} : ${CROSS_COMPILE_PREFIX}g++ ; " >user-config.jam