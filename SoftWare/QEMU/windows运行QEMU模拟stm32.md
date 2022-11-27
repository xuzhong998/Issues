# 去下载支持stm32f103的魔改qemu编译好的exe文件

https://github.com/xpack-dev-tools/qemu-arm-xpack/releases/

这个不用安装，只需要加入环境变量即可（目的是为了任何地方打开命令行powershell，都能调用到这个 qemu-system-gnuarmeclipse.exe）


# 我们随便打开一个powershell命令行窗口，可以发现是支持模拟stm32-p103这个板子的

```powershell
 qemu-system-gnuarmeclipse.exe -M ?
```



# 去github下载stm32-p103这个板子的各种demo程序

https://github.com/beckus/stm32_p103_demos （对了顺便说一下，这个的qume的串口输出不到控制台，原作者自己也说了不知道为什么，而且多个博客也看到有人说printf无效的。想输出到控制台，可以看我别的qemu文章，你一定会有收获的）

1. 确保自己电脑的环境变量已经有 mingw32-make.exe了，然后在这个makefile文件这儿打开powershell命令行窗口，直接 mingw32-make.exe 命令即可，等待一下，就全部编译完成了

   ```powershell
   mingw32-make.exe
   ```

2. 在demo文件夹内，每个demo例程中都会生成一个目标文件了，在对应demo中打开powershell,我们下载它到板子上

   ```powershell
   qemu-system-gnuarmeclipse.exe -M STM32-P103 -kernel main.bin
   ```

   