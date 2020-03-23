## ajax和axios、fetch的区别

#### jQuery ajax

```javascript
$.ajax({
   type: 'POST',
   url: url,
   data: data,
   dataType: dataType,
   success: function () {},
   error: function () {}
});
```
传统 `Ajax` 指的是 `XMLHttpRequest（XHR）`， 最早出现的发送后端请求技术，隶属于原始js中，核心使用XMLHttpRequest对象，多个请求之间如果有先后关系的话，就会出现回调地狱。

`JQuery ajax `是对原生`XHR`的封装，除此以外还增添了对`JSONP`的支持。经过多年的更新维护，真的已经是非常的方便了，优点无需多言；如果是硬要举出几个缺点，那可能只有：

- 本身是针对`MVC`的编程,不符合现在前端`MVVM`的浪潮
- 基于原生的`XHR`开发，`XHR`本身的架构不清晰。
- `JQuery`整个项目太大，单纯使用`ajax`却要引入整个`JQuery`非常的不合理（采取个性化打包的方案又不能享受`CDN`服务）
- 不符合关注分离（Separation of Concerns）的原则
- 配置和调用方式非常混乱，而且基于事件的异步模型不友好。


#### axios
[文档](https://www.kancloud.cn/yunye/axios/234845)

```javascript

axios({
    method: 'post',
    url: '/user/12345',
    data: {
        firstName: 'Fred',
        lastName: 'Flintstone'
    }
})
.then(function (response) {
    console.log(response);
})
.catch(function (error) {
    console.log(error);
});
```

`axios` 是一个基于`Promise` 用于浏览器和 `nodejs` 的 `HTTP` 客户端，本质上也是对原生`XHR`的封装，只不过它是`Promise`的实现版本，符合最新的`ES`规范，它本身具有以下特征：

- 从浏览器中创建 `XMLHttpRequest`
- 支持 `Promise API`
- 客户端支持防止`CSRF`
- 提供了一些并发请求的接口（重要，方便了很多的操作）
- 从 node.js 创建 `http` 请求
- 拦截请求和响应
- 转换请求和响应数据
- 取消请求
- 自动转换`JSON`数据

#### fetch

```javascript

try {
  let response = await fetch(url);
  let data = response.json();
  console.log(data);
} catch(e) {
  console.log("Oops, error", e);
}
```
`fetch`号称是`ajax`的替代品，是在`ES6`出现的，使用了`ES6`中的`promise`对象。

`fetch`是基于`promise`设计的。`fetch`的代码结构比起`ajax`简单多了，参数有点像jQuery ajax。

但是，一定记住`fetch`不是`ajax`的进一步封装，而是原生js，没有使用`XMLHttpRequest`对象。


fetch的优点：
1. 符合关注分离，没有将输入、输出和用事件来跟踪的状态混杂在一个对象里
2. 更好更方便的写法

坦白说，上面的理由对我来说完全没有什么说服力，因为不管是Jquery还是Axios都已经帮我们把xhr封装的足够好，使用起来也足够方便，为什么我们还要花费大力气去学习fetch？
我认为fetch的优势主要优势就是：

1.  语法简洁，更加语义化
2.  基于标准 Promise 实现，支持 async/await
3.  同构方便，使用 [isomorphic-fetch](https://github.com/matthew-andrews/isomorphic-fetch)
4. 更加底层，提供的API丰富（request, response）
5. 脱离了XHR，是ES规范里新的实现方式

> 总结：`axios`既提供了`并发`的封装，也没有`fetch`的各种问题，而且体积也较小，当之无愧现在最应该选用的请求的方式。
