# Java 答疑：JDK 11（Java 11）之后没有 JRE 目录，环境用户变量配置的解决方法

------

# 前言

我们之前的 JDK 1.8 版本乃至以下版本压缩包下载解压后直接运行会生成 JDK、JRE 两个目录文件，但从 Java 11 之后，只有 JDK 目录文件生成，没有单独的 JRE 目录文件，这时有需要的同学就可以通过命令行的方式手动生成 JRE。

![在这里插入图片描述](https://img-blog.csdnimg.cn/1ea787d6e8a14854a33cf07969830743.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA55m96bm_56ys5LiA5biF,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center=700x)

------

# 一、JDK 11（Java 11）之后 JRE 说明

**在 JDK 11（Java 11）之后 JRE 是集成在 JDK 之中的，无需我们额外进行环境变量配置，仅需配置 JDK 的 JAVA_HOME 与 Path 变量即可**。

- JAVA_HOME 变量指向 JDK 根目录，即 bin 目录上一级。
- PATH 变量指向 JDK 的 bin 目录。

如果切实需要 JRE 的同学或者是了解如何生成 JRE 目录的同学可以参考本文内容。

# 二、选择自己需要的 JDK 版本

[Java Archive | Oracle](https://www.oracle.com/java/technologies/downloads/archive/)

# 三、对下载的 JDK 进行解压

解压 jdk-13_windows-x64_bin，生成 JDK 目录，这是可以看到没有生成 JRE 目录，具体如下图所示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190920192004345.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA55m96bm_56ys5LiA5biF,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

# 四、执行 Dos 命令生成 JRE

打开命令窗口，管理员权限运行，切换到 JDK 安装目录，执行如下命令：

```powershell
bin\jlink.exe --module-path jmods --add-modules java.desktop --output jre
1
```

具体如下图所示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190920192441314.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA55m96bm_56ys5LiA5biF,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)
这时我们可以看到，生成了 JRE 文档目录，具体如下图所示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190920192614865.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA55m96bm_56ys5LiA5biF,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)
**说明**：其他配置与之前版本相同。查看本地安装的 Java 版本如下图所示：

![在这里插入图片描述](https://img-blog.csdnimg.cn/20190920193625941.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBA55m96bm_56ys5LiA5biF,size_20,color_FFFFFF,t_70,g_se,x_16#pic_center)

