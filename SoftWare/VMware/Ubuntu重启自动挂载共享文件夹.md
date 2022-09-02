# Ubuntu虚拟机开机自动挂载共享文件夹

Ubuntu下虚拟机设置好共享文件夹后， 下次再启动会发现共享文件夹无法访问了。
解决方法：

```sh
# 编辑开机自动启动的脚本
sudo vim /etc/rc.local
```

增加命令

```sh
vmhgfs-fuse -o allow_other .host:/ /mnt/hgfs
exit 0
```

增加脚本可执行权限并设置每次开机启动时自动执行

```sh
sudo chmod +x /etc/rc.local
systemctl start rc.local.service
```