NVM是Node.js版本管理工具，可以轻松地在同一台计算机上安装和切换不同版本的Node.js。

以下是在Linux和Mac OS X系统中使用NVM安装Node.js的步骤：

安装NVM：
打开终端窗口，执行以下命令安装NVM：
```bash
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

#如果不成功，可以尝试 https://gitee.com/mirrors/nvm/raw/v0.38.0/install.sh
```

安装成功后，重新启动终端或执行以下命令使NVM生效：
```bash
$ source ~/.bashrc
```
安装Node.js：
使用以下命令安装Node.js：
```bash
$ nvm install node
$ source ~/.bashrc
```
该命令将自动安装最新版本的Node.js。如果要安装特定版本的Node.js，可以使用以下命令：
```bash
$ nvm install 12.16.1
```
该命令将安装Node.js 12.16.1版本。

使用Node.js：
使用以下命令启动已安装的Node.js版本：
```bash
$ nvm use node
```
该命令将启用最新安装的Node.js版本。如果要使用特定版本的Node.js，请使用以下命令：
```bash
$ nvm use 12.16.1
```
该命令将启用Node.js 12.16.1版本。

现在你可以开始使用Node.js啦！
