# 正则表达式使用

## 匹配非该正则表达式的内容

```regular
^((?!你的正则表达式).)*$
```

```explain
^: 表示字符串开始
$: 表示字符串结束
(): 表示中间的表达式是一个捕获组
?!: 表示负向先行断言, 不匹配之后的表达式(你的正则表达式)
.: 表示除了换行符的单个字符
)*: 表示前面的捕获组可以匹配0次或多次
```
