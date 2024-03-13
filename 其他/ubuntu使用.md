> 应用程序的启动器

> **全局启动器文件夹：** 这些是系统范围的启动器文件，适用于所有用户。它们通常位于 /usr/share/applications 文件夹中。

> **用户个人启动器文件夹：** 这些是用户特定的启动器文件，仅适用于当前用户。它们通常位于 ~/.local/share/applications 文件夹中。

### docker 安装微信
```
docker run -d --name wechat --device /dev/snd --ipc=host \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v $HOME/WeChatFiles:/WeChatFiles \
-e DISPLAY=unix$DISPLAY \
-e XMODIFIERS=@im=fcitx \
-e QT_IM_MODULE=fcitx \
-e GTK_IM_MODULE=fcitx \
-e AUDIO_GID=`getent group audio | cut -d: -f3` \
-e GID=`id -g` \
-e UID=`id -u` \
bestwu/wechat
```
```
docker start wechat
docker restart wechat
docker stop wechat
docker kill wechat
```
## ukylin-wechat

### ukylin-wine
https://archive.ubuntukylin.com/software/pool/partner/ukylin-wine_70.6.3.25_amd64.deb
### ukylin-wechat
https://archive.ubuntukylin.com/ubuntukylin/pool/partner/ukylin-wechat_3.0.0_amd64.deb

```code
sudo dpkg -i ukylin-wine_70.6.3.25_amd64.deb
sudo dpkg -i ukylin-wechat_3.0.0_amd64.deb
```
