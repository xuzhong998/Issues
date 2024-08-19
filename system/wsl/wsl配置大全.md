# WSL 配置大全

wsl2是windows下的linux子系统.

## 1.安装

### 旧版 WSL 的手动安装步骤

- 项目
- 2023/12/06
- 15 个参与者

反馈

本文内容[步骤 1 - 启用适用于 Linux 的 Windows 子系统](https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#step-1---enable-the-windows-subsystem-for-linux)[步骤 2 - 检查运行 WSL 2 的要求](https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#step-2---check-requirements-for-running-wsl-2)[步骤 3 - 启用虚拟机功能](https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#step-3---enable-virtual-machine-feature)[步骤 4 - 下载 Linux 内核更新包](https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)显示另外 5 个

为简单起见，通常建议使用 [`wsl --install`](https://learn.microsoft.com/zh-cn/windows/wsl/install) 安装适用于 Linux 的 Windows 子系统，但如果运行的是旧版 Windows，则可能不支持这种方式。 下面介绍了手动安装步骤。 如果在安装过程中遇到问题，请查看[疑难解答指南的安装部分](https://learn.microsoft.com/zh-cn/windows/wsl/troubleshooting#installation-issues)。

#### 步骤 1 - 启用适用于 Linux 的 Windows 子系统

需要先启用“适用于 Linux 的 Windows 子系统”可选功能，然后才能在 Windows 上安装 Linux 分发。

以管理员身份打开 PowerShell（“开始”菜单 >“PowerShell” >单击右键 >“以管理员身份运行”），然后输入以下命令：

PowerShell复制

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

建议现在转到步骤 #2，更新到 WSL 2，但如果只想安装 WSL 1，现在可以重新启动计算机，然后继续执行[步骤 6 - 安装所选的 Linux 发行版](https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#step-6---install-your-linux-distribution-of-choice)。 若要更新到 WSL 2，请等待重新启动计算机，然后继续执行下一步。

#### 步骤 2 - 检查运行 WSL 2 的要求

若要更新到 WSL 2，需要运行 Windows 10。

- 对于 x64 系统：版本 1903 或更高版本，内部版本为 18362.1049 或更高版本。
- 对于 ARM64 系统：版本 2004 或更高版本，内部版本为 19041 或更高版本。

或 Windows 11。

 备注

低于 18362 的版本不支持 WSL 2。 使用 [Windows Update 助手](https://www.microsoft.com/software-download/windows10)更新 Windows 版本。 Windows 版本 1903 支持也仅适用于 x64 系统。 如果使用的是 Arm64 版本的 Windows，则需要升级到 Windows 10 版本 2004 或更高版本才能完全访问 WSL 2。 有关详细信息，请参阅[WSL 2 即将支持 Windows 10 版本 1903 和 1909](https://devblogs.microsoft.com/commandline/wsl-2-support-is-coming-to-windows-10-versions-1903-and-1909)。

若要检查 Windows 版本及内部版本号，选择 Windows 徽标键 + R，然后键入“winver”，选择“确定”。 更新到“设置”菜单中的[最新 Windows 版本](ms-settings:windowsupdate)。

 备注

如果运行的是 Windows 10 版本1903 或 1909，请在 Windows 菜单中打开“设置”，导航到“更新和安全性”，然后选择“检查更新”。 内部版本号必须是 18362.1049+ 或 18363.1049+，次要内部版本号需要高于 .1049。 阅读详细信息：[WSL 2 即将支持 Windows 10 版本 1903 和 1909](https://devblogs.microsoft.com/commandline/wsl-2-support-is-coming-to-windows-10-versions-1903-and-1909/)。

#### 步骤 3 - 启用虚拟机功能

安装 WSL 2 之前，必须启用“虚拟机平台”可选功能。 计算机需要[虚拟化功能](https://learn.microsoft.com/zh-cn/windows/wsl/troubleshooting#error-0x80370102-the-virtual-machine-could-not-be-started-because-a-required-feature-is-not-installed)才能使用此功能。

以管理员身份打开 PowerShell 并运行：

PowerShell复制

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

**重新启动**计算机，以完成 WSL 安装并更新到 WSL 2。

#### 步骤 4 - 下载 Linux 内核更新包

Linux 内核更新包会安装最新版本的 [WSL 2 Linux 内核](https://github.com/microsoft/WSL2-Linux-Kernel)，以便在 Windows 操作系统映像中运行 WSL。 （若要运行 [Microsoft Store 中的 WSL](https://learn.microsoft.com/zh-cn/windows/wsl/compare-versions#wsl-in-the-microsoft-store) 并更频繁地推送更新，请使用 `wsl.exe --install` 或 `wsl.exe --update`。）

1. 下载最新包：

   - [适用于 x64 计算机的 WSL2 Linux 内核更新包](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

    备注

   如果使用的是 ARM64 计算机，请下载 [ARM64 包](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_arm64.msi)。 如果不确定自己计算机的类型，请打开命令提示符或 PowerShell，并输入：`systeminfo | find "System Type"`。 **Caveat：** 在非英文版 Windows 上，你可能必须修改搜索文本，对“System Type”字符串进行翻译。 你可能还需要对引号进行转义来用于 find 命令。 例如，在德语版中使用 `systeminfo | find '"Systemtyp"'`。

2. 运行上一步中下载的更新包。 （双击以运行 - 系统将提示你提供提升的权限，选择“是”以批准此安装。）

安装完成后，请继续执行下一步 - 在安装新的 Linux 分发时，将 WSL 2 设置为默认版本。 （如果希望将新的 Linux 安装设置为 WSL 1，请跳过此步骤。）

 备注

有关详细信息，请参阅 [Windows 命令行博客](https://aka.ms/cliblog)上的文章[对更新 WSL2 Linux 内核的更改](https://devblogs.microsoft.com/commandline/wsl2-will-be-generally-available-in-windows-10-version-2004)。



#### 步骤 5 - 将 WSL 2 设置为默认版本

打开 PowerShell，然后在安装新的 Linux 发行版时运行以下命令，将 WSL 2 设置为默认版本：

PowerShell复制

```powershell
wsl --set-default-version 2
```



步骤 6 - 安装所选的 Linux 分发

1. 打开 [Microsoft Store](https://aka.ms/wslstore)，并选择你偏好的 Linux 分发版。

   ![Microsoft Store 中的 Linux 分发版的视图](wsl%E9%85%8D%E7%BD%AE%E5%A4%A7%E5%85%A8.assets/store.png)

   单击以下链接会打开每个分发版的 Microsoft Store 页面：

   - [Ubuntu 18.04 LTS](https://www.microsoft.com/store/apps/9N9TNGVNDL3Q)
   - [Ubuntu 20.04 LTS](https://www.microsoft.com/store/apps/9n6svws3rx71)
   - [Ubuntu 22.04 LTS](https://www.microsoft.com/store/apps/9PN20MSR04DW)
   - [openSUSE Leap 15.1](https://www.microsoft.com/store/apps/9NJFZK00FGKV)
   - [SUSE Linux Enterprise Server 12 SP5](https://www.microsoft.com/store/apps/9MZ3D1TRP8T1)
   - [SUSE Linux Enterprise Server 15 SP1](https://www.microsoft.com/store/apps/9PN498VPMF3Z)
   - [Kali Linux](https://www.microsoft.com/store/apps/9PKR34TNCV07)
   - [Debian GNU/Linux](https://www.microsoft.com/store/apps/9MSVKQC78PK6)
   - [Fedora Remix for WSL](https://www.microsoft.com/store/apps/9n6gdm4k2hnc)
   - [Pengwin](https://www.microsoft.com/store/apps/9NV1GV1PXZ6P)
   - [Pengwin Enterprise](https://www.microsoft.com/store/apps/9N8LP0X93VCP)
   - [Alpine WSL](https://www.microsoft.com/store/apps/9p804crf0395)
   - [Raft（免费试用版）](https://www.microsoft.com/store/apps/9msmjqd017x7)
   - [Alma Linux](https://apps.microsoft.com/search?query=alma+linux)

2. 在分发版的页面中，选择“获取”。

   ![Microsoft Store 中的 Linux 分发版](wsl%E9%85%8D%E7%BD%AE%E5%A4%A7%E5%85%A8.assets/ubuntustore.png)

首次启动新安装的 Linux 分发版时，将打开一个控制台窗口，系统会要求你等待一分钟或两分钟，以便文件解压缩并存储到电脑上。 未来的所有启动时间应不到一秒。

然后，需要[为新的 Linux 分发版创建用户帐户和密码](https://learn.microsoft.com/zh-cn/windows/wsl/setup/environment#set-up-your-linux-username-and-password)。

![Windows 控制台中的 Ubuntu 解包](wsl%E9%85%8D%E7%BD%AE%E5%A4%A7%E5%85%A8.assets/ubuntuinstall.png)

**祝贺你！ 现已成功安装并设置了与 Windows 操作系统完全集成的 Linux 分发！**



#### 排查安装问题

如果在安装过程中遇到问题，请查看[疑难解答指南的安装部分](https://learn.microsoft.com/zh-cn/windows/wsl/troubleshooting#installation-issues)。



#### 下载发行版

在某些情况下，你可能无法（或不想）使用 Microsoft Store 安装 WSL Linux 发行版。 你可能正在运行不支持 Microsoft Store 的 Windows Server 或长期服务 (LTSC) 桌面操作系统 SKU，或者你的公司网络策略和/或管理员不允许在你的环境中使用 Microsoft Store。 在这些情况下，虽然 WSL 本身可用，但你可能需要直接下载 Linux 发行版。

如果 Microsoft Store 应用不可用，可使用以下链接来下载并手动安装 Linux 发行版：

- [Ubuntu](https://aka.ms/wslubuntu)
- [Ubuntu 24.04](https://wslstorestorage.blob.core.windows.net/wslblob/Ubuntu2404-240425.AppxBundle)
- [Ubuntu 22.04 LTS](https://aka.ms/wslubuntu2204)
- [Ubuntu 20.04](https://aka.ms/wslubuntu2004)
- [Ubuntu 20.04 ARM](https://aka.ms/wslubuntu2004arm)
- [Ubuntu 18.04](https://aka.ms/wsl-ubuntu-1804)
- [Ubuntu 18.04 ARM](https://aka.ms/wsl-ubuntu-1804-arm)
- [Ubuntu 16.04](https://aka.ms/wsl-ubuntu-1604)
- [Debian GNU/Linux](https://aka.ms/wsl-debian-gnulinux)
- [Kali Linux](https://aka.ms/wsl-kali-linux-new)
- [SUSE Linux Enterprise Server 12](https://aka.ms/wsl-sles-12)
- [SUSE Linux Enterprise Server 15 SP2](https://aka.ms/wsl-SUSELinuxEnterpriseServer15SP2)
- [SUSE Linux Enterprise Server 15 SP3](https://aka.ms/wsl-SUSELinuxEnterpriseServer15SP3)
- [openSUSE Tumbleweed](https://aka.ms/wsl-opensuse-tumbleweed)
- [openSUSE Leap 15.3](https://aka.ms/wsl-opensuseleap15-3)
- [openSUSE Leap 15.2](https://aka.ms/wsl-opensuseleap15-2)
- [Oracle Linux 8.5](https://aka.ms/wsl-oraclelinux-8-5)
- [Oracle Linux 7.9](https://aka.ms/wsl-oraclelinux-7-9)
- [Fedora Remix for WSL](https://github.com/WhitewaterFoundry/WSLFedoraRemix/releases/)

这将导致 `<distro>.appx` 包下载到你选择的文件夹。

如果愿意，你也可通过命令行下载首选的发行版，可将 PowerShell 与 [Invoke-WebRequest](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.utility/invoke-webrequest) cmdlet 一起使用。 例如，下载 Ubuntu 20.04：

PowerShell复制

```powershell
Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing
```

 提示

如果下载需要很长时间，请通过设置 `$ProgressPreference = 'SilentlyContinue'` 来关闭进度栏

你还可以选择使用 [curl 命令行实用程序](https://curl.se/)来下载。 使用 curl 下载 Ubuntu 20.04：

控制台复制

```console
curl.exe -L -o ubuntu-2004.appx https://aka.ms/wslubuntu2004
```

在本示例中，将执行 `curl.exe`（而不仅仅是 `curl`），以确保在 PowerShell 中调用真正的 curl 可执行文件，而不是调用 [Invoke WebRequest](https://learn.microsoft.com/zh-cn/powershell/module/microsoft.powershell.utility/invoke-webrequest) 的 PowerShell curl 别名。

下载了发行版后，导航到包含下载内容的文件夹，并在该目录中运行以下命令，其中 `app-name` 是 Linux 发行版 .appx 文件的名称。

Powershell复制

```Powershell
Add-AppxPackage .\app_name.appx
```

Appx 包下载完成后，可以通过双击 appx 文件开始运行新发行版。 （命令 `wsl -l` 不会在此步骤完成之前显示发行版已安装）。

如果你使用 Windows Server，或在运行上述命令时遇到问题，可在 [Windows Server](https://learn.microsoft.com/zh-cn/windows/wsl/install-on-server) 文档页上找到备用安装说明，以通过将 `.appx` 文件更改为 zip 文件来安装该文件。

安装了发行版后，请按照说明[为新的 Linux 发行版创建用户帐户和密码](https://learn.microsoft.com/zh-cn/windows/wsl/setup/environment#set-up-your-linux-username-and-password)。



#### 安装 Windows 终端（可选）

使用 Windows 终端可以打开多个选项卡或窗口窗格，以显示多个 Linux 发行版或其他命令行（PowerShell、命令提示符、Azure CLI 等）并在它们之间快速切换。 可使用独特的配色方案、字体样式、大小、背景图像和自定义键盘快捷键来完全自定义终端。 [了解详细信息。](https://learn.microsoft.com/zh-cn/windows/terminal)

[安装 Windows 终端](https://learn.microsoft.com/zh-cn/windows/terminal/get-started)。

![Windows 终端](wsl%E9%85%8D%E7%BD%AE%E5%A4%A7%E5%85%A8.assets/terminal.png)

## 2. ubuntu示例配置及问题

基本配置就是登录并设置用户名和密码, 我直接用的root.

### 网络模式更改:

wsl2是windows下的linux子系统，并且采用类似于虚拟机NAT的管理方式。一般情况下，外部网络很难直接访问到wsl上的服务，除非使用端口转发。而现在，微软更新了wsl 2.0.0，采用镜像网络配置，完美解决了所有网络上的问题

由于在编译他人代码时需要linux环境，我就放在了wsl下编译运行，然后在本地，我就尝试用`ifconfig`得到的虚拟机ip，成功连接上了wsl服务器。但是，当我试图用局域网下其他设备连接时，很显然，根本不可能连接上。**这是因为wsl2采用了类似于NAT的网络模式，windows作为宿主机，隔离了局域网下其他设备和wsl的连接。**为了外部访问wsl，我也试过一些方法。

#### 旧版本端口转发方案

在旧版本，常用的方法是端口转发，根据官方文档，在有管理员权限的powershell下，输入如下指令：

```
netsh interface portproxy add v4tov4 listenport=<yourPortToForward> listenaddress=0.0.0.0 connectport=<yourPortToConnectToInWSL> connectaddress=(wsl hostname -I)
```

> 在此示例中，需要更新 `<yourPortToForward>` 到端口号，例如 `listenport=4000`。 `listenaddress=0.0.0.0` 表示将接受来自任何 IP 地址的传入请求。 侦听地址指定要侦听的 IPv4 地址，可以更改为以下值：IP 地址、计算机 NetBIOS 名称或计算机 DNS 名称。 如果未指定地址，则默认值为本地计算机。 需要将 `<yourPortToConnectToInWSL>` 值更新为希望 WSL 连接的端口号，例如 `connectport=4000`。 最后，`connectaddress` 值必须是通过 WSL 2 安装的 Linux 分发版的 IP 地址（WSL 2 VM 地址），可通过输入命令：`wsl.exe hostname -I` 找到。
>
> ---官方文档

然后，我将wsl中的`8303`端口映射在了windows下的`8304`端口下，我看到，在wsl中，服务器照常运行。

```
netstat -ano | findstr 8304
```

也能看到8304端口正常监听。但是，在我访问wsl运行的游戏服务器~（游戏名：DDraceNetwork）~，客户端显示“udp疑似被拦截”。本来我认为这是端口转发失败了，但是我忽然注意到本地8304端口只有tcp。于是查询了有关资料，得到了`netsh`只支持tcp的结论。因此，netsh方案失败。

#### 旧版本桥接模式方案

后来，我希望用hyper-v创建一个虚拟交换机，相当于一个可通外网的虚拟网卡，并让wsl连接。结果，出现了许多问题。

- 当前版本下，wsl2已不支持更改连接方式为`bridge`桥接模式，从根本上杜绝了这一方法
- 当我创建了虚拟交换机后并将其接入网桥，他直接**把我Windows下的网络干废了**。
- ~~试图用Vmware创建交换机，结果根本找不到选项~~

最后，我发现了官网给出了新方案！

#### 新版本镜像网络模式方案

由于本人入坑wsl时间晚，在此之前，我对wsl1只是道听途说。据我了解，wsl1建立在兼容层上，与windows共存，因此wsl1的网络配置与windows一致，外部网络也可以很轻松地接入wsl。而wsl2则是基于hyper-v的虚拟机，采用的是新一套的NAT方案，较为独立。所以对于wsl2也要用和普通虚拟机一样的网络方案，如NAT转发和桥接。

而现在，在Windows`23H2`更新中，或是`22H2`中的insider，wsl2更新了镜像网络解决方案，这个方案将会解决几乎一切wsl上的网络问题。**而此方法，也将随着时间推移，成为wsl2的默认解决方案**。

在此贴出微软官方文档：

[使用 WSL 访问网络应用程序 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/wsl/networking)

#### wsl版本检测

要启用镜像网络模式，首先要保证你的windows系统是23H2以上，或是加入了windows体验计划。除此之外，由于版本更新已有一段时间，如果你不确定是否可以使用，可以在cmd输入`wsl --version`查看wsl版本是否是`2.0.0`以上。如果是，那就可以。

#### 配置wsl文件

在windows用户根目录下，新建个名为`.wslconfig`的文件，选择合适的编辑器打开它。

> 如果不知道自己的用户根目录，可以在cmd下输入`echo %USERPROFILE`，即可看到路径
>
> 经过实验，我甚至发现上面的命令只能在cmd命令提示符下执行，powershell还不行！！！

在文件中输入如下内容：

```
[experimental]
networkingMode=mirrored
dnsTunneling=true
firewall=true
autoProxy=true
```

然后，执行`wsl --shutdown`，等待大约8秒后重新启动wsl，即可成功改变网络策略。

你可以通过在wsl虚拟机内执行`ifconfig`，看到原本有的IP地址现在没了，即可证明mirrored模式启用成功。现在你可以用phpstudy等软件在windows下建立一个网站，然后用linux访问，会发现linux可以访问windows的服务。

比如说：我在windows下用80端口建立的网站，在linux下执行`curl localhost`，显示的是windows的网站。

再比如说：我在linux下用apache在81端口建立了个网站，在windows下用浏览器访问`http://localhost:81`，可以看到linux的网站。

那么，wsl的新版本网络配置也就成功了…………

…………

**吗？**

#### 解决遗留的坑

很遗憾地告诉大家，我上面给出的配置文件**少了一句话**，而这句话才是本文的重点。为什么会单独拿出来讲，这是因为我在20分钟查找资料的过程，**没有一篇文章**讲到这个。现在我们先来看看问题在哪里。

首先，我们要先知道windows的IP地址，不要求上百度看公网IP，只要一个局域网内的外部IP，也就是你电脑直连路由器分配给你的IP，假设是192.168.1.101，那么我现在在浏览器访问`http://192.168.1.101`，可以成功看到宿主机创建的网站。

现在在让我们访问`http://192.168.1.101:81`，也就是linux下的网站端口，结果发现，**无法访问！**

也就是说：

- localhost:81 可以！
- 192.168.1.101:81 不行！

那就奇了怪了，我也是成功在官网找到响应的配置选项，只要在最后加上那么一行：`hostAddressLoopback=true`就行了。

最后的配置文件：

```
[experimental]
networkingMode=mirrored
dnsTunneling=true
firewall=true
autoProxy=true
hostAddressLoopback=true
```

重启wsl，问题解决，~~我的游戏服务器也能进入了，只是服务器列表不显示[滑稽]~~

#### 尾声

我在这里贴出wsl2关于mirrored模式的一些其他配置选项，可以更好的帮助各位配置wsl。

| 设置名称                   | 值     | 默认值 | 说明                                                         |
| :------------------------- | :----- | :----- | :----------------------------------------------------------- |
| `useWindowsDnsCache`**     | bool   | false  | 仅当 `experimental.dnsTunneling` 设置为 true 时才适用。 如果此选项设置为 false，则从 Linux 隧道传输的 DNS 请求将绕过 Windows 中的缓存名称，以始终将请求放在网络上。 |
| `bestEffortDnsParsing`**   | bool   | false  | 仅当 `experimental.dnsTunneling` 设置为 true 时才适用。 如果设置为 true，Windows 将从 DNS 请求中提取问题并尝试解决该问题，从而忽略未知记录。 |
| `initialAutoProxyTimeout`* | string | 1000   | 仅当 `experimental.autoProxy` 设置为 true 时才适用。 配置启动 WSL 容器时，WSL 等待检索 HTTP 代理信息的时长（以毫秒为单位）。 如果代理设置在此时间之后解析，则必须重启 WSL 实例才能使用检索到的代理设置。 |
| `ignoredPorts`**           | string | Null   | 仅当 `experimental.networkingMode` 设置为 `mirrored` 时才适用。 指定 Linux 应用程序可以绑定到哪些端口（即使该端口已在 Windows 中使用）。 通过此设置，应用程序能够仅侦听 Linux 中的流量端口，因此即使该端口在 Windows 上用于其他用途，这些应用程序也不会被阻止。 例如，WSL 将允许绑定到 Linux for Docker Desktop 中的端口 53，因为它只侦听来自 Linux 容器中的请求。 应在逗号分隔列表中设置格式，例如：`3000,9000,9090` |
| `hostAddressLoopback`**    | bool   | false  | 仅当 `experimental.networkingMode` 设置为 `mirrored` 时才适用。 如果设置为 True，将会允许容器通过分配给主机的 IP 地址连接到主机，或允许主机通过此方式连接到容器。 请注意，始终可以使用 127.0.0.1 环回地址 - 此选项也允许使用所有额外分配的本地 IP 地址。 |

具有 `path` 值的条目必须是带有转义反斜杠的 Windows 路径，例如：`C:\\Temp\\myCustomKernel`

具有 `size` 值的条目后面必须跟上大小的单位，例如 `8GB` 或 `512MB`。

值类型后带有 * 的条目仅在 Windows 11 中可用。

值类型后显示 ** 的条目需要 [Windows 版本 22H2](https://blogs.windows.com/windows-insider/2023/09/14/releasing-windows-11-build-22621-2359-to-the-release-preview-channel/) 或更高版本。



### 更新源和包

输入以下命令查看Codename应该换哪个源

```sh
lsb_release -a
# 输出
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.1 LTS
Release:	22.04
Codename:	jammy
# 所有要换 jammy 的源
```

换源, ubuntu 系统通过将 /etc/apt/source.list 内容改为以下更改

```txt
deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
# deb http://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
```

其他源:

①. jammy

```sh
deb http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-updates main restricted universe multiverse
# deb http://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
# deb-src http://mirrors.aliyun.com/ubuntu/ jammy-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ jammy-backports main restricted universe multiverse
```

②. focal

```sh
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse focal
```

③.bionic

```sh
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
```

再输入命令更新源

```sh
apt update
```

卸载自带的ssh, 这个自带的好像有问题, 重新装一下

```sh
apt remove openssh-server
```

安装一些我需要的包, 根据自我需要去安装, build-essential 特别大(200M+), 因为我要写代码所以安装了, 不写代码的不用装.net-tools用于使用ifconfig命令, ipnetutils-ping 用与 ICMP 的ping 命令 nfs-kernel-server rpcbind 用于其他远程系统要挂载wsl2中的目录使用, traceroute 用于跟踪路由, 分析网络用, samba 也用于网络挂载文件 smbclient 用于本地测试samba,  openssh-server 用于远程ssh登录

```sh
apt install net-tools ipnetutils-ping build-essential nfs-kernel-server rpcbind traceroute samba smbclient openssh-server
```

然后就是一些这些包的配置:

### 远程SSH登录

编辑ssh的配置文件 /etc/ssh/sshd_config

```sh
vim /etc/ssh/sshd_config
```

搜索其中的文本, 将:

```txt
#Port 22
解除注释#, 然后改为你自己想用的端口, 避免和windows自用的ssh默认端口冲突
我改为:
Port 9901
```

```txt
添加一行, 使得可以用root进行远程登录
PermitRootLogin yes
```

最后重启 sshd 服务

```sh
service ssh --full-restart
```

新建宿主机防火墙关于SSH使用 9901 端口的规则

控制面板 ---> 防火墙 ---> 左侧高级设置 ---> 入站规则 ---> 右侧新建规则 ---> 打开了 新建入站规则向导窗口 ---> 规则类型(选择自定义, 下一页) ---> 程序(所有程序, 下一页) ---> 协议和端口(TCP, 特定本地端口 9901 , 远程选所有端口, 下一页) ---> 作用域(本地选任何, 远程选任何, 下一页) ---> 操作(允许连接, 下一页) ---> 配置文件(域, 专用, 公用全勾上, 下一页) ---> 写个自己记得住的名称,比如 [用户名]WSL的SSH, 完毕

在windows上或者其他远程系统上尝试使用 ssh 加刚才的端口 登录该WSL2, 应该无误.

```sh
ssh root@192.168.21.27 -p 9901
```

### NFS共享网络文件夹

通过包 nfs-kernel-server 在网络上共享 WSL2 内系统的目录, 其他系统可以通过 mount 进行挂载使用WSL2内的指定目录

### 使用 NFS 共享目录

1. **在 WSL 中安装 NFS 服务**：

   - 通过以下命令安装 NFS 服务：

     ```bash
     apt install nfs-kernel-server
     ```

2. **配置 NFS 共享**：

   - 编辑 

     ```bash
     /etc/exports
     ```

      文件，添加你要共享的文件夹和允许访问的客户端 IP 地址，例如：

     ```bash
     /shared 192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check) 
     # 或者局域网下所有ip
     /shared *(rw,sync,no_root_squash,no_subtree_check)
     ```

     /etc/exports 文件中可以设定的参数主要有以下这些：

     ```txt
     参数 说明
     (1) Ro 该主机对该共享目录有只读权限
     (2) Rw 该主机对该共享目录有读写权限
     (3) Root_squash 客户机用root用户访问该共享文件夹时，将root用户映射成匿名用户
     (4) No_root_squash 客户机用root访问该共享文件夹时，不映射root用户
     (5) All_squash 客户机上的任何用户访问该共享目录时都映射成匿名用户
     (6) Anonuid 将客户机上的用户映射成指定的本地用户ID的用户
     (7) Anongid 将客户机上的用户映射成属于指定的本地用户组ID
     (8) Sync 资料同步写入到内存与硬盘中
     (9) Async 资料会先暂存于内存中，而非直接写入硬盘
     (10) Insecure 允许从这台机器过来的非授权访问
     (11) subtree_check 如果共享/usr/bin之类的子目录时，强制NFS检查父目录的权限（默认）
     (12) no_subtree_check 和上面相对，不检查父目录权限
     (13) wdelay 如果多个用户要写入NFS目录，则归组写入（默认）
     (14 )no_wdelay 如果多个用户要写入NFS目录，则立即写入，当使用async时，无需此设置。
     (15) hide 在NFS共享目录中不共享其子目录
     (16) no_hide 共享NFS目录的子目录
     (17) secure NFS通过1024以下的安全TCP/IP端口发送
     (18) insecure NFS通过1024以上的端口发送
     ```

   - 然后启动 NFS 服务：

     ```bash
     exportfs -a
     systemctl restart nfs-kernel-server
     ```

   常用工具命令

   ```sh
   #显示已经mount到本机nfs目录的客户端机器。
   sudo showmount -e localhost
   #将配置文件中的目录全部重新export一次！无需重启服务。
   sudo exportfs -rv
   #查看NFS的运行状态
   sudo nfsstat
   #查看rpc执行信息，可以用于检测rpc运行情况
   sudo rpcinfo
   #查看网络端口，NFS默认是使用111端口。
   sudo netstat -tu -4
   ```

3. **新建宿主机关于WSL NFS使用的TCP端口的防火墙**

   控制面板 ---> 防火墙 ---> 左侧高级设置 ---> 入站规则 ---> 右侧新建规则 ---> 打开了 新建入站规则向导窗口 ---> 规则类型(选择端口, 下一页) ---> 协议和端口(TCP, 特定本地端口 111,2049 , 远程选所有端口, 下一页) ---> 操作(允许连接, 下一页) ---> 配置文件(域, 专用, 公用全勾上, 下一页) ---> 写个自己记得住的名称,比如 [用户名]WSL的NFS, 完毕

4. **在其他 Linux 系统中挂载 NFS 共享**：

   - 使用以下命令挂载：

     ```bash
     mount -t nfs <WSL IP地址>:/shared /mnt/shared
     #比如宿主机IP 192.168.21.27, 通过镜像网络模式使用WSL2的命令如下
     mount -t nfs 192.168.21.27:/shared/ /mnt/
     ```