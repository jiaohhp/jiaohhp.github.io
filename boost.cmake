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
#自定义变量
if(not defined SDK)
    set(SDK "${CMAKE_SOURCE_DIR}/../Hi3516")
endif()

if(not defined CROSS_COMPILE_PREFIX)
    SET(CROSS_COMPILE_PREFIX "arm-hisiv100-linux-uclibcgnueabi-")
endif()

#---------- 接下来的通用设置 ----------------------
set(MYSYSROOT "${SDK}/target")
set(MYTOOLCHAINROOT "${SDK}")

set(CMAKE_SYSTEM_NAME Linux)

#编译器
set(CMAKE_C_COMPILER   ${MYTOOLCHAINROOT}/bin/${CROSS_COMPILE_PREFIX}gcc)
set(CMAKE_CXX_COMPILER   ${MYTOOLCHAINROOT}/bin/${CROSS_COMPILE_PREFIX}g++)
set(CMAKE_C_FLAGS "--sysroot=${MYSYSROOT}" CACHE INTERNAL "" FORCE)
set(CMAKE_C_LINK_FLAGS "--sysroot=${MYSYSROOT}" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_FLAGS "--sysroot=${MYSYSROOT}" CACHE INTERNAL "" FORCE)
set(CMAKE_CXX_LINK_FLAGS "--sysroot=${MYSYSROOT}" CACHE INTERNAL "" FORCE)

cmake_minimum_required(VERSION 3.1)

set(INSTALL_BOOST 
	"./b2 -q                        	\
         --ignore-site-config           	\
	 --user-config=./user-config.jam	\
 	 -j2		                      	\
	 target-os=linux	        	\
         toolset=gcc-arm	        	\
	 cflags=${CMAKE_C_FLAGS}              	\
         cxxflags=${cxxflags}                 	\
	 linkflags=${CMAKE_CXX_LINK_FLAGS}	\
         link=static                    	\
         threading=multi                	\
         --layout=versioned             	\
         ${WITHOUT_LIBRARIES}           	\
	 --prefix=${MYSYSROOT}/usr/local 	\
	 --debug-configuration			\
         install >&build.log              	\
         || echo "ERROR: Failed to build boost !"\
	 )
add_custom_target(all DEPENDS b2 install)
add_custom_target(install DEPENDS b2 COMMAND ${INSTALL_BOOST} )
add_custom_command(b2 COMMAND ${INSTALL_BOOST})
