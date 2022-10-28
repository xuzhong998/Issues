snprintf执行流程



snprintf(dstPtr, size, format, srcPtr);



作用: 把srcPtr按照format格式化输出成字符串后, 复制size个字节到dstPtr内



流程: 先清空dstPtr-> srcPtr格式化fomat为字符串 -> 从输出后的字符串内截取size个字节到dstPtr内, 从dstPtr首地址开始.