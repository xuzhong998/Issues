# 为什么Switch语句内部不能定义变量?（有解决方案）

1.问题了解

2.问题解答

3.总结

## 1.问题了解

我相信很多小伙伴们和我一样在使用switch case语句中遇到过这种问题，定义了一个变量，之后编译就报错，之后也很迷惑不解，这次我们就来认识并解决这个问题。

下面是我写的一段代码switch case：



```C++
int main() {
	bool b;
	switch(b)
	{
		case true:
			std::string file_name;
			int ival = 0;
			int jval;
			break;
		case false:
			jval = 5;
			break;
	}
}
```


报错信息为：

```sh
 Cannot jump from switch statement to this case label
 jump bypasses variable initialization 
 jump bypasses variable initialization
```


由报错信息得知：不能跳转到某一个特定的case，且出现了两句 略过两个变量的初始化。
接下来我们来分析一下这个问题：



## 2.问题解答

我们假设该代码合法，即一旦控制流直接跳转到false分支，也就同时略过了变量file_name和ival的初始化过程，此时这两个变量位于作用域之内，跟在false之后的代码试图在尚未初始化的情况下使用它们，这显然是行不通的。

代码描述：




```c++
int main() {
	bool b;
	switch(b)
	{
		case true:
			//因为程序的执行流程可能绕开下面的初始化语句，所以该switch语句不合法。
			string file_name;     //错误，控制流绕过一个隐式初始化的变量
			int ival = 0;         //错误：控制流绕过一个显示初始化的变量
			int jval;             //正确：因为jval没有初始化
			break;
		case false:
			//正确，kval虽然在作用域内，但是它没有被初始化。
			jval = 5;             //正确：给jval赋一个值
			break;
	}
}
```


**因此答案是**：如果在某处一个带有初始值的变量（可以显式初始化，可以隐式初始化）位于作用域之外，在另一处该变量位于作用域之内，则从前一处跳转到后一处的行为是非法行为。

C++语言规定：不允许跨过变量的初始化语句直接跳转到该变量作用域的另一个位置。



**解决方案**
如果需要为某个case分支定义并初始化一个变量，我们应该把变量定义在块内，从而确保后面的所有case标签都在变量的作用域之外。


			
```c++
int main() {
	bool b;
	switch(b)
	{
		case true:
		{
			//正确：声明定义语句均在语句块内部
			string file_name("sss");
			int ival = 0;
			int jval;
		}
		    break;
		case false:
		{
		}
	    break;
	}
}
```




## **3.总结**

C++语言规定：不允许跨过变量的初始化语句直接跳转到该变量作用域的另一个位置， 如果需要为某个case分支定义并初始化一个变量，我们应该把变量定义在块内，从而确保后面的所有case标签都在变量的作用域之外，这样就不会报错了。