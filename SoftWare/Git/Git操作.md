# Git 操作

## Git Tag 操作

### 作用

1. 用于标记项目节点, 方便, 不需要在git 节点的commit 信息内编写这些记录信息.
2. 不需要修改代码
3. 标记较于节点更易于管理, 增删改查方便.

### 具体场景 和使用方法

比如张三和李四和王五共同维护一个项目代码, 同时项目软件版本发布由张三管理. 

**事发前:**

通常在项目发版前, 张三在修改完最后的代码后, 在微信群内通知李四和王五要发版本了, 赶紧推送代码. 然后张三在李四和王五推送完代码后, 将他们的代码pull下来并修复冲突, 最后将自己的代码commit并将版本信息录入commit message中, 将该次代码节点视为一次版本定版. (为了将代码节点前的代码都更新, 需要等待其他人先推送, 然后同步到本地, 可能会解决冲突, 然后再推送定版)

某次张三推送代码后忘了将版本信息录入commit message, 李四和王五在查看git log时也找不到版本节点了, 并且他们在发版后的一段时间又陆陆续续推送了很多节点, 这时候他们也不知道上次发的版本中哪些问题自己修改了, 测试爆出的问题跟之前的版本有没有关系.不过方法总比问题多, 张三通过在查看程序邮件时间并和git log 中代码节点时间对比后模糊给出了一个节点, 认为该节点是发布节点. 实际上该节点前后有多个同一时间段的代码节点, 这些节点中可能修改了部分问题. (各成员回溯版本困难,只有张三稍微清楚版本节点)

**使用TAG后:**

后来张三了解到git tag功能, 于是: 在定版的时候, 他通知大家推送代码, 并且将自己改的代码立即推送上去, 也不在commit message中录入版本信息了, 其他人陆陆续续推送完代码后, 到了定版时间, 张三pull 了最新的代码, 并且通过 git tag -a V01.0002 -m "V01.0002版本, 修改了之前测试的BUG" 将tag记录在最新的本地节点, 并且在节点 tag 信息中添加了版本信息和版本修改内容. 然后通过 git push origin --tags 将 tag 推送到远端. (不用等待其他人的代码,只用在定版时将 tag 记录在最新的节点上)

某次李四遇到了一个测试的问题, 他发现这个问题在当前版本V01.0003中好像修改过了,于是git pull 先同步远端最新代码, 然后通过 git tag --list 查看有哪些版本, 发现有 V01.0002 ,V01.0003, 2个版本, 然后通过 git log V01.0003 查看版本代码节点信息, 自己修改的节点没有在 V01.0003之前 , 再通过 git log 查看所有日志发现了V01.0003之后自己修改问题的代码节点 ,噢原来是自己没有在发版前将代码推送上去, 那就在 V01.0004版本给测试吧, 遂把测试问题解决版本更新为V01.0004.

后来张三也通过 git tag -a V01.0001 -m "V01.0001版本, 修改了之前测试的BUG" ac2eb41246c8370320449d7b5752d386fa775b80 将之前的节点的tag 补上了. 其中 ac2eb41246c8370320449d7b5752d386fa775b80 是 git log 中节点的 commit id ,标志每个节点的ID. git pull 后发现李四误传了一个 节点 7de1ccf0bdc61cda11458d651df30eb8141c9d5c 的 tag TestTag , 遂将李四骂一顿后通过 git push origin --delete TestTag 先将远端的tag删掉, 然后用 git tag -d TestTag 再将本地的 tag 删掉后就清理掉了这个脏tag.

后续版本管理方便且再没出错.万事大吉.

## Git 多密钥

Z: 如果我的git密钥对不在默认路径下, 那我在git操作比如git pull之前或之时应该如何设置

AI: 我来介绍几种处理非默认路径下的 SSH 密钥的方法：

### 临时指定 SSH 密钥:

```bash
GIT_SSH_COMMAND='ssh -i /path/to/your/private_key' git pull
```

### 永久配置方法,编辑或创建 `~/.ssh/config` 文件:

```
CopyHost github.com
    HostName github.com
    User git
    IdentityFile /path/to/your/private_key
```

如果使用了多个密钥,可以在 config 中配置多个 Host:

```txt
CopyHost github-work
    HostName github.com
    User git
    IdentityFile /path/to/work_key

Host github-personal
    HostName github.com
    User git
    IdentityFile /path/to/personal_key
```

然后在使用时,相应修改仓库的远程地址:

```bash
git remote set-url origin git@github-work:username/repo.git
```

## 查看STASH中某个文件的更改

git diff [某stash~] [某stash] -- [file path]

```sh
git diff stash@{0}~ stash@{0} -- run/media/mmcblk0p7/oscillograph/webServer/static/js/manifest.2ae2e69a05c33dfc65f8.js.map
```

让我解释一下这个命令的每个部分：

```sh
git diff stash@{0}~ stash@{0} -- run/media/mmcblk0p7/oscillograph/webServer/static/js/manifest.2ae2e69a05c33dfc65f8.js.map
```

1.  git diff` - 用于比较两个版本之间的差异

2.  stash@{0}~

   - 表示 stash@{0} 的父提交（前一个版本）

   - `~` 符号表示"父提交"
   - 所以 `stash@{0}~` 就是存储前的状态

3.  stash@{0}` - 表示最新的 stash 存储

4.  --

   - 用于分隔版本参数和文件路径参数

   - 这个符号告诉 Git 后面的参数是文件路径
   - 防止文件路径被误解释为版本参数

5. 最后是完整的文件路径

所以整个命令的意思是： 显示这个文件在存入 stash 前后的具体改动差异。相当于比较了"存入 stash 前的状态"和"存入 stash 时的状态"之间的差异。