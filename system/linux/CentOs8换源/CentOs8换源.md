# [🎋CentOS 8 更换yum国内源](https://www.cnblogs.com/Julien1021/p/16255403.html)

centos7和centos8的版本不同，个人在实践当中发现centos7更换yum源的配置方法在centos8当中并不适用，以下为个人实现centos8配置国内yum源过程：

操作的主要思路为：

- 在不删除源文件的基础上，将源文件备份
- 下载最新centos8国内的yum源文件
- 更换地址

主要实现的代码如下：

- -   进入root，切换至yum.repos.d目录
  - `cd /etc/yum.repos.d/`
  -   创建新文件夹并将源文件备份为repo.bak
  - `mkdir backup && mv *repo backup/`
  -   下载国内yum源文件
  - `curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo`
  -   更新下载yum源地址
  - `sed -i -e"s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-*`
  - `sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-*`
  -   生成缓存
  - `yum clean all && yum makecache`