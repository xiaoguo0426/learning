### laradock

```
$ docker-compose up -d nginx workspace mysql redis php-fpm beanstalkd

$ docker-compose up -d nginx mysql redis workspace

$ docker-compose restart nginx //重启nginx容器
$ docker-compose stop nginx  //停止nginx容器
$ docker-compose build workspace //构建workspace容器

//workspace

$ docker-compose build --no-cache workspace

$ docker-compose exec --user=laradock workspace bash //进入workspace

npm run dev:s  //运行node app

# 安装imap扩展
sudo apt install php-imap
sudo phpenmod imap

#安装node
修改workspace的Dockerfile node的url
https://gitee.com/mirrors/nvm/raw/v0.38.0/install.sh

#php默认版本
# rm -rf /etc/alternatives/php
# ln -s /usr/bin/php7.4 /etc/alternatives/php

修改workspace ports
ports:

    - "8081:8081"

//安装pip
apt-get install python3-pip

sudo apt-get install cmake

×××××××××××××××××××××××××××××××××
//阿里源
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
//腾讯源
composer config -g repos.packagist composer https://mirrors.tencent.com/composer/
//中国源
composer config -g repo.packagist composer https://packagist.phpcomposer.com

composer install --no-dev   
×××××××××××××××××××××××××××××××××

//nginx
$ docker-compose exec nginx bash

配置多个应用间相互调用
docker-compose.yml
nginx

networks:
        frontend:
            aliases:
              - www.chemex.test
        backend:
            aliases:
              - www.chemex.test

修改后需要执行docker-compose down 重新up一个新的容器即可

*********************************
安装Redis遇到的问题
checking for libzstd files in default path... not found
configure: error: Please reinstall the libzstd distribution
ERROR: `/tmp/pear/temp/redis/configure --with-php-config=/usr/bin/php-config --enable-redis-igbinary=no --enable-redis-lzf=n --enable-redis-zstd=n' failed

$ sudo apt update && sudo apt install libzstd-dev


pecl install -o -f redis
pecl install igbinary    # 安装序列器扩展

*********************************

```

##### .env

```
APP_CODE_PATH_HOST=/home/xiaoguo/workplace/

CHANGE_SOURCE=true

WORKSPACE_INSTALL_SWOOLE=true

PHP_FPM_INSTALL_XDEBUG=true

PHP_FPM_INSTALL_RDKAFKA=true

WORKSPACE_INSTALL_PYTHON3=true

DB_HOST=mysql
REDIS_HOST=redis
QUEUE_HOST=beanstalkd


https://juejin.cn/post/6844903569972264974

```

#### 端口被占用
```
sudo netstat -anp | grep 443

sudo kill -9 xxxx

```


#### Ubuntu
```
1. Ctrl + h    列出文件夹内所有隐藏的文件，文件夹

2. 启动系统资源监控【菜单栏左上角】

    sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor

    sudo apt-get install indicator-sysmonitor

    indicator-sysmonitor &


3. 命令行翻墙

    proxychains
    https://portal.shadowsocks.nz/knowledgebase/160/
    https://www.jianshu.com/p/3f392367b41f


    小木马邮件复制
    export HTTP_PROXY=http://127.0.0.1:58591; export HTTPS_PROXY=http://127.0.0.1:58591; export ALL_PROXY=socks5://127.0.0.1:51837

4. CPU高性能
    https://blog.csdn.net/li528405176/article/details/82823922?utm_medium=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.edu_weight&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-BlogCommendFromMachineLearnPai2-1.edu_weight

5. github clone很慢

    1. 用 git 内置代理，直接走系统中运行的代理工具中转，比如，你的 SS 本地端口是 1080（一般port均为1080），那么可以如下方式走代理：

    git config --global http.proxy socks5://127.0.0.1:1080      //1080可能要修改下
    git config --global https.proxy socks5://127.0.0.1:1080     //1080可能要修改下
    2.git clone特别慢是因为github.global.ssl.fastly.net域名被限制了。
    只要找到这个域名对应的ip地址，然后在hosts文件中加上ip–>域名的映射，刷新DNS缓存便可。



    在hosts文件后面加上两行：

    151.101.72.249 http://global-ssl.fastly.Net
    192.30.253.112 http://github.com
    好了，再试试clone，看看效果吧

    https://blog.csdn.net/qq_35992422/article/details/106946775


    2. 关于gits打开很慢

      http://ping.chinaz.com/gist.github.com  查找对应的IP，修改本机hosts

      https://www.zhihu.com/question/21343711


6. docker 安装问题
    docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock


    sudo groupadd docker
    sudo gpasswd -a $USER docker
    newgrp docker
    docker ps


7. hosts修改

    sudo vim /etc/hosts

    sudo /etc/init.d/networking restart


8. 连不上局域网问题

   arp -a  //查看ip被占用情况
   ![](assets/markdown-img-paste-20210825185242551.png)

   确认了192.168.1.250被docker0占用了

   /etc/docker/daemon.json 修改bip 192.168.200.1/24,重启 systemctl restart docker


