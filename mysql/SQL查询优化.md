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
