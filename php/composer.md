
#### 镜像加速

```bash
// 全局配置  推荐
$ composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/    //阿里云

// 单项目使用
$ composer config repo.packagist composer https://mirrors.aliyun.com/composer/
```

[文档](https://learnku.com/docs/composer/2018)


#### 自动加载机制
在PHP开发过程中，如果希望从外部引入一个class，通常会使用include和require方法，去把定义这个class的文件包含进来。这个在小规模开发的时候，没有太大问题。但在大型的开发项目中，这样做会产生大量的require和include方法调用，这样不但降低效率，而且使得代码难以维护，况且require_once的代价很大。

在PHP5后，当加载PHP类时，如果类所在文件没有被包含进来，或者类名出错，Zend引擎会自动调用__autoload函数。此函数需要用户自己实现__autoload函数。

在PHP5.1.2版本后，可以使用spl_autoload_register函数自定义自动加载处理函数。但没有调用此函数，默认情况下会使用SPL自定的spl_autoload函数。

这就是类的自动装载(autoload)机制。autoload机制可以使得PHP程序有可能**在使用类时才自动包含类文件**，而不是一开始就将所有的类文件inlcude进来，这种机制也成为lazy loading.


https://learnku.com/articles/4681/analysis-of-the-principle-of-php-automatic-loading-function

https://blog.csdn.net/hguisu/article/details/7463333

https://www.jb51.net/article/31279.htm

https://learnku.com/php/t/1002/deep-composer-autoload
