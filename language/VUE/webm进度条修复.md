# webm录制进度条不能拖动修复步骤

## 原因

webm视频默认信息缺少关键帧的位置cues和seekHead等信息.



## 方案

使用 npm i fix-webm-metainfo 安装

然后按照以下路径修改对应文件的对应部分 

![fixAttention](webm进度条修复.assets/fixAttention.png)

将上述ebml库内文件该处修改重新编译即可



## 其余可添加信息

![image-20240626163836241](webm进度条修复.assets/image-20240626163836241.png)

WebM（基于 Matroska 格式）支持多种标签（tags）。虽然没有严格的限制，但有一些常用和推荐的标签。以下是一个相对全面的标签列表：

1. 基本信息：
   - TITLE: 标题
   - SUBTITLE: 副标题
   - ARTIST: 艺术家/创作者
   - DIRECTOR: 导演
   - ALBUM: 专辑名
   - GENRE: 流派/类型
   - DATE_RELEASED: 发布日期
   - DESCRIPTION: 描述
2. 技术信息：
   - DURATION: 时长
   - WIDTH: 宽度
   - HEIGHT: 高度
   - FRAMERATE: 帧率
   - ENCODER: 编码器
   - CODEC: 编解码器
   - BITRATE: 比特率
3. 版权和法律信息：
   - COPYRIGHT: 版权信息
   - LICENSE: 许可证
   - LEGAL: 法律声明
4. 创作信息：
   - PRODUCER: 制作人
   - COMPOSER: 作曲家
   - WRITER: 编剧
   - ACTOR: 演员
   - CINEMATOGRAPHER: 摄影师
5. 分类和组织：
   - KEYWORDS: 关键词
   - CATEGORY: 类别
   - RATING: 评级
   - COMMENT: 评论
6. 技术元数据：
   - LANGUAGE: 语言
   - AUDIO_CODEC: 音频编解码器
   - VIDEO_CODEC: 视频编解码器
   - AUDIO_SAMPLERATE: 音频采样率
   - AUDIO_CHANNELS: 音频通道数
7. 文件信息：
   - FILE_SIZE: 文件大小
   - ORIGINAL_FILENAME: 原始文件名
   - SOURCE: 来源
8. 其他：
   - CREATION_TIME: 创建时间
   - MODIFICATION_TIME: 修改时间
   - PLAYLIST: 播放列表
   - SEASON: 季（适用于电视剧）
   - EPISODE: 集（适用于电视剧）
9. 自定义标签：
   - 您可以创建任何自定义标签，如 CUSTOM_TAG_NAME

使用这些标签时，需要注意：

1. 大小写敏感性：标签名通常是大写的，但某些系统可能不区分大小写。
2. 值格式：某些标签（如 DURATION）可能需要特定格式的值。
3. 兼容性：不是所有播放器或文件管理器都能识别所有标签。
4. 重复标签：某些标签（如 ACTOR）可以多次使用。
5. 嵌套标签：Matroska 允许标签嵌套，但并非所有工具都支持复杂的嵌套结构

### 添加方式

修改ts-ebml代码进行添加, 在makeMetadataSeekable中添加.