### XSS

> 跨站脚本攻击(Crocs-Site Script，XSS)

是一种常见的Web安全漏洞，它允许攻击者将恶意脚本注入到网站的页面中，从而执行一些不被用户授权的操作

攻击者通过XSS攻击可以窃取用户的敏感信息(如cookie，会话ID)，操作页面内容或者进行钓鱼攻击。

#### 原理

XSS攻击的基本原理是在网页中插入恶意的JavaScript代码，当用户访问该网页时，恶意脚本会在用户浏览器中执行。XSS有三种主要类型：

> 存储式XSS(Stored XSS)
- 恶意脚本存储在服务器的数据库中，当用户访问某个页面时，脚本被回显并在浏览器端执行。
- 例如：攻击者在评论区提交含有恶意JavaScript代码的评论，其他用户查看时执行恶意脚本。

> 反射式XSS(Reflected XSS)
- 恶意脚本作为URL参数传递给服务器，服务器在响应中回显并在浏览器端执行。
- 例如：攻击者通过URL参数将恶意JavaScript代码注入到网站中，当用户点击链接时，恶意脚本被执行。

> 基于DOM的XSS(DOM-based XSS)
- 攻击者通过操控页面的DOM，利用客户端的JavaScript来注入恶意脚本。该脚本不需要经过服务器端，而是完全通过浏览器执行。

#### XSS攻击的危害
> 窃取用户信息
- 攻击者可以通过XSS攻击获取用户的敏感信息，如cookie，会话ID等。
- 攻击者可以利用这些信息进行身份伪造，进行恶意操作。

> 操纵页面内容
- 攻击者可以通过XSS攻击修改页面内容，例如插入广告，修改链接等。
- 攻击者可以利用这些操作来进行恶意广告投放，进行钓鱼攻击。

> 执行恶意脚本
- 攻击者可以通过XSS攻击执行恶意脚本，例如执行恶意代码，窃取用户信息等。
- 攻击者可以利用这些恶意脚本进行恶意操作。

#### XSS攻击的防范
- 输出编码（Output Encoding）：

对用户输入的任何内容进行编码，特别是对HTML标签中的字符进行转义。这样即使用户输入了恶意的JavaScript代码，它也会作为纯文本呈现，而不会被执行。

- 输入验证：

对用户输入进行严格的验证和过滤，确保不接受任何潜在的恶意输入。

- 使用HTTP头部安全策略：

通过设置 Content-Security-Policy (CSP)，指定哪些资源可以加载，限制外部脚本的执行。

- 避免直接插入不受信任的用户输入到HTML中：

使用合适的API（如textContent而非innerHTML）来操作DOM。

- 使用框架的安全功能：

很多现代框架（如React、Vue）都有自动进行XSS防护的机制。

PHP中的XSS防御
在PHP中，我们可以使用以下方法来防止XSS攻击：

1. 对输出进行HTML转义（htmlspecialchars）
htmlspecialchars()
函数可以将特殊的HTML字符转换成HTML实体。比如 < 转为 &lt;，> 转为 &gt;，" 转为 &quot;，& 转为 &amp;，从而防止脚本执行。
代码示例
```code
<?php
// 假设有一个用户输入的字符串
$user_input = '<script>alert("XSS Attack!");</script>';

// 使用 htmlspecialchars 对输出进行转义
$safe_input = htmlspecialchars($user_input, ENT_QUOTES, 'UTF-8');

// 输出安全内容
echo $safe_input;  // 输出: &lt;script&gt;alert(&quot;XSS Attack!&quot;);&lt;/script&gt;
?>
```

2. 对URL和HTML属性的输入进行编码
如果用户的输入被用在URL或HTML属性中，必须确保这些输入是被正确编码的，以避免攻击。
```code
<?php
// 用户输入的URL参数
$user_url = 'https://example.com/?search=<script>alert("XSS")</script>';

// 对URL进行编码
$safe_url = htmlspecialchars($user_url, ENT_QUOTES, 'UTF-8');

// 输出安全的URL
echo '<a href="' . $safe_url . '">点击这里</a>';
?>
```

3. 使用Content-Security-Policy（CSP）头部
CSP是一种Web安全机制，可以通过HTTP头部来限制浏览器加载资源的方式，防止执行未经授权的JavaScript代码。

