### 外观模式 Facade   

上一节我们讲到需要 `$ioc->make ('user')` 才能拿到 `User` 的实例，再去使用 `$user->login ();` 那能不能更方便点，比如下面的用法，是不是很方便。

```
UserFacade::login();

```

### Facade 工作原理

1. Facade 核心实现原理就是在 `UserFacade` 提前注入 Ioc 容器。

2. 定义一个服务提供者的外观类，在该类定义一个类的变量，跟 ioc 容器绑定的 key 一样，

3. 通过静态魔术方法`__callStatic` 可以得到当前想要调用的 `login`

4. 使用 `static::$ioc->make ('user');`


### Laravel 为什么要定义 Facades，它有什么好处？

其实 laravel 在框架运行的时候这些步骤都帮我们自动加好了，我们只需要使用 `UserFacade::login ();` 就可以了。

使用 Facades 其实最主要的就是它提供了简单，易记的语法，从而无需手动注入或配置长长的类名。此外，由于他们对 PHP 静态方法的独特调用，使得测试起来非常容易。
