# I2C协议

 原创

[mb60ffdbe016b5d](https://blog.51cto.com/u_15315240)2021-07-29 17:36:29©著作权

***文章标签\*[经验分享](https://blog.51cto.com/topic/jingyanfenxiang.html)*****文章分类\*[其它](https://blog.51cto.com/nav/other1)[其它](https://blog.51cto.com/nav/other)*****阅读数\**\*841\****

I2C通信协议

![I2C协议_经验分享](https://s2.51cto.com/images/blog/202107/27/ed65ce4f4a91bd2e0a71283846dcf84d.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

I2C通信协议的基础 简介

I2C「Inter-integrated Circuit」总线支持设备之间的短距离通信，用于处理器和一些外围设备之间的接口，它只需要两根信号线来完成信息交换。I2C最早是飞利浦在1982年开发设计。

![I2C协议_经验分享_02](https://s2.51cto.com/images/blog/202107/27/396b43816663bed269cf2eeb5c415a06.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

I2C是同步传输信号，关于同步和异步这个经常在面试的时候会考到，同步和异步的核心的，我把消息发出去，我要关心你有没有收到，你收到了之后，我才会发下一条消息。异步就是，我发消息给你，我不管你收到消息没有，我都直接发下一条消息。所以SPI和I2C是同步通讯，UART是异步通讯。

## I2C

I2C最少只需要两根线，和异步串口类似，**但是，I2C可以支持多个slave设备。**和SPI不同的是，I2C可以支持mul-master系统，允许有多个master并且每个master都可以与所有的slaves通信「**master之间不可通过I2C通信，并且每个master只能轮流使用I2C总线」**。master是指启动数据传输的设备并在总线上生成时钟信号以驱动该传输，而被寻址的设备都作为slaves。

![I2C协议_经验分享_03](https://s2.51cto.com/images/blog/202107/27/587796f38e455e0704c5f1e6a1f19b29.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

I2C的数据传输速率位于串口和SPI之间，大部分I2C设备支持100KHz和400KHz模式。使用I2C传输数据会有一些额外消耗，每发送8bits数据，就需要额外1bit的元数据「**ACK或NACK」，这个也是I2C通讯的核心，应答信号**。I2C支持双向数据交换，由于仅有一根数据线，故通信是半双工的。

硬件复杂度也位于串口和SPI之间，而软件实现可以相当简单。

I2C协议

I2C协议把传输的消息分为两种类型的帧：一个**地址帧** 「用于master指明消息发往哪个slave」 一个或多个**数据帧** 「 在SDA线上传输的数据帧，每一帧是8-bit的数据」。

![I2C协议_经验分享_04](https://s2.51cto.com/images/blog/202107/27/00835e392c1f8126991d58957a2b5934.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

I2C时序，帧和位

数据在SCL处于低电平时放到SDA上，在SCL变为高电平后进行采样，也就是说在时钟上升沿的时候，数据是有效的。

I2C数据传输的时序图如下：![I2C协议_经验分享_05](https://s2.51cto.com/images/blog/202107/27/0385b05e17a2414d710d1ec8c98f3e3c.jpeg?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

**启动信号-Start
**为了标识传输正式启动，master设备会将SCL置为高电平「当总线空闲时，SDA和SCL都处于高电平状态」，然后将SDA拉低，这样，所有slave设备就会知道传输即将开始。如果两个master设备在同一时刻都希望获得总线的所有权，**那么谁先将SDA拉低，谁就赢得了总线的控制权**。在整个通信期间，可以存在多个start来开启每一次新的通信序列「communication sequence」，而无需先放弃总线的控制权。

![I2C协议_经验分享_06](https://s2.51cto.com/images/blog/202107/27/20a4eb35838a968069a7669f97943902.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)起始信号

**地址帧-address frame
**I2C不像SPI有一个片选线，所以就需要指定I2C的地址，而且地址有7+1 形式，也有 9+1的形式，7+1指的是7位地址加一个读写位位标志bit。9+1 指的是9位地址加一个读写位标志bit。读写bit写1表示读操作，写0表示写操作。

**应答信号-ACK
**当主设备发送完地址帧之后，会放弃SDA总线控制权，让从设备获得SDA控制权，此时从设备应该在第9个时钟脉冲之前回复一个ACK「将SDA拉低」以表示接收正常，如果接收设备没有将SDA拉低，则说明接收设备可能没有收到数据「如寻址的设备不存在或设备忙」或无法解析收到的消息，如果是这样，则由master来决定如何处理「stop或repeated start condition」。

![I2C协议_经验分享_07](https://s2.51cto.com/images/blog/202107/27/46057f04e394724a172eb8cba6aceb98.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)应答信号

**数据帧-data frames
**在地址帧发送之后，就可以开始传输数据了。主设备负责产生时钟，并且在时钟上升沿之前准备好数据。每个数据帧8bits，数据帧的数量可以是任意的，直到产生停止条件。每一帧数据传输「8-bit」之后，接收方就需要回复一个ACK或NACK。

**停止信号-Stop
**当所有数据都发送完成时，主设备需要产生一个停止信号，告诉从设备自己已经操作完成。停止停止信号在SDA置于低电平时，将SCL拉高并保持高电平，然后将SDA拉高。PS：在正常传输数据过程中，当SCL处于高电平时，SDA上的值不应该变化，防止意外产生一个停止信号。

![I2C协议_经验分享_08](https://s2.51cto.com/images/blog/202107/27/17829495db71a202440ced1f20e7e7de.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)停止信号

**重复开始信号-repeated start condition
**主设备可以发起多个开始信号来完成数据的传输，只要不发停止信号，总线上的其他主设备就不能占据这条总线，有时候发送完一组数据后，希望重新发数据，所以就有了重复开始信号。重复的开始信号为，**SDA在SCL低电平时拉高，然后SCL拉高**。

重复开始条件的传输时序如下图所示：![I2C协议_经验分享_09](https://s2.51cto.com/images/blog/202107/27/d91fe02b5cccfaa737f5735449e84195.jpeg?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

**时钟拉伸-clock stretching
**如果主设备发送的速度比从设备接收的速度快，因为是同步传输，可能就会出现问题，这时候，从设备可以通过控制时钟线，要求主设备线暂停传输，这就叫时钟拉伸。

通常时钟都是由master提供的，slave只是在SDA上放数据或读数据。而时钟拉伸则是slave在master释放SCL后，将SCL主动拉低并保持，此时要求master停止在SCL上产生脉冲以及在SDA上发送数据，直到slave释放SCL，让SCL变成高电平。之后，master便可以继续正常的数据传输了。可见时钟拉伸实际上是利用了时钟同步的机制，只是时钟由slave产生。

如果系统中存在这种低速slave并且slave实现了clock stretching，则master必须实现为能够处理这种情况，**实际上大部分slave设备中不包含SCL驱动器的，因此无法拉伸时钟。**

包含时钟拉伸的I2C数据传输时序图为：![I2C协议_经验分享_10](https://s2.51cto.com/images/blog/202107/27/eac6d9cc2e0a80aa9ed27d081f19eab3.jpeg?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

**10-bit地址空间：
**上面讲到I2C支持10-bit的设备地址，此时的时序如下图所示：![I2C协议_经验分享_11](https://s2.51cto.com/images/blog/202107/27/e991c55a34c6506921f61186d4ee8d4f.jpeg?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

在10-bit地址的I2C系统中，需要两帧来传输slave的地址。第一个帧的前**5个bit固定为b11110**，后接slave地址的高2位，第8位仍然是R/W位，接着是一个ACK位，然后再发送另外8bit的地址，发送完后从设备会给出应答。

![I2C协议_经验分享_12](https://s2.51cto.com/images/blog/202107/27/fbfdf899b2a4ad850fe3e1bf56346d93.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)

I2C的上拉电阻

I2C总线要求总线不工作的时候保持在高电平状态，所以I2C总线默认需要上拉电阻，而且上拉电阻的大小也会直接影响时序，一般是1.5K，2.2K，和4.7K。我工作到现在目前用的最多的电阻就是4.7K的。

**上拉分为内部上拉和外部上来，如果CPU有内部上拉了，就没有必要使用外部上拉了。**

既然I2C就是通过高低电平来识别的，为什么还需要上拉电阻呢？直接搞一个VCC接上去不是更好吗？欢迎评论回答。

与串行端口、SPI对比

## 串行端口

串行端口是**异步的**「不传输时钟相关数据」，两个设备在使用串口通信时，必须先约定一个数据传输速率，并且这两个设备各自的时钟频率必须与这个速率保持相近，某一方的时钟频率相差很大都会导致数据传输混乱。

异步串行端口在每个数据帧中都要插入至少一个起始位和一个终止位，意味着每传输8bits的数据实际要花费10bits的传输时间，从而降低了数据传输速率。

另一个问题是异步串行端口的设计就是针对两个设备之间通信的，那么如果有多个设备连接到一个串口上，就必须解决信号碰撞的问题(bus contention)，通常要通过额外硬件来完成。

最后就是数据传输速率，异步串行通信并没有一个理论上的速率限制，大部分UART设备只支持一些特定的波特率，**最高通常在230400bps左右**。

## SPI

SPI最明显的缺点就是引脚数量，使用SPI总线相连的一个master和一个slave需要四根线（MISO/MOSI/SCK/CS），**每增加一个slave，就需要在master上增加一个CS引脚**。当一个master接多个slaves的时候，疯狂增长的引脚连接是难以忍受的，并且对紧凑的PCB layout是一个挑战。

SPI总线上只允许有一个master，但可以有任意多个slaves（只受限于总线上设备的驱动程序的能力，以及设备上最多能有多少个CS引脚）。

**SPI可以很好的用于高速率全双工的连接「这个是SPI的优点」**，对一些设备可支持高达10MHz（10Mbps）的传输速率，因此SPI吞吐量大得多。SPI两端的设备通常是一个简单的移位寄存器，让软件的实现很简单。

SPI的具体文章可以查看下面链接
SPI协议详解

时钟同步和仲裁

如果两个master都想在同一条空闲总线上传输，此时必须能够使用某种机制来选择将总线控制权交给哪个master，这是通过时钟同步和仲裁来完成的，而被迫让出控制权的master则需要等待总线空闲后再继续传输。在单一master的系统上无需实现时钟同步和仲裁。

## 时钟同步

时钟同步是通过I2C接口和SCL之间的线“**与**”（wired-AND）来完成的，如果有多个master同时产生时钟，**那么只有所有master都发送高电平时，SCL上才表现为高电平，否则SCL都表现为低电平**。

## 总线仲裁

总线仲裁和时钟同步类似，当所有master在SDA上都写1时，SDA的数据才是1，只要有一个master写0，那此时SDA上的数据就是0。一个master每发送一个bit数据，在SCL处于高电平时，就检查看SDA的电平是否和发送的数据一致，如果不一致，这个master便知道自己输掉仲裁，然后停止向SDA写数据。



也就是说，如果master一直检查到总线上数据和自己发送的数据一致，则继续传输，这样在仲裁过程中就保证了赢得仲裁的master不会丢失数据。输掉仲裁的master在检测到自己输了之后也不再产生时钟脉冲，并且要在总线空闲时才能重新传输。仲裁的过程可能要经过多个bit的发送和检查。

所以，会存在一个情况，如果两个master如果发送的时序和数据完全一样，则两个master都能正常完成整个的数据传输。

## I2C波形

设定I2C读的地址：0110 1101(0x6d) 1000 1000(0x88)，注意观察第9个时钟为低电平，表示从设备应答

Slave Read Address：0x6d，ID register value：0x88, **读取0110110 设备的 1000 1000 内部寄存器地址数据**

![I2C协议_经验分享_13](https://s2.51cto.com/images/blog/202107/27/60717f9af9523625b9132f7c14014c60.jpeg?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=/format,webp/resize,m_fixed,w_1184)img

## I2C源码

收集了两个I2C源码，一个是GPIO口模拟I2C，一个是androitd i2c tools