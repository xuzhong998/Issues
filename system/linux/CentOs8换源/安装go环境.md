# 安装Go环境

------

> Golang官网下载地址：https://golang.org/dl/

1. 打开官网下载地址选择对应的系统版本, 复制下载链接
    这里我选择的是
    `go1.11.5.linux-amd64.tar.gz`：https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz

![img](https:////upload-images.jianshu.io/upload_images/1277729-7d5e14c2c8c994bf.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

1. `cd`进入你用来存放安装包的目录，我习惯在`~`下面创建个`go`文件夹。



```shell
# 在 ~ 下创建 go 文件夹，并进入 go 文件夹
mkdir ~/go && cd ~/go
下载的 go 压缩包
wget https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz
```

1. 下载完成

![img](https:////upload-images.jianshu.io/upload_images/1277729-60625ab3615c752e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1128/format/webp)

1. 执行`tar`解压到`/usr/loacl`目录下（官方推荐），得到`go`文件夹等



```shell
tar -C /usr/local -zxvf  go1.11.5.linux-amd64.tar.gz
```

1. 添加`/usr/loacl/go/bin`目录到PATH变量中。添加到`/etc/profile` 或`$HOME/.profile`都可以



```shell
# 习惯用vim，没有的话可以用命令`sudo apt-get install vim`安装一个
vim /etc/profile
# 在最后一行添加
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
# 保存退出后source一下（vim 的使用方法可以自己搜索一下）
source /etc/profile
```

1. 执行`go version`，查看版本号