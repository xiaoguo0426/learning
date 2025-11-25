## 一、systemctl基础：从启动服务开始

### 1.1 服务的基本操作，用nginx举例：
#### 启动一个服务
sudo systemctl start nginx

#### 停止一个服务
sudo systemctl stop nginx

#### 重新加载配置(不中断服务)
sudo systemctl reload nginx

#### 查看服务状态
systemctl status nginx

### 1.2 服务的开机自启管理
#### 启用开机自启
sudo systemctl enable nginx

#### 禁用开机自启
sudo systemctl disable nginx

#### 查看是否启用自启
systemctl is-enabled nginx


## 二、进阶技巧：深入了解服务状态

### 2.1 查看详细的单元信息

#### 显示服务的所有属性
systemctl show nginx

#### 列出服务的依赖关系
systemctl list-dependencies nginx

### 2.2 服务日志查看

#### 查看服务的日志(需要journald支持)
journalctl -u nginx

#### 实时跟踪日志输出
journalctl -u nginx -f

#### 查看特定时间段的日志
journalctl -u nginx --since "2025-0-024" --until "2025-05-25"

## 三、实战应用：解决常见问题
### 3.1 服务启动失败排查

当服务启动失败时，可以按照以下步骤排查：

1. 查看详细状态信息：systemctl status service-name -l
2. 检查日志：journalctl -xe
3. 手动测试启动：直接运行服务二进制文件查看输出，即不要放在后台执行，直接看输出什么。
4. 检查依赖关系：systemctl list-dependencies service-name

### 3.2 自定义服务单元文件

当需要添加自定义服务时，可以创建.service文件，如：
创建一个Python应用的service文件：
> vim /etc/systemd/system/myapp.service

文件内容示例：
```code
[Unit]
Description=My Python Application
After=network.target

[Service]
User=python
WorkingDirectory=/path/to/app
ExecStart=/usr/bin/python3 /path/to/app/main.py
Restart=always

[Install]
WantedBy=multi-user.target

```

然后重新加载systemd配置：
> sudo systemctl daemon-reload
> sudo systemctl start myapp

## 四、systemctl的高级用法

### 4.1 资源限制
可以通过systemd对服务进行资源限制：

#### 编辑服务文件添加以下内容
```code
[Service]
MemoryLimit=512M
CPUQuota=50%

```

### 4.2 定时任务替代，systemd也可以替代cron的部分功能：

> vim /etc/systemd/system/mytimer.timer

```code
[Unit]
Description=Run my task daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```
## 五、最佳实践与小技巧
1. 使用别名：在~/.bashrc中添加常用命令的别名
   alias stl='systemctl'
   alias jctl='journalctl'

2. 批量操作：同时操作多个服务
   systemctl restart {nginx,mysql,php-fpm}

3. 快速查找：列出所有失败的服务
   systemctl --failed

## 六、命令速查
| 功能需求            | 命令示例     |
| :-------------    | :------------- |
| 查看服务状态        | systemctl status 服务名       |
| 启动服务            | systemctl start 服务名       |
| 停止服务            | systemctl stop 服务名       |
| 重启服务            | systemctl restart 服务名       |
| 平滑重载配置        | systemctl reload 服务名       |
| 设置开机自启        | systemctl enable 服务名       |
| 取消开机自启         | systemctl disable 服务名       |
| 锁定服务（禁止启动）        | systemctl mask 服务名       |
| 解锁服务            | systemctl unmask 服务名       |
| 查看服务依赖         | systemctl list-dependencies 服务名       |
| 实时查看服务日志         | journalctl -u 服务名 -f       |
| 重载服务配置文件         | systemctl daemon-reload       |
| 查看所有运行的服务         | systemctl list-units --type=service       |
