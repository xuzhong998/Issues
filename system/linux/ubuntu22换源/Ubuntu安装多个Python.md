Ubuntu 20.04 LTS已经移除Python2，默认安装python3，但是很多时候还是会经常用到python2.7版本，这里首先单独安装python2.7，然后配置python2和python3，以达到手动切换系统默认python版本。

第一步：安装python2.7使用命令：

```sh
sudo apt install python2
```

第二步：配置系统默认python版本

(1)：显示python代替版本信息：sudo update-alternatives --list python，系统显示错误如下，表示当前系统中python代替版本尚未安装：

```txt
xuz@xuz-virtual-machine:/usr/local/python2/bin$ sudo update-alternatives --list python
update-alternatives: error: no alternatives for python
```

(2)：执行以下安装命令：

sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1

```txt
xuz@xuz-virtual-machine:/usr/local$ sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
update-alternatives: using /usr/bin/python2.7 to provide /usr/bin/python (python) in auto mode
```

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10 2

```txt
xuz@xuz-virtual-machine:/usr/local$ sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10 2
update-alternatives: using /usr/bin/python3.10 to provide /usr/bin/python (python) in auto mode
```

上述两条命令将/usr/bin/python2.7优先级设置为1，将/usr/bin/python3.10的优先级设置为2，所以执行update-alternatives命令后，python3.10被设置为系统默认版本。

(3)：查看当前默认版本：python --version

```txt
xuz@xuz-virtual-machine:~/Projcet/yocto/build$ python --version
Python 3.10.6
```

(4)：再次显示python代替版本信息：sudo update-alternatives --list python，执行后显示如下：

```txt
xuz@xuz-virtual-machine:/usr/local$ sudo update-alternatives --list python
/usr/bin/python2.7
/usr/bin/python3.10
```

第三步：手动切换python默认版本：sudo update-alternatives --config python，其中输入1则将python2.7设置为默认版本，输入2则将python3.10设置为默认版本, 因为本机自带pip3, 所以需要切换到python2.7 安装pip2, 这样切换python的时候才会自动切换对应的pip.

```sh
sudo update-alternatives --config python 1
```

第四步：安装pip

(1)：安装python3-pip，直接输入命令：sudo apt install python3-pip

(2)：安装python-pip，直接使用命令：sudo apt install python-pip显示如下，系统已经无法找到安装包地址：

```txt
E: Package 'python-pip' has no installation candidate
```

因此需要通过以下方法来手动下载安装python-pip，执行以下命令：

```sh
sudo apt-get install curl  #安装curl下载工具
sudo curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o get-pip.py  #下载安装脚本
sudo python get-pip.py  #运行安装脚本
```

第五步：经过以上配置，python2.7和python3.10及对应版本pip已全部安装好，当手动切换python版本后，对应的pip默认版本也会改变：
