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
```

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


sudo desktop-file-install /usr/share/applications/gitkraken.desktop #是根据上面的路径而定，没试过

gnome-shell --replace & #直接gnome挂了，慎用

```
