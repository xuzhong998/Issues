文章目录
前言
一、Qemu是什么？
二、操作步骤
1.环境准备
(1).qemu安装
(2).QEMU_EFI.fd：镜像启动时的BIOS。
(3).ARM系统的.iso镜像：
(4).制作镜像
(5).准备目录
2.安装虚拟机
3.启动虚拟机
总结
前言
随着国产化的浪潮一步一步的加大，我们接触的国产系统和国产硬件也在不断的增多，忍不住的吐槽，现在的硬件是真的倒退了好多年，而且也特别的贵，但是为支持国产，我们也需要更多的进行国产化的适配和学习，linux下搭建比较简单，windows则比较复杂，那么这里就简单介绍下在windows下使用Qemu模拟Arm处理器，运行麒麟系统。

一、Qemu是什么？
QEMU是一套由法布里斯·贝拉(Fabrice Bellard)所编写的以GPL许可证分发源码的模拟处理器，在GNU/Linux平台上使用广泛。Bochs，PearPC等与其类似，但不具备其许多特性，比如高速度及跨平台的特性，通过KQEMU这个闭源的加速器，QEMU能模拟至接近真实电脑的速度。---------来自百度百科的解释。

二、操作步骤
1.环境准备
(1).qemu安装
https://qemu.weilnetz.de/w64/
阿里云盘下载：https://www.aliyundrive.com/s/MyCbbau45ZP

(2).QEMU_EFI.fd：镜像启动时的BIOS。
http://releases.linaro.org/components/kernel/uefi-linaro/latest/release/qemu64/
这里只需要QEMU_EFI.fd即可

(3).ARM系统的.iso镜像：
这个根据自己的需要选择不同的镜像使用，我这里提供 下我的麒麟镜像系统使用。
阿里云盘下载：链接：https://pan.baidu.com/s/1QJ-7WwhTWCtARxa-g-R8Bg
提取码：2tjr

(4).制作镜像
进入Qemu的目录，使用CMD命令行输入以下命令。注：我这里是演示，10G，制作镜像大小根据需要设置，建议60G。

qemu-img.exe create F:\qemu_vam\img\kylinDesktop.img 10G
1
执行如下图方式，制作成功


(5).准备目录
建议有一个目录层次，强迫症吧。
Qemu 安装位置：E:\qemu
准备目录如下图
bios目录存放QEMU_EFI.fd
img目录存放制作好的镜像文件
ios目录存放iso镜像
外面两个脚本文件，install是安装虚拟机系统，start是启动虚拟机系统


2.安装虚拟机
准备好环境后，install脚本中的内容，执行即可，脚本内容如下：

E:\qemu\qemu-system-aarch64.exe -m 4096 -cpu cortex-a72 -smp 2,cores=2,threads=1,sockets=1 -M virt -biosF:\qemu_vam\bios\QEMU_EFI.fd -net nic,model=pcnet -device nec-usb-xhci -device usb-kbd -device usb-mouse -device VGA -drive if=none,file=F:\qemu_vam\iso\Kylin-Desktop-V10-Release-Build1-210122-arm64.iso,id=cdrom,media=cdrom -device virtio-scsi-device -device scsi-cd,drive=cdrom -drive if=none,file=F:\qemu_vam\img\kylinDesktop.im,id=hd0 -device virtio-blk-device,drive=hd0
1
名称	注释
:\qemu\qemu-system-aarch64.exe	二进制文件，提供模拟aarch64架构的虚拟机进程
-m 4096	分配4096 MB内存
-M virt	模拟成什么服务器，我们一般选择virt就可以了，他会自动选择最高版本的virt
-cpu cortex-a72	模拟成什么CPU，其中cortex-a53\a57\a72都是ARMv8指令集的
-smp 2,cores=2,threads=1,sockets=1	2个vCPU，这2个vCPU由qemu模拟出的一个插槽（socket）中的2个核心，每个
-bios xxx	指定bios bin所在的路径
-device xxx	添加一个设备，参数可重复
-drive	添加一个驱动器，参数可重复
-net	添加网络设备
代码中几个路径要注意下，替换成自己的就行了 。更多的Qemu指令可以去官网学习。
这个过程比较漫长，中间有安装过程，和平时的安装一样，按照安装就行了

3.启动虚拟机
E:\qemu\qemu-system-aarch64.exe -m 8192 -cpu cortex-a72 -smp 2,cores=2,threads=1,sockets=1 -M virt -bios F:\qemuArm\bios\QEMU_EFI.fd -device nec-usb-xhci -device usb-kbd -device usb-mouse -device VGA -device virtio-scsi-device -drive if=none,file=F:\qemuArm\vm\test\hdd1.img,id=hd0 -device virtio-blk-device,drive=hd0
1
总结
若是没有时间去安装，也可以去下载安装好的https://download.csdn.net/download/h1007886499/36792244
————————————————
版权声明：本文为CSDN博主「h1007886499」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/h1007886499/article/details/121110333