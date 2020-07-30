

#### 常见配置项

##### php-fpm进程分配

```code
pm = static | dynamic | ondemand
```
- pm = static 模式

  表示创建固定数量的php-fpm子进程，由pm.max_children参数控制

- pm = dynamic 模式
  表示启动进程是动态分配的，随着请求量动态变化的。它由pm.max_children,pm.start_servers,pm.min_spare_servers,pm.max_spare_servers这几个参数共同决定。

- pm = ondemand 模式

  进程在请求时按需创建，而不是动态的。可用于内存不足或内存过小的服务器

##### 进程池配置

- user = vagrant    

  拥有这个PHP-FPM进程池中子进程的系统用户。

- group = vagrant   

  拥有这个PHP-FPM进程池中子进程的系统用户组。

- listen = 127.0.0.1:9000

  PHP-FPM进程池监听的IP地址和端口号，让PHP-FPM只接受nginx从这里传入的请求。

- listen.allowed_clients = 127.0.0.1

  可以向这个PHP-FPM进程池发送请求的IP地址(一个或多个)。

- pm.max_children = 128

  这个设置设定任何时间点PHP-FPM进程池中最多能有多少个进程。需要测试PHP应用，确定每个PHP进程需要使用多少内存，再把这个设置设为设备可用内存能容纳的PHP进程总数。

- pm.start_servers = 3

  PHP-FPM 启动时PHP-FPM进程池中立即可用的进程数。

- pm.min_spare_servers = 2

  PHP应用空闲时PHP-FPM进程池可以存在的进程数量最小值。这个设置的值一般与pm.start_servers设置的值一样，用于确保新进入的HTTP请求无需等待PHP-FPM在进程池中重新初始化进程。

- pm.max_spare_servers = 4

  PHP应用空闲时PHP-FPM进程池中可以存在的进程数量最大值。这个设置的值一般比pm.start_servers设置的值大一点，用于确保新进入的HTTP请求无需等待PHP-FPM在进程池中重新初始化进程。

- pm.max_requests = 10000

  回收进程之前，PHP-FPM进程池中各个进程最多能处理的HTTP请求数量。这个设置有助于避免PHP扩展或库因编写拙劣而导致不断泄露内存。

- slowlog = /path/to/slowlog.log

  这个设置的值是一个日志文件在文件系统中的绝对路径。这个日志文件用于记录处理时间超过n秒的HTTP请求信息，以便找出PHP应用的瓶颈，进行调试。

- request_slowlog_timeout = 5s

  如果当前HTTP请求的处理时间超过指定的值，就把请求的回溯信息写入slowlog设置指定的日志文件。
