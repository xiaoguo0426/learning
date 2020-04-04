### laradock

```
$ docker-compose up -d nginx mysql php-fpm redis workspace beanstalkd

$ docker-compose up -d nginx mysql redis workspace

$ docker-compose restart nginx //重启nginx容器
$ docker-compose stop nginx  //停止nginx容器
$ docker-compose build workspace //构建workspace容器

//workspace

$ docker-compose exec --user=laradock workspace bash //进入workspace

npm run dev:s  //运行node app
修改workspace ports
ports:

    - "8081:8081"


composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

//nginx

$ docker-compose exec nginx bash
```

##### .env

```
APP_CODE_PATH_HOST=/home/xiaoguo/workplace/

CHANGE_SOURCE=true

WORKSPACE_INSTALL_SWOOLE=true

PHP_FPM_INSTALL_XDEBUG=true

PHP_FPM_INSTALL_RDKAFKA=true

DB_HOST=mysql
REDIS_HOST=redis
QUEUE_HOST=beanstalkd

```

#### 端口被占用
```
sudo netstat -anp | grep 443

sudo kill -9 xxxx

```

#### hosts修改
```
sudo vim /etc/hosts

sudo /etc/init.d/networking restart

```

#### Ubuntu
```
1. Ctrl + h    列出文件夹内所有隐藏的文件，文件夹

2. 启动系统资源监控【菜单栏左上角】

    sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor

    sudo apt-get install indicator-sysmonitor

    indicator-sysmonitor &

```

#### MySQL

```

1.my.cnf

		[mysqld]
		default_authentication_plugin=mysql_native_password

2.restart mysql service

		ALTER USER root@'%' IDENTIFIED WITH mysql_native_password BY 'root';

```

#### 其他

```
1. 终端可视化查看docker容器--lazydocker

2. portainer可视化容器管理后台

    localhost:9010
    admin 123123123

    //nginx.conf
    proxy_pass http://portainer:9000;// just for laradock

3. sentry  事件日志记录和汇集的平台

    http://localhost:9000

    740644717@qq.com
    123123123


    $ docker-compose run --rm web createuser //创建用户



4. access.log 日志分析

    https://www.goaccess.cc/

    goaccess app_access.log -a -o ~/workplace/logs/report.html --real-time-html  --time-format '%H:%M:%S' --date-format '%d/%b/%Y' --log-format='COMMON'

```

#### PHPStrom快捷键

```
//Ubuntu 配置
点击方法跳转 后 返回 原来的位置

Settings->Keymap 搜索 “Navigate”

把“Back”的配置删除，重新配置称“Ctrl+Alt+向左箭头”
把“Forward”的配置删除，重新配置称“Ctrl+Alt+向右箭头”

```
