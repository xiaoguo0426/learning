### XSS

> 跨站脚本攻击(Crocs Site Script，XSS)

防范：

- 对用户提交的数据进行过滤
- Web页面显示时对数据进行特殊处理（htmlspecialchars/htmlentities）

### CSRF

> 跨站请求伪造(Crocs Site Request Forgery)，攻击者可以在第三方站点制造HTTP请求并以用户在目标站点的登录状态发送到目标站点，而目标站点未校验请求来源使第三方成功伪造请求。

攻击流程：

1. 用户打开浏览器，登录A站点，登录成功后产生Cookie信息返回给浏览器
2. 用户未退出A站点，在同一浏览器中，打开站点B
3. 站点B接收到用户请求后，返回一些攻击性代码，并发出一个请求访问A站点
4. 站点B在用户不知情的情况下携带Cookie信息向A站点发送请求

防范：

1. 使用token

> JWT。基于token不能被其他域访问的前提。
> 请求中加入一个TOKEN参数，后端在session中验证这个TOKEN是否合法。

2. 限制refer

> Http请求头中有一个字段refer，记录了该HTTP请求的来源地址。通常情况下，访问一个安全受限页面的请求必须来自同一个网站。


### SQL注入

> SQL注入指的是发生在Web应用对后台数据库查询语句处理存在的安全漏洞

防范：
- PDO 预处理(Prepared Statement机制)

```mysql

<?php
/* 传入数组的值，并执行准备好的语句 */
$sql = 'SELECT name, colour, calories
    FROM fruit
    WHERE calories < :calories AND colour = :colour';
$sth = $dbh->prepare($sql, array(PDO::ATTR_CURSOR => PDO::CURSOR_FWDONLY));
$sth->execute(array(':calories' => 150, ':colour' => 'red'));
$red = $sth->fetchAll();

```
