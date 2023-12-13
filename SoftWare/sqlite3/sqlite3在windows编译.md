## 在windows编译sqlite3



windows编译步骤:
./configure
make

在windows上编译会报错:libtool: warning: libobj name 'sqlite3.Tpo -c -o sqlite3.lo sqlite3.lo' may not contain shell special characters.

主要是unix和windows转义字符问题导致命令执行失败.

这时候执行:
make -n> cmds.sh&& sh cmds.sh
即可