9.
sudo systemctl daemon-reload
sudo systemctl restart docker
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
    admin 123123123123

    //nginx.conf
    proxy_pass http://portainer:9000;// just for laradock

3. sentry  事件日志记录和汇集的平台

    http://localhost:9000

    740644717@qq.com
    123123123


    $ docker-compose run --rm web createuser //创建用户

    //https://docs.sentry.io/server/cli/   sentry常用命令

    $ docker-compose run web command sub-command

4. access.log 日志分析

    https://www.goaccess.cc/

    goaccess app_access.log -a -o ~/workplace/logs/report.html --real-time-html  --time-format '%H:%M:%S' --date-format '%d/%b/%Y' --log-format='COMMON'

5. status-code=409 kind=snap-change-conflict

这个问题通常是由于系统上已安装了相同名称的 snap 软件包，导致新安装的软件包无法同名共存而产生的冲突。解决方法如下：

列出所有已安装的 snap 软件包：
$ snap list
确定产生冲突的软件包名称，执行卸载命令：
$ sudo snap remove <软件包名称>
重新安装软件包：
$ sudo snap install <软件包名称>
如果问题仍然存在，可能是因为 snapd 服务未能正确运行。可以尝试重启服务或重新安装 snapd 软件包：

$ sudo systemctl restart snapd.service
$ sudo apt-get install --reinstall snapd

6. Ubuntu必备软件

    PHPStrom，
    postman，
    gitkraken,
    atom,
    sublime text3,
    vmwawre,
    chromuin,
    oh my zsh,
    VLC媒体播放器,
    docker,
    sougou_pinyin,
    mysql worksbench,
    Insomnia,
    teamviewer,
    wps,
    unity tweak tool, //主题
    folder-color //文件夹颜色
    wonderwall //背景图
    trimage //图片压缩
    jpegoptim//图片压缩


```

#### PHPStrom快捷键

```
//Ubuntu 配置
点击方法跳转 后 返回 原来的位置

Settings->Keymap 搜索 “Navigate”

把“Back”的配置删除，重新配置称“Ctrl+Alt+向左箭头”
把“Forward”的配置删除，重新配置称“Ctrl+Alt+向右箭头”

```
//命令行启动
nohup sh /home/xiaoguo/phpstrom/bin/phpstorm.sh >/dev/null >/dev/null 2>&1 &

https://blog.csdn.net/envon123/article/details/82144401

https://www.jetbrains.com/phpstorm/download/other.html

#### 一些有趣的东西

```bash

cat redis.conf | grep -v "#" | grep -v "^$" > test.conf
//去掉redis.conf文件中的注释和空行并输出到test.conf中
```




PHP性能监控之tideways
https://note.youdao.com/ynoteshare1/index.html?id=c2537c596b9f8595969c161469513a3f&type=note#/


************************************************************

kafkamanager

docker run -d -eZK_HOSTS=172.20.0.8 -eKAFKA_MANAGER_AUTH_ENABLED=false kafkamanager/kafka-manager




docker run -d --name kafkadocker_zookeeper_1  dockerkafka/zookeeper

docker run -d --name kafkadocker_kafka_1 --link laradock_zookeeper dockerkafka/kafka

docker run -it --rm --link laradock_zookeeper --link kafkadocker_kafka_1:kafka -p 9000:9000 -e ZK_HOSTS=172.20.0.8:2181 kafkamanager/kafka-manager



*****************************************************************
iptables -L -n --line-number

iptables -L


iptables -D INPUT 1


service iptables save


service iptables restart



******************************************************************

删除所有不使用的镜像
> docker image prune --force --all

删除所有停止的容器
> docker container prune -f

删除所有不适用的挂载
> docker volume prune

停止、删除所有的docker容器和镜像
> docker ps -aq

停止所有的容器
> docker stop $(docker ps -aq)

删除所有的容器
> docker rm $(docker ps -aq)

删除所有的镜像
> docker rmi $(docker images -q)


*****************************************************************

> sudo apt-get update
sudo apt-get install jpegoptim
sudo apt-get install optipng

> jpegoptim *.jpg    //jpg无损压缩
find . -name '*.jpg' | xargs jpegoptim --strip-all    //递归执行jpg无损压缩
find -type f -name "*.jpg" -exec jpegoptim --strip-all {} \;  //另一种递归执行jpg无损压缩

> sudo optipng *.png      //无损压缩png
find -type f -name "*.png" -exec optipng {} \;  //递归执行无损压缩png



**********************************
搜狗输入法崩溃后重启：

打开终端，输入以下命令以停止搜狗输入法服务：
> sudo killall fcitx

输入以下命令启动搜狗输入法服务：
> fcitx &

现在您已经重启了输入法服务，可以重新使用搜狗输入法了。

**********************************
查看保存的Wi-Fi连接密码

sudo grep -r 'psk=' /etc/NetworkManager/system-connections/

**********************************
