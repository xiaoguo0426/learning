在日常运维和开发工作中，查看和分析日志是我们最常做的工作之一。无论是排查系统故障、分析应用性能，还是监控系统状态，都离不开日志这个"黑匣子"。今天就来为大家全面总结Linux系统中日志查看和追踪的各种实用技巧。

1. 实时追踪篇：掌握日志的"生命脉搏"

> tail -f：最经典的实时追踪

```bash
# 基础用法
tail -f /var/log/nginx/access.log

# 显示行号并追踪
tail -f -n 20 /var/log/application.log

# 同时追踪多个文件
tail -f /var/log/nginx/access.log /var/log/nginx/error.log
```

> tail -F：应对日志轮转的智能选择
```bash
# 当日志文件被轮转时自动跟踪新文件
tail -F /var/log/application.log

```

实用场景：当你的应用每天会自动切割日志时，使用-F参数可以无缝切换到新的日志文件，不会丢失任何重要信息。

2. 系统日志篇：journalctl的强大威力
对于使用systemd的现代Linux系统，journalctl是必须掌握的工具：

```bash
# 实时追踪系统日志
journalctl -f

# 查看指定服务日志
journalctl -u nginx.service -f

# 按时间筛选
journalctl --since "2024-01-15 09:00:00" --until "2024-01-15 10:00:00"

# 按优先级过滤
journalctl -p err
journalctl -p warning
```

3. 内核日志篇：dmesg的妙用

```bash
# 查看内核日志
dmesg

# 实时监控内核消息
dmesg -w

# 只显示错误信息
dmesg -l err

# 查看最近的内核消息
dmesg | tail -20

```

4. 分页查看篇：高效浏览大量日志
less：功能最全面的分页器
```bash
# 进入分页浏览模式
less /var/log/syslog

# 在less中实时追踪（按Shift+F）
# 搜索功能：输入 /关键词 进行搜索
# 退出：按 q 键
```

5. 更人性化的lnav
```bash
# 安装：yum install lnav 或 apt install lnav
lnav /var/log/
# 自动识别日志格式，支持时间轴导航
# 语法高亮，错误信息自动标记
```


5. 多日志监控篇：multitail的多任务视野

```bash
# 同时监控多个日志文件
multitail /var/log/nginx/access.log /var/log/nginx/error.log

# 为不同日志指定颜色方案
multitail -cS apache /var/log/apache2/access.log \
          -cS mysql /var/log/mysql/error.log \
          -cS syslog /var/log/syslog
```

6. 过滤搜索篇：精准定位问题
grep：日志搜索的瑞士军刀

```bash
# 基础搜索
grep "ERROR" /var/log/application.log

# 忽略大小写
grep -i "timeout" /var/log/application.log

# 显示上下文（前后各3行）
grep -A 3 -B 3 "connection refused" /var/log/application.log

# 实时过滤
tail -f /var/log/application.log | grep -i "exception"
```

awk：结构化处理利器
```bash
# 提取特定字段
awk '{print $1, $4, $9}' /var/log/nginx/access.log

# 条件过滤
awk '$9 == 500 {print $0}' /var/log/nginx/access.log

# 统计状态码出现次数
awk '{print $9}' /var/log/nginx/access.log | sort | uniq -c
```
7. 组合技巧篇：解决实际问题的"组合拳"
场景1：实时监控并高亮关键错误

```bash
tail -f /var/log/application.log | grep --color -E "ERROR|WARN|Exception|$"
```
场景2：统计最近1小时内的错误趋势
```bash
journalctl --since "1 hour ago" | grep -c -i error
```
场景3：分析HTTP状态码分布
```bash
awk '{print $9}' /var/log/nginx/access.log | sort | uniq -c | sort -nr
```
场景4：查看特定时间段的日志
```bash
sed -n '/2024-01-15 14:00:00/,/2024-01-15 15:00:00/p' /var/log/application.log
```
8. 实用工具篇：提升效率的"神器"
日志文件自动补全
```bash
# 使用tab键自动补全日志路径
tail -f /var/log/nginx/   # 按tab查看可用日志文件
```
历史日志查看
```bash
# 查看压缩的归档日志
zcat /var/log/syslog.1.gz | grep "error"
zgrep "exception" /var/log/application.log.2.gz
```
实战案例：Web服务器故障排查
假设你的网站突然出现500错误，如何快速定位问题？
```bash
# 1. 实时监控访问日志中的错误
tail -f /var/log/nginx/access.log | grep "500"

# 2. 同时监控错误日志
tail -f /var/log/nginx/error.log

# 3. 查看系统资源情况
dmesg | tail -20

# 4. 检查应用日志
journalctl -u your-app.service -f

# 5. 统计错误频率，找到规律
awk '$9 == 500 {print $7}' /var/log/nginx/access.log | sort | uniq -c | sort -nr
```

总结：选择合适的工具

| 场景     | 推荐工具     |  优点 |
| :------------- | :------------- | :------------- |
| 实时监控单个日志  |    tail -f     |   简单直观      |
| 日志轮转环境     |    tail -F     |   自动跟踪新文件  |
| 系统服务日志     |    journalctl -f     |   集成度高  |
| 多日志同时监控   |    multitail   |   统一视图       |
| 交互式浏览      |    less / lnav  |   搜索方便      |
| 快速搜索        |    grep        |   过滤精准       |
| 统计分析        |    awk         |   处理结构化数据  |
