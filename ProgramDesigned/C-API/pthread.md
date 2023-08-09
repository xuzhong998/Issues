创建线程: 成功返回0, 否则其他错误

```c
int pthread_create(pthread_t *thread,
                   const pthread_attr_t *attr,
                   void *(*start_routine) (void *),
                   void *arg);
```

thread ---> 线程ID, 用于线程操作时作为参数

attr      ---> 线程的调用策略、线程所能使用的栈内存的大小等, 一般为NULL, 不需要手动改

start_routine ---> 函数指针, 用于线程创建后运行的函数, 如果有返回值, 可在pthread_join第二个参数中得到返回值.

arg --- > 函数参数, 用于给start_routine的参数



销毁线程: 

