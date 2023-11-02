> Redis info命令指标

> Server：包含有关Redis服务器的一般信息。

- redis_version：Redis的版本号。
- redis_git_sha1：Redis的Git SHA-1标识符。
- redis_git_dirty：当前Git是否包含未提交的更改。
- redis_build_id：服务器构建的唯一标识符。
- arch_bits：Redis运行的架构（32位或64位）。
- multiplexing_api：用于文件描述符的I/O复用的API名称（例如epoll或kqueue）。
- process_id：Redis服务器进程的ID。
- uptime_in_seconds：服务器运行的秒数。
- uptime_in_days：服务器运行的天数。
- config_file：正在使用的配置文件路径。

> Clients：涉及连接到Redis的客户端的统计信息。

- connected_clients：当前连接到Redis的客户端数。
- client_longest_output_list：输出缓冲区中最大值的长度。
- client_biggest_input_buf：输入内存缓冲区中最大值的长度。
- blocked_clients：当前正在等待数据的阻塞客户端的数量。

> Memory：有关Redis内存使用情况的信息。

- used_memory：分配给Redis的总内存量（以字节为单位）。
- used_memory_human：分配给Redis的总内存量（以人类可读的格式）。
- used_memory_rss：操作系统分配给Redis进程的内存大小（以字节为单位）。
- used_memory_peak：Redis的历史最高内存使用量（以字节为单位）。
- used_memory_peak_human：Redis的历史最高内存使用量（以人类可读的格式）。
- mem_fragmentation_ratio：内存碎片率（used_memory_rss / used_memory）。

> Persistence：有关持久性存储相关统计信息的指标。

- rdb_changes_since_last_save：自从上次RDB持久化操作以来，改变的键的数量。
- rdb_last_save_time：上次成功生成RDB文件的时间。
- aof_enabled：是否启用了附加文件（AOF）持久化。
- aof_rewrite_in_progress：当前是否在进行AOF重写。
- aof_last_rewrite_time_sec：上次AOF重写操作的持续时间（以秒为单位）。
- aof_last_bgrewrite_status：上次启动时，AOF重写操作的结果（例如：ok或err）。

> Stats：包含有关Redis服务器的操作统计信息。

- total_connections_received：服务器已接收的连接总数。
- total_commands_processed：服务器已处理的命令总数。
- instantaneous_ops_per_sec：当前每秒执行的操作数。
- keyspace_hits：查询成功命中数据的次数。
- keyspace_misses：查询未命中数据的次数。
- rejected_connections：由于最大客户端限制而拒绝的连接数。

> Replication：涉及主/从复制相关的统计信息。

- role：Redis服务器的角色（master或slave）。
connected_slaves：已连接的从服务器数量。
- master_repl_offset：协同复制偏移量。

> CPU：有关CPU使用情况的统计信息​​。

- used_cpu_sys：在Redis服务器模式下花费的系统CPU时间。
- used_cpu_user：在Redis服务器模式下花费的用户CPU时间。
- used_cpu_sys_children：在后台子进程模式下花费的系统CPU时间。
- used_cpu_user_children：在后台子进程模式下花费的用户CPU时间。

> Keyspace：包含键空间相关信息：

db0, db1, ...：各数据库编号（例如db0表示数据库0）同时列出了数据库中键的数量，已过期键的数量等。
