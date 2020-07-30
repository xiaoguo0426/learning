

Nginx连接fastcgi的方式有2种:
- unix domain socket
- TCP

Unix domain socket 或者 IPC socket是一种终端，可以使同一台操作系统上的两个或多个进程进行数据通信。

与管道相比，Unix domain sockets 既可以使用字节流和数据队列，而管道通信则只能通过字节流。

Unix domain sockets的接口和Internet socket很像，但它不使用网络底层协议来通信。Unix domain socket 的功能是POSIX操作系统里的一种组件。

TCP和unix domain socket方式对比

TCP是使用TCP端口连接127.0.0.1:9000

Socket是使用unix domain socket连接套接字/dev/shm/php-cgi.sock（很多教程使用路径/tmp，而路径/dev/shm是个tmpfs，速度比磁盘快得多）

```code
fastcgi_pass  unix:/tmp/php-cgi.sock
fastcgi_pass  127.0.0.1:9000
```

理论上，unix socket 不走网络，效率高一些，但稳定性不是很理想

https://blog.csdn.net/liv2005/article/details/7741732

https://www.cnxct.com/default-configuration-and-performance-of-nginx-phpfpm-and-tcp-socket-or-unix-domain-socket/
