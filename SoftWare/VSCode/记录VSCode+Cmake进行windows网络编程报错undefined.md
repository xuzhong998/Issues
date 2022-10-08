##### 注:如需看解决方法, 请直接跳到最后, 中间是思考和解决过程.

#### 我写了个windows下网络tcp客户端代码, 在CMakeLists.txt里设置编译成库libtransport.a,  在

### VSCode + CMake 在windows网络编程报以下错误:

```sh
[main] Building folder: xxxxx
[build] Starting build
[proc] Executing command: E:\envirenment\cmake-3.24.2-windows-x86_64\bin\cmake.EXE --build d:/MQTT/xxxxx/build --config Debug --target all -j 18 --
[build] Consolidate compiler generated dependencies of target pahoMqtt
[build] Consolidate compiler generated dependencies of target transport
[build] [ 68%] Built target pahoMqtt
[build] [ 81%] Built target transport
[build] Consolidate compiler generated dependencies of target appWindows
[build] [ 87%] Linking C executable appWindows.exe
[build] CMakeFiles\appWindows.dir/objects.a(transport.c.obj): In function `transport_sendPacketBuffer':
[build] D:/MQTT/xxxxx/src/windows/transport.c:43: undefined reference to `_imp__send@16'
[build] CMakeFiles\appWindows.dir/objects.a(transport.c.obj): In function `transport_getdata':
[build] D:/MQTT/xxxxx/src/windows/transport.c:50: undefined reference to `_imp__recv@16'
[build] CMakeFiles\appWindows.dir/objects.a(transport.c.obj): In function `transport_getdatanb':
[build] D:/MQTT/xxxxx/src/windows/transport.c:62: undefined reference to `_imp__recv@16'
[build] CMakeFiles\appWindows.dir/objects.a(transport.c.obj): In function `transport_open':
[build] D:/MQTT/xxxxx/src/windows/transport.c:81: undefined reference to `_imp__WSAStartup@8'
[build] D:/MQTT/xxxxx/src/windows/transport.c:85: undefined reference to `_imp__socket@12'
[build] D:/MQTT/xxxxx/src/windows/transport.c:97: undefined reference to `_imp__htons@4'
[build] D:/MQTT/xxxxx/src/windows/transport.c:98: undefined reference to `_imp__inet_addr@4'
[build] D:/MQTT/xxxxx/src/windows/transport.c:100: undefined reference to `_imp__connect@12'
[build] CMakeFiles\appWindows.dir/objects.a(transport.c.obj): In function `transport_close':
[build] D:/MQTT/xxxxx/src/windows/transport.c:120: undefined reference to `_imp__WSACleanup@0'
[build] D:/MQTT/xxxxx/src/windows/transport.c:121: undefined reference to `_imp__recv@16'
[build] D:/MQTT/xxxxx/src/windows/transport.c:122: undefined reference to `_imp__closesocket@4'
[build] collect2.exe: error: ld returned 1 exit status
[build] mingw32-make.exe[2]: *** [CMakeFiles\appWindows.dir\build.make:118: appWindows.exe] Error 1
[build] mingw32-make.exe[1]: *** [CMakeFiles\Makefile2:139: CMakeFiles/appWindows.dir/all] Error 2
[build] mingw32-make.exe: *** [Makefile:90: all] Error 2
[proc] The command: E:\envirenment\cmake-3.24.2-windows-x86_64\bin\cmake.EXE --build d:/MQTT/xxxxx/build --config Debug --target all -j 18 -- exited with code: 2 and signal: null
[build] Build finished with exit code 2

```

### 解决过程:

1.刚开始以为是该报错文件的正确包含windows网络编程文件, 于是网查, 只需要包含winsock2.h或者winsock.h即可, 查看代码已包含:

```C
#include <winsock.h>
#include <windows.h>
#include <unistd.h>
#include <stdio.h>
```

2.于是网查, 发现很多人不用cmake也有这个错, 是因为找不到网络链接库 libws2_32.a 或者是libwsock32.a这个库, 我是用的ws2_32这个, 遂添加 CFLAG 参数, 在CMakeLists.txt添加:

```txt
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lws2_32")
```

编译后链接时还是报错.

于是有说在task.json的args下添加, 想了想, CMake配置不依赖task.json, 但还是试一试 ,果然无效.

3.网查, 说看下库的符号表有没有, 通过命令 nm -A libtransport.a 查看该库的符号表, 能够看到函数, 且报错的函数符号表是从外部引用的, 说明build 对, link不对.

4.于是手工gcc 编译 , 加上参数 -lws2_32 , 结果通过了, 说明在CMakeLists.txt里设置CFLAGS不能解决这个问题, 于是突然想到cmake能够找到我的编译链, 那么就能找到编译链里面的 ws2_32, 那我直接在CMakeLists.txt里添加库应该能解决, 于是在add_library(transport "transport.c")下一行添加:

```txt
target_link_libraries(transport ws2_32)
```

至此问题解决.希望有同样环境同样问题的小伙伴少走弯路, 我搞了一天才搞好, 还是自己的编译基础不扎实.记录下自己的弯路.