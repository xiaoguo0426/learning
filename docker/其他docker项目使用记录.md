
#### sentry

私有化部署sentry一直报错。系debian源问题，需要修改 /jq/Dockerfile文件

```
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
```
