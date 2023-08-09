# ** X-UI****功能介绍**

sprov编写的这套面板程序，很方便，能可视化的搭建SS、V2ray、Xray、Trojan等热门的协议，并且实时监测 VPS 的性能状态以及管理流量的使用情况。

**See below**

- **系统状态监控**
- **支持多用户多协议，网页可视化操作**
- **支持的协议：vmess、vless、trojan、shadowsocks、dokodemo-door、socks、http**
- **支持配置更多传输配置**
- **流量统计，限制流量，限制到期时间**
- **可自定义 xray 配置模板**
- **支持 https 访问面板（自备域名 + ssl 证书）**
- **更多高级配置项，详见面板**



## **准备工作**

### **VPS 一台，重置好主流的操作系统 CentOs 8** 

> 例如我使用的TX轻量级服务器

[![img](https://blogger.googleusercontent.com/img/a/AVvXsEgRi0RbwYOW6dgXzsc58ANDoxNQL_LMEaVGM8aCSOS73rRRZROFJLtc6uN9xXphT8ZW73t5rDjx62YdsYoHUGbLJn1guc8n5lzB3QYYdlmPYxy7Upm7we1yaqMR5FbG_481ia4r4_b2QR3HHhzyLwu5tvoUQ1Ag_nbyJTSCBL8_OnKkp6wJoabk7-hI4g=w740-h503)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)

域名一个，托管到 Cloudflare

托管域名需要先注册一个域名(nameSilo, Goddy, porkbun等等),然后将原域名的名称服务器改为Cloudflare提供的再解析DNS.[![img](https://blogger.googleusercontent.com/img/a/AVvXsEgWkPBFGWef0V-sduwE8-ftGVHb6evVLjmg8EWacUozSPh0snCQAJxwAhuuTGUEsLdTDzHCrvkPKuoFGlwatU-FOg34AYvx4KNGouvzCwk7DIP-caKej_tBKfNQYIH4yYrIOJA_x6v7YqKKkFfZPkfG-aX54NeWNVm1W1DHtmwqqEIjxfr5yuyEdq1RFQ=w733-h355)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)

步骤流程密钥对生成和绑定安装好系统镜像后, 为了登录安全和谨防忘掉密码,最好绑定密钥对, TK可以帮助生成密钥对, 生成后自动下载一个私钥, 请保护好自己的私钥(重要)

[![img](VPS-V2RAY.assets/AVvXsEgU5dhkUJj5yDgdZ267H__KpXjhrzHj6A3ZAcaaQdSgsJf4iv_uVfZzFCTjmAuwmemJ-iKuGkkYJ1Xv8oAIyG8oldLG9oPD1BdykaYvKHyJmfN9jeE20oDC18L-Q4rkPSjv3pzqeFM4W6WQgLf92OSOwg5ibOk15ADKoEVNKxVpgh4O2jTHbQJuYaR6Tg=w752-h503.png)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#) [![img](https://blogger.googleusercontent.com/img/a/AVvXsEjgU_6TByE-5CLMlqRWfYUMU2pcPrMMI9XqLdZ3a6uwnmz05Owmhha2vOcGgkajLd4w5nI8BWX0MQ3LMvFVafYxA0xvYLWvJfmg6x1TNvLppfqWM-djZgBtUcysLB1XyyNeBfbwX8MowxGUns-azIIhp2qZDQFJXSlkwqtHLPI92rOxlh6UnLGgJ6kW8g=w619-h472)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)

然后在服务器绑定公钥(需要强制关机)

[![img](https://blogger.googleusercontent.com/img/a/AVvXsEhhDBPJU6GivhIiROUy14b1wueIid0pRv2Yecru4uF41cMmwXng0vij5R2ktg4OjGnKyA6XEcGExfEF61C2-NmKsjWgBTBMG2K55UItSqm67CL-w3gP17Sfp4oCea8879lQOensaFAX_3d_1JlWVXK1W8yl2JNF-0bvOHdH-SMxgUsuocHiGVjMRy1o0w=w448-h401)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)

 [![img](VPS-V2RAY.assets/AVvXsEgwFGQNmBFmmxnNAUfM6SBFOjPixQZyE-Sqsy2EwE8pNFjsZIYmkQQ-dMQjTSLLLh7lkSfgflg_UyA_6doWgbrnOGI41bHOTYj7ZfTWRymdshB-XbnNPbcC66rbYImR6fgr8XVHwG_uxT-PbaAHvh_evw1rePdaV2NP0pB22ESKHDION2bOir54dqHmjA=w630-h518.png)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)

电脑终端SSH登录服务器先打开服务器防火墙相关端口20-22, 80, 443, 54321以及ICMP的所有端口(PING 要用)
[![img](https://blogger.googleusercontent.com/img/a/AVvXsEghVe7Js_AOaftV2nIGUuwuX0n-0jM3BoyHBWzMffvLJz8-_u1A977H21ooDXee-UEEs9JvxiJFdsgp2Abh3C1qDSNENqD8TNWyQki6OmNpiEf3NmHIIt5aC1SsV1CSAmB73y3CUH7RJYlmaBm2yS_CAx9BdiXqdU7SvqBBbxYN_OS4JnL0yKym1UQ9fA=w878-h412)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)
下载一个终端工具(finalshell, xshell, SecurityCRT等等), 新建一个连接, 在主机填入服务器IP 然后使用刚才下载的私钥进行登录

 **[![img](https://blogger.googleusercontent.com/img/a/AVvXsEiKAVtTDM91v2GJGjCh0cYIQZM9wOlER2Ahx8LcKcKZnuqvJhVHBFABpzk5gAkToYCWLsGNKnGKuQAybXMHqBj2J1wBpyzuneCZxdNbLBp6oMwXt4MEaT1dBUFCSojTahifQFERja53qwxEgmoMyXhMjXpNwny1ouQ335LsoPJk0WKWF1vglv2yHV5BGg=w704-h524)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)[![img](https://blogger.googleusercontent.com/img/a/AVvXsEhx-iyPcwRo6a588NWQ5Ysk1Xnu-uXon45NJM0ZFY2EUhLVOveD2tSG75AaU7YmvhlBR1jSnfnYPrq-6TRLshQm_DTCWx2o4CCzRkhwrw4_FZPK-07-f-CH9b1CcHVczxb-3uqli76RyaSdQB8SiemfiynxHM6OO9p69IO5Gz4D60ea_X0WurL1ugvAfg=w700-h538)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**

接受并保存, 用户名root

[![img](VPS-V2RAY.assets/AVvXsEhrzHUkHe8YKYczGtjhXxa-WImYMlkLs8Eys_2zWeKDIR-rS7EY4pSADOtIFYXI4mO5TCQ71Guu_McnczJaeP9i_2fcuZm2_To4zf2bCUFKBRqtl0L8tcpxm9snaTz6Ioj6MBlINCA9O8YshrO5RSvu1czsga7FvZVPVHTf4PEkoKcQi-Ax07NnWOeDEw=w696-h402.png)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)
登录后花几分钟更新一下系统组件, 代码 

```sh
yum update -y
```



**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEjp1N7yvgOwKHE37dxn9TnjBS8fW1cFLOZMNHZvqdqfuy6iERxQwKxqr5JFWaoJVvXohPxE7aD1DFEfB6qkCBc0zepf-lUbAnhjpWseg52lkIlLhGRslZKFX74WU8bBQltUKwOEc4N4Q3yia2QkRuYGGYK8v8_EjSvamrkBz5CBTMfst6cCjjbuQ_1UmQ=w720-h473)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**

安装BBR加速CentOS 8 / Debian ≥ 9 开启自带 BBR 加速 ，复制以下代码全部粘贴执行

```sh
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p #(后续若xray状态意外停止运行时可以执行该命令)
```

查看bbr是否开启

```sh
lsmod | grep bbr
```



**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEipRL1VeftG7FuC-IyMHtVR6T-3w8vRLgCBaS88U_QmOp4UGSJ3LEP2dTBbdyV8KmFyPpHR2ksgYjZme8TWAo_Zv1BL3S-5Q92pBk3YUYdZNATBngcBkAXmU0j5cKh303l3pOcHyFkVusa00WAx1WxctrQwOB2IjavpaNByNpBj8mxJWfNrJUYnMVm9vA=w709-h700)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**

申请证书执行以下代码安装socat, acme

```是
yum install -y socat
curl https://get.acme.sh | sh
```



**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEgopMd7LP5ufjKB-3hHlzDxZKnTMc2vQRq0aPWG5OlDREQxamXMU4n3hV3FJW0Di3yTOevF1mAzbKfJrVLc-LrllMr3nqtD3cd5As5ddj6h6rl74qMV00jHBhxMj3cIecoaETuUxauV0S5LDMNmKThST1jGpLNK2dLAcbjYnUGt-DEcwSo2foY7k-hUcw=w990-h480)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**

注册邮箱和申请域名证书, 务必修改下面的域名为你自己的域名和邮箱

```sh
~/.acme.sh/acme.sh --register-account -m yourEmail@email.com

~/.acme.sh/acme.sh --issue -d www.yourDomain.xxx --standalone
```

#(如果提示80端口被nginx占用则需要暂时停止nginx(systemctl stop nginx), 如果提示超时看一下域名能否ping通, 能Ping后重新安装一下socat 和 acme,再执行注册和申请证书)成功后得到证书和公钥

**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEguVnKl9Xw38r8UEla143UP1P8poftEVs-fCmFO4pUmXCjB3facw-ZSnbYxNwqwV7sSWPnc-f34QIOqv38ZwGPRXhPY8QrGI9__jKvOUw4FikWG6-z60ree8bebukUnI4OiMLzjtZNQYfeCYtsxobFN7CV1Z7qVsCL7HgLvuuan0AfZSHQQL8L9xbicNg=w711-h276)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**

新建一个文件夹用来下载存放

```sh
mkdir /root/cert
~/.acme.sh/acme.sh --installcert -d www.yourDomain.xxx --key-file /root/cert/private.key --fullchain-file /root/cert/cert.crt
~/.acme.sh/acme.sh --upgrade --auto-upgrade
chmod -R 755 /root/cert
```



**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEgYBZRU3DpKjkV8nQ-e4aK_91vlTUnllYDsL4d5IAGyj-d5ynKiJEVTewc0kvowMQYReW5PpDdzp-208Ukg6ZEmI_O1hmqeb_TPxxZOWAFDhqFGR5lgcBDHW1KN-_0JlLb3ETMg35Su8q8Ke3zlgL2TqnGjtgAre1olY42xxdq03GMcP_Pcp6tNCE54Vw=w717-h294)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**

安装X-UI面板,以下链接为官方链接

```sh
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u root
```

默认端口54321,默认用户名密码都是admin,都可以登录修改,登录方式为 域名:54321

 **[![img](https://blogger.googleusercontent.com/img/a/AVvXsEiBS4dcGn-xRNjtQUKVD-pBgW8obfGiKq2Xb6hTsjGV05wE5jMcV3W_3vD2yGgMRMjBI5XHwK1SFaP5fa13_5g-P7gwvXOVdYUx3YmrK4tC_mHNmsgCsjGQvBCk5NEIYWXa9T_M2anRXVH5WQ5_brd_Aex65VI1ZYk6bBWantcVcAwx7YecrS1-RqDcrg=w711-h600)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)[![img](https://blogger.googleusercontent.com/img/a/AVvXsEgbWpLv8syuHXNVI4fL6EmcU9i3H3OZzhq8oyFVDe4i5CcI1PB6ktAzzb_m-0njfef_vFiY0TsS4LlfTUvtIn0DFAX0W76opos5amHTIT5TE8o_XGkD_esKElsODuN5W2O07Fb37Ydn9_HqIp6lsLz40JsKPgTX4rsv22Kv4stKRZAJjzDl8nK-SuDyrQ=w710-h355)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**


添加入站支持多协议多用户, 多用户不同端口需要在服务器控制台防火墙将对应端口规则添加.例如1: xray协议端口443的入站, 只用填入以下关键数据备注: CHINA-HK协议: vless,监听IP:一般不填,用来监听某IP入站流量端口: 433xtls使能flow为xtls-rprx-direct域名填写刚才申请证书的域名证书填写VPS上申请的证书路径或者内容

 **[![img](VPS-V2RAY.assets/AVvXsEi1oAqFLjk4KPdGEaLHA7lbbU23zUiL9GwsOrb_ZFG_AeI-sWKIj_djv9Jq6O1SlunpmoYcIo8gqx-M8E6siWvHTmmsvy35t_akMN9NlkywqvH6ldVTPWPP9z3Tnm35-BGiqBMoPoTAQaQuFHnbSL9GPn33xuebV4YDNg3542lB9n7VLwmwkAzHre0ebQ=w698-h530.png)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**


例如2:V2ray协议端口入站 ,注意端口没开的话要去控制台打开

**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEhgkqtQM97om3LimyasYN34-pl9Eajd5tt6od7wqkwHJ0rm2VKcDmrzH8K7mgIl5LMd0hucxCOvzV6ZGP0cpfTuQO_O7k7Ckz5QA0OwdJwmRbTnys1MA0NPSU6XosIHNaqM93pkjJYa6EFZUzgRPSQQKidpdon3ruB4mjmNuXgSmDyXK2lSTar5rtFIGw=w724-h543)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**


桌面V2rayN应用教程(官网)下载V2rayN本体: [https://github.com/2dust/v2rayN/releases/download/4.23/v2rayN.zip](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)下载V2rayN内核:[https://github.com/2dust/v2rayN/releases/download/4.23/v2rayN-Core.zip](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)解压内核, 在解压本体, 本体内容复制覆盖到内核根文件夹中即可.打开v2rayN.exe, 在入站列表中使用二维码添加节点[![img](VPS-V2RAY.assets/AVvXsEim4d05Lr0BkTAxhXTjjxB-moj0_9lhm0lIjN7BGlfLYN_kkDltXbsjN_8apvLAfnhaCTZ46GsJOe5HzBopUAUUTQvs3lA84hOxg-Y6ToklEGshi-Ta8hLl92rOkd4kWqpo6YyyXAvFvIweivAUIgEryxxV7VIQm5t-LQ7-OKJZpooLG79deIvbR-0uyQ=w731-h434.png)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**
**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEiuLqjVLcifgH8ilenNsUCeMSDyVaGwnvSlciNH-F65IV3QQP7X0oqmbOSA8UhxSn3CGaaWVVi0Gb2P7MRd9lR0qoPMWkdDdCSOWK22ulgpp4Ko7xgBpwuzZ3GT7zVoZYGbKge0BOh0v5sw1hE0KNce8Aa9k_-8xlN-XuVV9j3UQZsv-Dt07oPGlqLegg=w639-h565)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)[![img](VPS-V2RAY.assets/AVvXsEiUVmy6UbLE8MQvS_lRkyPy9zfJCT9a5NQn7jyJ75TUejmTTEdTz7k9qhgTHCnGSQMZPkDtu-Ki4W0gDk7IpuEp2GGbaLOe63vujqVhAe-SdvAwUuF7WepoEkzMvazbTWBYD4EeprYzf-S3Hlkk7S-KbGmVuzlo10l33nLvS3NPYnNct420yalUBVuyXw=w692-h417.png)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)测试youtube

**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEhbAR7FQ8AO-35uddfcSw998Rjo8pTcaBdcuiBP0Nj2zATHVP-uaC7xMddeQijrF3hyFjHnxB56IXlKJksGOr41gPA-opwI13IZe-1ve55gefitpaphKPFbGNmKJBro9dM4FvT5E3lOUV0KS_QrvtSX1k77TcSqJotYsqLFu_VZL78ewEpKXb0gZMsQQA=w741-h424)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**


小水管也能4K手机V2rayNG教程官网下载V2rayNG app[https://github.com/2dust/v2rayNG/releases/download/1.6.25/v2rayNG_1.6.25.apk](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)也是扫二维码添加节点[![img](VPS-V2RAY.assets/AVvXsEg_TKHtc8-_Rr_WPZ3jYmKrcmQlFcLCLbsxwtkg7rtpRIa4SNuh_tp3rPFVchdU3szEPD-McLvOO1TZTct5MD2q6FXGKNtXKL1PfScRqRcI8OYYycu5WG122ySTKlp1jc8TbWhZll4CYwMTy4lb1Jo77n92DuMgaUTHJ5dECiIALWr6vRrarNu-eLFCJg=w389-h849.png)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)

**
**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEgQzVdeUgfqok0Cncj9JLJv2ykBfKQCojCuDa4jvNIQodpw_wLYEBVc4ya1e-29F3Mgvj-C_4FJYd95RCiIlCQIt4vK9RDKutY20se6ArS3lJKaTOOEW_sycwFc9OHbodE5rCBcPZ3dfjoVtqjY164On9W2GTDseFxsO5nwSgs1w4-lu1Zua2dOvC_Yaw=w750-h347)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)

以上基本搞完了,补充：为了安全着想, 可以把SSH端口、X-UI端口改为其他端口（最好5001-65535范围内SSH端口修改: 比如我要改为19800端口

```sh
vi / etc/ssh/sshd_config
```

找到#Port 22改为Port 19800

**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEgq3nP1obmbuhFmMcl4ySVOTBWt81ccc_u78YBMg7bts8Wjk8_8Whxu6ikK6BHhNdwz5tTqrIqJ1SSDUNHHhM_RawaZh-AQpUZh1RzpF453pea6aeuiZxMnShWbac-asseEsG6atJhotmHWgPqYYIjf06AyG0YurX3tB5z-yO4jFkxn1N4jFsDce9wAtA=w645-h727)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**


重启服务执行service sshd restart防火墙放开19800

**[![img](https://blogger.googleusercontent.com/img/a/AVvXsEiU91aXZiaPigt05neidZrA248EL6_ec4PnA_E5QTYLCfeRwFTS_0CxvZAHbGHM_0nOFYkZoDvSY8s9AzBFcvJsd-1j5UJXG2VfjCpp8d_3qQthLxrO1yYcbtifnhU_wNKzJHHbIQgrNQdajX5MVzM_Me-NPyxY76ZLINnUMENYdllu2WY-cXsHhKgrbA=w867-h279)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)**


然后在电脑终端也改为19800端口[![img](https://blogger.googleusercontent.com/img/a/AVvXsEjmxoEE6J_ULvWfOFf8_5jUNfCGxNzgIKIx-R_XNcVF5vM-5sNpBVY78w7Mb8A59e4G8f-Fq61NXY02YjPwPnaY0nU6ccUDHPHWnu3Q-I41AAeVxv1SEz7Blf7sDprO62uS_QI_ksI781EjgLc-0haIUnlFkRjUoR8_LOZ3hEr72IgI9-RPy1sERUsuqQ=w723-h635)](https://www.blogger.com/blog/post/edit/5874031035108401574/5999792801018039165#)



##  