<?php
header("Content-Security-Policy: default-src 'self'; script-src 'self'; object-src 'none';");
?>
4. 避免直接操作HTML DOM
尽量避免直接使用innerHTML等方法来插入用户输入的内容，而是使用如textContent这样的安全方法。

// 不安全方式
element.innerHTML = user_input;  // 可能会执行用户输入的恶意脚本

// 安全方式
element.textContent = user_input;  // 不会执行用户输入的脚本
完整防御代码示例
```code
<?php
// 防止XSS攻击的完整示例

// 获取用户输入
$user_input = $_GET['user_input'];  // 假设来自URL的查询参数

// 1. 使用 htmlspecialchars 进行转义
$safe_input = htmlspecialchars($user_input, ENT_QUOTES, 'UTF-8');

// 2. 防止XSS注入URL参数
$safe_url = htmlspecialchars('https://example.com/?search=' . $user_input, ENT_QUOTES, 'UTF-8');

// 3. 防止在HTML标签中注入恶意脚本
echo '<div>User Input: ' . $safe_input . '</div>';

// 4. 输出安全的链接
echo '<a href="' . $safe_url . '">点击查看搜索结果</a>';

// 5. 使用Content-Security-Policy头部增加安全性
header("Content-Security-Policy: default-src 'self'; script-src 'self'; object-src 'none';");

?>
```

### CSRF

> 跨站请求伪造(Crocs Site Request Forgery)，攻击者可以在第三方站点制造HTTP请求并以用户在目标站点的登录状态发送到目标站点，而目标站点未校验请求来源使第三方成功伪造请求。

攻击流程：

1. 用户打开浏览器，登录A站点，登录成功后产生Cookie信息返回给浏览器
2. 用户未退出A站点，在同一浏览器中，打开站点B
3. 站点B接收到用户请求后，返回一些攻击性代码，并发出一个请求访问A站点
4. 站点B在用户不知情的情况下携带Cookie信息向A站点发送请求

防范：

1. 使用csrf token

> 在from表单或头信息中传递一个随机产生的token，并在服务器端验证该token是否与用户提交的token一致。
> 每次HTTP请求时都重新产生一个token，并将该token存入Session中。
> 当用户提交请求时，服务器端取出该token与用户提交的token进行比较，如果不一致则认为是非法请求。

2. 限制referrer
> HTTP请求头Referrer字段是浏览器默认带上，含义是发送请求的页面地址。

> Http请求头中有一个字段refer，记录了该HTTP请求的来源地址。通常情况下，访问一个安全受限页面的请求必须来自同一个网站。

3. 尽量使用POST请求

4. 加入验证码


### SQL注入

> 防范 SQL 注入是确保 Web 应用安全的关键步骤之一。SQL 注入攻击是通过在输入字段中插入恶意 SQL 代码，试图操纵数据库查询，从而获取敏感信息或执行未经授权的操作。以下是防范 SQL 注入的多种方法：

1. 使用参数化查询（Prepared Statements）
参数化查询是防范 SQL 注入最有效的方法之一。通过使用参数化查询，你可以确保用户输入的内容不会被当作 SQL 代码执行。
示例（PHP 使用 PDO）：
```
<?php
// 创建数据库连接
$dsn = 'mysql:host=localhost;dbname=testdb';
$username = 'dbuser';
$password = 'dbpass';
try {
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // 准备 SQL 语句
    $stmt = $pdo->prepare('SELECT * FROM users WHERE username = :username AND password = :password');

    // 绑定参数
    $stmt->bindParam(':username', $username);
    $stmt->bindParam(':password', $password);

    // 设置用户输入
    $username = 'admin';
    $password = 'password123';

    // 执行查询
    $stmt->execute();

    // 获取结果
    $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
    print_r($result);
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}
?>
```
示例（PHP 使用 MySQLi）：
```
<?php
// 创建数据库连接
$conn = new mysqli('localhost', 'dbuser', 'dbpass', 'testdb');

// 检查连接
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 准备 SQL 语句
$stmt = $conn->prepare("SELECT * FROM users WHERE username = ? AND password = ?");
$stmt->bind_param("ss", $username, $password);

// 设置用户输入
$username = 'admin';
$password = 'password123';

// 执行查询
$stmt->execute();

// 获取结果
$result = $stmt->get_result();
while ($row = $result->fetch_assoc()) {
    print_r($row);
}

// 关闭连接
$stmt->close();
$conn->close();
?>
```

2. 使用ORM框架
3. 输入验证
4. 最小权限原则
5. 定期安全审计
