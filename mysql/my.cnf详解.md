
#### 查看my.cnf文件位置

```
 mysql --help | grep cnf

```
![](assets/markdown-img-paste-20220512114601726.png)


```

在Unix和类Unix系统上读取选项文件
文件名                    目的
/etc/my.cnf              全局选项    
/etc/mysql/my.cnf        全局选项    
SYSCONFDIR/my.cnf        全局选项    
$MYSQL-HOME/my.cnf       服务器特定选项（仅限服务器）    
defaults-extra-file      指定的文件 --defaults-extra-file（如果有的话）    
~/.my.cnf                用户特定的选项    
~/.mylogin.cnf           用户特定的登录路径选项（仅限客户端）    


```

```code
[client]
#客户端默认字符集编码
default-character-set = utf8mb4

[mysql]
#开启 tab 补全
#auto-rehash
default-character-set = utf8mb4

[mysqld]
port=3306
datadir=/var/lib/mysql  #数据存放路径
socket=/var/run/mysqld/mysqld.sock
symbolic-links=0 #建议禁用符号链接以防止各种安全风险
log-error=/var/log/mysql/error.log
pid-file=/var/run/mysqld/mysqld.pid

# 禁用主机名解析
skip-host-cache #禁用内部主机缓存以加快名称到 IP 的解析。禁用缓存后，每次客户端连接时，服务器都会执行 DNS 查找。
skip-name-resolve
# 默认的数据库引擎
default-storage-engine = InnoDB
innodb-file-per-table=1innodb-force-recovery = 1#一些坑
group-concat-max-len = 10240sql-mode=expire-logs-days = 7memlock

### 字符集配置
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4-unicode-ci
init-connect='SET NAMES utf8mb4'### GTID
server-id = 1# 为保证 GTID 复制的稳定, 行级日志
binlog-format = row
# 开启 gtid 功能
gtid-mode = on
# 保障 GTID 事务安全
# 当启用enforce-gtid-consistency功能的时候,
# MySQL只允许能够保障事务安全, 并且能够被日志记录的SQL语句被执行,
# 像create table ... select 和 create temporarytable语句, 
# 以及同时更新事务表和非事务表的SQL语句或事务都不允许执行
enforce-gtid-consistency = true# 以下两条配置为主从切换, 数据库高可用的必须配置
# 开启 binlog 日志功能
log-bin = mysql-bin 
# 开启从库更新 binlog 日志
log-slave-updates = on
#slave复制进程不随mysql启动而启动
skip-slave-start=1### 慢查询日志
# 打开慢查询日志功能
slow-query-log = 1# 超过2秒的查询记录下来
long-query-time = 2# 记录下没有使用索引的查询
log-queries-not-using-indexes = 0slow-query-log-file =/data/logs/mysql57/slow.log
#log=/data/logs/mysql57/all.log
### 自动修复
# 记录 relay.info 到数据表中
relay-log-info-repository = TABLE
# 记录 master.info 到数据表中 
master-info-repository = TABLE
# 启用 relaylog 的自动修复功能
relay-log-recovery = on
# 在 SQL 线程执行完一个 relaylog 后自动删除
relay-log-purge = 1### 数据安全性配置
# wei关闭 master 创建 function 的功能
log-bin-trust-function-creators = on
# 每执行一个事务都强制写入磁盘
sync-binlog = 1# timestamp 列如果没有显式定义为 not null, 则支持null属性
# 设置 timestamp 的列值为 null, 不会被设置为 current timestamp
explicit-defaults-for-timestamp=true### 优化配置
# 优化中文全文模糊索引
ft-min-word-len = 1# 默认库名表名保存为小写, 不区分大小写
lower-case-table-names = 1# 单条记录写入最大的大小限制
# 过小可能会导致写入(导入)数据失败
max-allowed-packet = 256M
# 半同步复制开启
#rpl-semi-sync-master-enabled = 1#rpl-semi-sync-slave-enabled = 1# 半同步复制超时时间设置
#rpl-semi-sync-master-timeout = 1000# 复制模式(保持系统默认)
#rpl-semi-sync-master-wait-point = AFTER-SYNC
# 后端只要有一台收到日志并写入 relaylog 就算成功
#rpl-semi-sync-master-wait-slave-count = 1# 多线程复制
# 基于组提交的并行复制方式
slave-parallel-type = logical-clock
#并行的SQL线程数量，此参数只有设置   1<N的情况下才会才起N个线程进行SQL重做。
#经过测试对比发现， 如果主库的连接线程为M， 只有M < N的情况下， 备库的延迟才可以完全避免。
slave-parallel-workers = 4### 连接数限制
max-connections = 1500# 验证密码超过20次拒绝连接
max-connect-errors = 200# back-log值指出在mysql暂时停止回答新请求之前的短时间内多少个请求可以被存在堆栈中
# 也就是说，如果MySql的连接数达到max-connections时，新来的请求将会被存在堆栈中
# 以等待某一连接释放资源，该堆栈的数量即back-log，如果等待连接的数量超过back-log
# 将不被授予连接资源
back-log = 500open-files-limit = 65535# 服务器关闭交互式连接前等待活动的秒数
interactive-timeout = 3600# 服务器关闭非交互连接之前等待活动的秒数
wait-timeout = 3600### 内存分配
# 指定表高速缓存的大小。每当MySQL访问一个表时，如果在表缓冲区中还有空间
# 该表就被打开并放入其中，这样可以更快地访问表内容
table-open-cache = 1024# 为每个session 分配的内存, 在事务过程中用来存储二进制日志的缓存
binlog-cache-size = 4M
# 在内存的临时表最大大小
tmp-table-size = 128M
# 创建内存表的最大大小(保持系统默认, 不允许创建过大的内存表)
# 如果有需求当做缓存来用, 可以适当调大此值
max-heap-table-size = 16M
# 顺序读, 读入缓冲区大小设置
# 全表扫描次数多的话, 可以调大此值
read-buffer-size = 1M
# 随机读, 读入缓冲区大小设置
read-rnd-buffer-size = 8M
# 高并发的情况下, 需要减小此值到64K-128K
sort-buffer-size = 1M
# 每个查询最大的缓存大小是1M, 最大缓存64M 数据
query-cache-size = 64M
query-cache-limit = 1M
# 提到 join 的效率
join-buffer-size = 16M
# 线程连接重复利用
thread-cache-size = 64### InnoDB 优化
## 内存利用方面的设置
# 数据缓冲区
innodb-buffer-pool-size=2G
## 日志方面设置
# 事务日志大小
innodb-log-file-size = 256M
# 日志缓冲区大小
innodb-log-buffer-size = 4M
# 事务在内存中的缓冲
innodb-log-buffer-size = 3M
# 主库保持系统默认, 事务立即写入磁盘, 不会丢失任何一个事务
innodb-flush-log-at-trx-commit = 1# mysql 的数据文件设置, 初始100, 以10M 自动扩展
#innodb-data-file-path = ibdata1:100M:autoextend
# 为提高性能, MySQL可以以循环方式将日志文件写到多个文件
innodb-log-files-in-group = 3##其他设置
# 如果库里的表特别多的情况，请增加此值
#innodb-open-files = 800# 为每个 InnoDB 表分配单独的表空间
innodb-file-per-table = 1# InnoDB 使用后台线程处理数据页上写 I/O（输入）请求的数量
innodb-write-io-threads = 8# InnoDB 使用后台线程处理数据页上读 I/O（输出）请求的数量
innodb-read-io-threads = 8# 启用单独的线程来回收无用的数据
innodb-purge-threads = 1# 脏数据刷入磁盘(先保持系统默认, swap 过多使用时, 调小此值, 调小后, 与磁盘交互增多, 性能降低)
 innodb-max-dirty-pages-pct = 90# 事务等待获取资源等待的最长时间
innodb-lock-wait-timeout = 120# 开启 InnoDB 严格检查模式, 不警告, 直接报错 1开启 0关闭
innodb-strict-mode=1# 允许列索引最大达到3072
 innodb-large-prefix = on

[mysqldump]
# 开启快速导出
quick
default-character-set = utf8mb4
max-allowed-packet = 256M
-----------------------------------
©著作权归作者所有：来自51CTO博客作者898009427的原创作品，请联系作者获取转载授权，否则将追究法律责任
MySQL 5.7 my.cnf配置文件说明
https://blog.51cto.com/moerjinrong/2092791
```
