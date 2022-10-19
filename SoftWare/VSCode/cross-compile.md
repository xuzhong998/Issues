编译过程可能遇到的问题
home/t/toolchains/arm-hisiv400-linux/bin/../lib/gcc/arm-hisiv400-linux-gnueabi/4.8.3/../../../../arm-hisiv400-linux-gnueabi/bin/as: error while loading shared libraries: libz.so.1: cannot open shared object file: No such file or directory
安装：sudo apt-get install lib32z1 -y

新ubuntu环境、新arm-linux交叉工具链编译步骤：

# cd mosquitto-1.6.8

make CROSS_COMPILE=~/toolchains/arm-hisiv400-linux/bin/arm-hisiv400-linux-gnueabi- CC=gcc
可能遇到：home/t/toolchains/arm-hisiv400-linux/bin/../target/lib/librt.so.1: error adding symbols: DSO missing from command line 此时mosquito库已经生成了，可以无需关心该问题。
cp lib/libmosquitto.a ../iot-mqtt-sdk/lib/linux/
cd ../iot-mqtt-sdk

# cd  ../third-party/openssl-OpenSSL_1_1_1g

./config no-asm shared --prefix=/home/t/git/ccb-iot-sdk-c-v2.0/third-party/openssl-OpenSSL_1_1_1g/out CROSS_COMPILE=/home/t/toolchains/arm-hisiv400-linux/bin/arm-hisiv400-linux-gnueabi- CC=gcc
去掉Makefile中的两处m64，并执行make
cp libcrypto.so* ../../iot-mqtt-sdk//lib/linux/
cp libssl.so* ../../iot-mqtt-sdk//lib/linux/

make如果在挂载目录, 则会报错符号链接失败. 直接复制 *.so.1.1 然后改名为 *.so即可

交叉arm工具链构建

若出现 bin/sh^M 不存在目录或文件: 则 vim ./config , 然后:set ff=unix, wq保存退出即可

# cd ../curl-curl-7_61_1

修改buildconf的权限.

这里可能会安装两个东西:

1. sudo apt install autoconf
2. sudo apt install libtool

./buildconf 生成configure

./configure --host=arm-linux-gnueabi CC=/home/t/toolchains/arm-hisiv400-linux/bin/arm-hisiv400-linux-gnueabi-gcc
make