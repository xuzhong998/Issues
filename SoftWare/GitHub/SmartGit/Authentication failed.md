###原文 https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/###
问题描述
从 2021 年 8 月 13 日开始，在 GitHub.com 上对 Git 操作进行身份验证时，将不再接受帐户密码。
受影响的工作流程
命令行 Git 访问
使用 Git 的桌面应用程序（GitHub Desktop 不受影响）
直接使用您的密码访问 GitHub.com 上的 Git 存储库的任何应用程序/服务
以下客户不受此更改的影响：

如果您为您的帐户启用了双重身份验证，则您已经需要使用基于令牌或 SSH 的身份验证。
如果您使用 GitHub Enterprise Server，我们尚未宣布对我们的本地产品进行任何更改。
如果您维护一个GitHub 应用程序，则 GitHub 应用程序不支持密码验证。

解决方法

使用受影响的工作流程之外的方法：
SSH替代HTTPS
使用OAuth token 认证 替代 密码认证（目前我使用的）， SmartGit ->Edit->Preferences->User Interface->Hosting Providers->N
name: github.com	
Generate API Token->copy token from web
Token: xxx...
enable  Use OAuth token ....... (below token enter line)
使用GitHub enterprise 实例