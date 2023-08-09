# 1 基础环境

## 1.1 插件

在插件商店搜索并安装C/C++（必须），Code Runner（非必须）

- C/C++

- Code Runner

  Code Runner支持一键调试，快速查看代码能否编译运行。

安装后将显示三角号标识，通过单击或者快捷键Ctrl+Alt+N，可以快速编译运行。

## 1.2 编译调试工具

gcc/g++编译工具必装，gdb调试工具必装。

```sh
$ sudo apt-get update
[有密码则输入密码]
$ sudo apt-get install gcc
[有密码则输入密码]
$ sudo apt-get install g++
[有密码则输入密码]
$ sudo apt-get install gdb
```

**PS**： 不同linux版本不同安装命令
一般来说著名的linux系统基本上分两大类：

1. RedHat系列：Redhat、Centos、Fedora等

2. Debian系列：Debian、Ubuntu等

**RedHat** 系列

1. 常见的安装包格式 rpm包,安装rpm包的命令是“rp m -参数”

2. 包管理工具 yum

3. 支持tar包

**Debian**系列

1. 常见的安装包格式 deb包,安装deb包的命令是“dpkg -参数”
2. 包管理工具 apt-get
3. 支持tar包

# 2 配置文件

## 2.1新建*.c文件

touch hello.c

```c
#include <stdio.h>

int main(void){
	printf("hello_world");
	return 0;
}
```

- 接下来在该目录下建立文件夹.vscode，并在文件中新建文件launch.json和task.json。
- 也可以F5调试，自动生成。

## 2.2 launch.json

将下面的配置文件写入。

```json
{
    // 使用 IntelliSense 了解相关属性。 
    // 悬停以查看现有属性的描述。
    // 欲了解更多信息，请访问: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "preLaunchTask": "build", //调试会话开始前执行的任务，一般为编译程序。与tasks.json的label相对应
            "name": "(gdb) Debug",       //配置文件的名字，可以随便起
            "type": "cppdbg",           //调试的类型，Vscode现在支持很多，我这里主要是C，所以只能是cppdbg
            "request": "launch",        //配置文件的请求类型，有launch和attach两种，具体看官方文档
            "targetArchitecture": "x64", //硬件内核架构，为64bit，如图设置
            "program": "${workspaceFolder}/${fileBasenameNoExtension}",   //可执行文件的路径和文件名称
            "args": [],                 //主函数调用时传入的参数
            "stopAtEntry": false,       //设为true时程序将暂停在程序入口处
            "cwd": "${workspaceFolder}",    //调试时的工作目录
            "environment": [],          //不知道干嘛的
            "internalConsoleOptions": "openOnSessionStart",
            "externalConsole": false,   //调试时是否显示控制台窗口
            "MIMode": "gdb",            //指定连接的调试器，可以省略不写
            "setupCommands": [
                {
                    "description": "为 gdb 启用整齐打印",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}
```

## 2.3 task.json

如果调试**C++**，将下面**command**配置成**g++**。



```json
{
	// See https://go.microsoft.com/fwlink/?LinkId=733558
	// for the documentation about the tasks.json format
	"version": "2.0.0",
	"tasks": [
		{
			"label": "build", // 任务名称，与launch.json的preLaunchTask相对应
			"type": "shell",
			"command": "gcc", // 要使用的编译器
			"args": [
				"${file}",
				"-o", // 指定输出文件名，不加该参数则默认输出a.exe，Linux下默认a.out
				"${fileDirname}/${fileBasenameNoExtension}",
				"-g", // 生成和调试有关的信息
				"-Wall", // 开启额外警告
			], // 编译命令参数
			"group": {
				"kind": "build",
				"isDefault": true // 设为false可做到一个tasks.json配置多个编译指令，需要自己修改本文件
			},
			"presentation": {
				"echo": true,
				"reveal": "always", // 在“终端”中显示编译信息的策略，可以为always，silent，never。具体参见VSC的文档
				"focus": true, // 设为true后可以使执行task时焦点聚集在终端
				"panel": "new" // 不同的文件的编译信息共享一个终端面板
			},
			// Use the standard MS compiler pattern to detect errors, warnings and infos
			"problemMatcher": "$msCompile"
		}
	]
}
```


## 2.4 调试

到这里没问题的话即可调试。用过IDE的同学，并不陌生了。

- 在要调试的位置加断点


- 
  快捷键F5，一键进入调试


如果有交互，在中断界面进行输入。


调试界面可以查看断点，变量以及监视变量等。

