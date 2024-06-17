## 一. nvm, vue, npm,node 是什么关系, 分别是什么

### 1. nvm、vue、npm 和 node 定义:

- nvm:Node Version Manager 的简称。它是一个 node 版本管理器,可以很方便地在同一台机器上安装和切换不同版本的 node。
- node:Node.js 运行时环境。它允许在服务端运行 JavaScript 代码。
- npm:Node Package Manager 的简称。它是 node 的包管理器,用来安装和管理各种 node 模块和包。
- vue:一个用于创建 web 用户界面的渐进式框架。它有效地组织代码结构,提高开发效率。

### 2. 他们之间的关系是:

- nvm 用于安装和管理不同版本的 node
- node 中内置了 npm 模块,用于加载和管理包
- vue 是一个基于 node 的前端 JS 框架
- vue 和它的许多相关包可通过 npm 进行安装使用

### 总结一下:

- nvm:节点版本管理器
- node:JavaScript 运行时环境
- npm:node 的包管理器
- vue:基于 node 的前端框架

nvm 控制着 node 的版本。npm 是 node 的一部分,用于管理包。vue 通过 npm 安装,并基于 node 运行。

所以 nvm 和 node 是底层环境,npm 和 vue 是上层应用。它们互相依赖使用,共同组成了一个 JS 开发环境。

## 二. 如何安装nvm

## 1.NVM安装

中文, 国内下载
	https://nvm.uihtm.com/
源地址下载Github
	https://github.com/coreybutler/nvm-windows/releases

## 2.node和npm安装

通过NVM安装
		命令行:

```sh
nvm install latest # latest或者改成具体版本号, 通过 nvm list available查看
```

## 3.node和npm使能

通过NVM命令行:
```sh
nvm on # 或者nvm use <version>, version可以通过npm list 查看已安装版本
```

## 4.通过npm安装全局vue

```sh
npm install -g @vue/cli
```

验证:

```sh
nvm -v
node -v
npm -v
vue -V # 可能在windows上失败, 在windows powershell上管理员执行 Get-ExecutionPolicy, 若是 Restricted 则要修改为 RemoteSigned, 执行Set-ExecutionPolicy RemoteSigned 即可
```