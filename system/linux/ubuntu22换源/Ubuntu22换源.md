ubuntu更换国内源的方法。

1. 打开终端。

2. 输入以下命令备份原来的源。

```sh
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

3. 输入以下命令查看Codename应该换哪个源

```sh
sudo lsb_release -a
```

// 输出

```sh
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 22.04.1 LTS
Release:	22.04
Codename:	jammy
```

4. .再输入以下命令打开 sources.list 配置文件更换 jammy 源。

```sh
sudo vim /etc/apt/sources.list
```

#配置内容如下

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



4.再输入命令更新源。

```sh
sudo apt-get update
```

5.最后输入命令更新一下软件即可。

```sh
sudo apt-get upgrade
```

6.若使用过程中报错

```sh
Err:1 http://mirrors.aliyun.com/ubuntu jammy-security/universe amd64 libpython2.7-minimal amd64 2.7.18-13ubuntu1.1
  Temporary failure resolving 'mirrors.aliyun.com'
Ign:4 http://mirrors.aliyun.com/ubuntu jammy-security/universe amd64 python2.7 amd64 2.7.18-13ubuntu1.1
Err:2 http://mirrors.aliyun.com/ubuntu jammy-security/universe amd64 python2.7-minimal amd64 2.7.18-13ubuntu1.1
  Temporary failure resolving 'mirrors.aliyun.com'
Err:3 http://mirrors.aliyun.com/ubuntu jammy-security/universe amd64 libpython2.7-stdlib amd64 2.7.18-13ubuntu1.1
  Temporary failure resolving 'mirrors.aliyun.com'
Err:4 http://mirrors.aliyun.com/ubuntu jammy-security/universe amd64 python2.7 amd64 2.7.18-13ubuntu1.1
  Temporary failure resolving 'mirrors.aliyun.com'
E: Failed to fetch http://mirrors.aliyun.com/ubuntu/pool/universe/p/python2.7/libpython2.7-minimal_2.7.18-13ubuntu1.1_amd64.deb  Temporary failure resolving 'mirrors.aliyun.com'
E: Failed to fetch http://mirrors.aliyun.com/ubuntu/pool/universe/p/python2.7/python2.7-minimal_2.7.18-13ubuntu1.1_amd64.deb  Temporary failure resolving 'mirrors.aliyun.com'
E: Failed to fetch http://mirrors.aliyun.com/ubuntu/pool/universe/p/python2.7/libpython2.7-stdlib_2.7.18-13ubuntu1.1_amd64.deb  Temporary failure resolving 'mirrors.aliyun.com'
E: Failed to fetch http://mirrors.aliyun.com/ubuntu/pool/universe/p/python2.7/python2.7_2.7.18-13ubuntu1.1_amd64.deb  Temporary failure resolving 'mirrors.aliyun.com'
E: Unable to fetch some archives, maybe run apt-get update or try with --fix-missing?
```

确保源无误的情况下, 则需要修改DNS解析, 执行以下内容:

```sh
sudo vim /etc/resolv.conf
```

将 DNS 名称服务器地址修改

```sh
nameserver 127.0.0.53 ---> nameserver 8.8.4.4
```

然后重启网络服务

```sh
sudo systemctl restart NetworkManager
```

然后更新源

```sh
sudo apt-get upgrade
```

再去使用.