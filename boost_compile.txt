windows -> 单独编译某个模块，比如filesystem模块
  .\bootstrap.sh
	.\b2.exe define=BOOST_USE_WINAPI_VERSION=0x0501 runtime-link=static address-model=32 toolset=msvc-14.1 --with-filesystem --with-thread --with-date_time
	.\b2.exe define=BOOST_USE_WINAPI_VERSION=0x0501 address-model=32 toolset=msvc-14.1
	命令解释：
	define=BOOST_USE_WINAPI_VERSION=0x0501 指定boost调用的windows api 的版本
	runtime-link 指定编译为静态库
	address-model=32 指定仅编译x86平台
	toolset=msvc-14.1 指定使用vc2017编译
	--with-filesystem 指定仅仅编译filesystem模块
  
 arm  ->
   ./bootstrap.sh
   编辑./project-config.jam
   替换using gcc ; 为 using gcc : arm : xx ;
   ./b2 toolset=gcc-arm
   中间有些模块可能会出错，一般某些函数被裁减掉了，只需要关闭某些boost宏就行了
   
   
   
 #源码外编译，不污染源码目录
 1. 在编译目录执行 bootstrap.sh
 2. 修改project-config.jam配置文件,在using gcc ; 下新增 using gcc : HI3516 : arm-hisiv100-linux-uclibcgnueabi-g++ ;
 3. 在编译目录执行 ./b2 -sBOOST_ROOT=boost's_source_root  --debug-configuration
 
 
 #错误的user-config.jam，但是不知道哪里错了！！！！
 local SDK = "$(BOOST_BUILD_PATH)/../HI3516" ;
local CROSS_COMPILE_PREFIX = "arm-hisiv100-linux-uclibcgnueabi-" ;

###############################
local MYSYSROOT = "$(SDK)/target" ;
local MYTOOLCHAINROOT = "$(SDK)" ;
using gcc : arm-hisiv100-linux-uclibcgnueabi : "$(MYTOOLCHAINROOT)/bin/$(CROSS_COMPILE_PREFIX)g++" : <compileflags>"--sysroot=$(MYSYSROOT)" <linkflags>"--sysroot=$(MYSYSROOT)" ;

