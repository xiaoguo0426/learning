#### 获取有性能问题的SQL

- 通过用户反馈获取存在性能问题的SQL

> 特点：被动，已经影响到用户使用

- 通过慢查询日志获取存在性能问题的SQL

> 由mysql服务器层记录；对慢查询日志分析，得出哪些SQL存在性能问题

- 实时获取存在性能问题的SQL



##### 慢查询日志

- `slow_query_log` 启动停止记录慢查询日志
- `slow_query_log_file` 指定慢查询日志的存储路径及文件
- `slow_query_time` 指定记录慢查询日志SQL执行时间的伐值，默认10秒
- `log_queries_not_using_indexes` 是否记录未使用索引的SQL

```mysql
//查看状态
show global variables like '%general%';

//开启general log
general_log = 0
log_output = 'table';//SQL语句写入表
general_log_file = /var/lib/mysql/general.log  //SQL语句写入日志

CREATE TABLE `general_log` (
 `event_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
 `user_host` mediumtext NOT NULL,
 `thread_id` bigint(21) unsigned NOT NULL,
 `server_id` int(10) unsigned NOT NULL,
 `command_type` varchar(64) NOT NULL,
 `argument` mediumtext NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='General log'

```

```mysql

slow_query_log='ON'
slow_query_log_file=/var/lib/mysql/slow-query.log
long_query_time=2


CREATE TABLE `slow_log` (
 `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
                        ON UPDATE CURRENT_TIMESTAMP,
 `user_host` mediumtext NOT NULL,
 `query_time` time NOT NULL,
 `lock_time` time NOT NULL,
 `rows_sent` int(11) NOT NULL,
 `rows_examined` int(11) NOT NULL,
 `db` varchar(512) NOT NULL,
 `last_insert_id` int(11) NOT NULL,
 `insert_id` int(11) NOT NULL,
 `server_id` int(10) unsigned NOT NULL,
 `sql_text` mediumtext NOT NULL,
 `thread_id` bigint(21) unsigned NOT NULL
) ENGINE=CSV DEFAULT CHARSET=utf8 COMMENT='Slow log'
```

###### 常用的慢查询日志分析工具

- mysqldumpslow

- pt-query-digest

- infomation_schema.processlist


#### MySQL服务器处理查询请求的整个过程

- 客户端发送SQL请求给服务器
- 服务器检查是否可以在查询缓存中命中该SQL
- 服务器端进行SQL解析，预处理，再由优化器生成对应的执行计划
- 根据执行计划，调用存储引擎API来查询数据
- 将结果返回给客户端


#####  特定SQL的查询优化

- 如果修改大表的表结构  pt-online-schema-change
