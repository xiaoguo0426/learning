### 契约

#### Contracts契约之面向接口编程
```
// 文件记录日志
class FileLog
{
    public function write(){
        echo 'file log write...';
    }
}

// 数据库记录日志
class DatabaseLog
{
    public function write(){
        echo 'database log write...';
    }
}

class User
{
    protected $log;
    public function __construct(FileLog $log)
    {
        $this->log = $log;
    }
    public function login()
    {
        // 登录成功，记录登录日志
        echo 'login success...';
        $this->log->write();
    }
}

$user = new User(new FileLog());
$user->login();

```

就说上面的，看似没有什么问题，那如果随着我们日后需求的变更，想更换数据库作为记录日志的方式呢？那就得去改 User 类的内部实现，没有解偶。


修改如下：

```
// 定义日志的接口规范
interface log
{
    public function write();   
}

// 文件记录日志
class FileLog implements Log
{
    public function write(){
        echo 'file log write...';
    }   
}

// 数据库记录日志
class DatabaseLog implements Log
{
    public function write(){
        echo 'database log write...';
    }   
}

class User
{
    protected $log;

    public function __construct(Log $log)
    {
        $this->log = $log;   
    }

    public function login()
    {
        // 登录成功，记录登录日志
        echo 'login success...';
        $this->log->write();
    }

}

$user = new User(new DatabaseLog());
$user->login();

```
类`User`的`__construct`参数不依赖具体的类，而是一个接口类`Log`，类`User`实例化时，由接口类`Log`的实现类`DatabaseLog`传入

我们说，接口类`Log`就是一种契约，称之为面向接口编程。
