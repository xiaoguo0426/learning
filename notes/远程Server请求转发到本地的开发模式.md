```
server {
    listen 80;
    server_name a.ontech.com;
    return 301 https://$host$request_uri;
}

server {
    # For https
    listen 443 ssl;
    # listen [::]:443 ssl ipv6only=on;
    ssl_certificate /etc/ssl/certs/a.onetech.com.crt;
    ssl_certificate_key /etc/ssl/certs/a.onetech.com.key;

    server_name a.ontech.com;

    location / {
        # 转发到 SSH 隧道端口
        proxy_pass http://127.0.0.1:8889;

        # 设置代理头
        proxy_set_header Host "a.onetech.local";
         #proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # 超时设置
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;

        # 缓冲设置
        proxy_buffering off;
        proxy_request_buffering off;
    }
}

```

需要注意的点：

1. 服务器上的 /etc/ssh/sshd_config  

	AllowTcpForwarding yes
	GatewayPorts yes

2. 服务器需要开放指定端口，例如 8889

3. Server 上的 nginx 配置 proxy_set_header Host "a.local"; 一定要是local nginx 配置的domain，否则ssh 转发到local nginx 时会去到默认的localhost 上。

4. 本机上执行 ssh -N -v -R 8889:a.onetech.local:80 user-name@server-ip 命令，监听服务器8889端口
