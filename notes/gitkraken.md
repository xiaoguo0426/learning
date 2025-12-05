#### 源码安装
```
node v12.22
#安装yarn环境
$ npm install -g yarn
```

下载gitkraken Linux版

https://release.axocdn.com/linux/GitKraken-v9.2.1.tar.gz

```code
$ tar -xzf GitKraken-v9.2.1.tar.gz

得到
/path/to/gitkraken/resources/app.asar
```

解压gitkrakenCracken，进入`GitkrakenCracken/GitCracken`
```code
$ yarn install
$ yarn build
$ node dist/bin/gitcracken.js patcher --asar /path/to/gitkraken/resources/app.asar

修改hosts
127.0.0.1 release.gitkraken.com
```

右下角显示为Pro 则成功

#### 创建快捷方式

```

$ touch ~/.local/share/applications/gitkraken.desktop

$ vim ~/.local/share/applications/gitkraken.desktop

[Desktop Entry]
Name=GitKraken
Comment=GitKraken Git client
Exec=path/to/gitkraken
Icon=path/to/gitkraken.png
Terminal=false
Type=Application
Categories=Development;


# 刷新桌面数据库
update-desktop-database ~/.local/share/applications/

# 对于全局快捷方式
sudo update-desktop-database /usr/share/applications/

# 检查桌面文件是否存在
ls -la ~/.local/share/applications/ | grep postman

# 测试执行命令
gtk-launch postman.desktop

```
