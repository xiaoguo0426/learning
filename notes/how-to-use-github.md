## **开源项目的组成部分**

在讲清楚之前呢，我们先来了解一下一个开源项目有哪些组成部分：

- name: 项目名
- description: 项目的简要描述
- 项目的源码
- README.md: 项目的详细情况的介绍

那么除了这些要素之外，项目本身的star数和fork数，也是评判一个开源项目是否火热的标准，这同时也是一个很重要的搜索标准。另外我们也要注意观察这个项目的最近更新日期，因为项目越活跃，那么它的更新日期也更加频繁。

以上要素就是我们在进行搜索的时候要注意的一些关键点。

## **如何搜索**

那我们到底如何搜索呢？

假设我们现在要搜索React,相信大部分小伙伴都是直接在搜索框里输入：“React”，然后一回车，你就会发现情况像下面这样：

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZgusvEoZPJUJeBFBwCzmibD6ibdA9c9onmv0zCJ5ib2paNOdrqRWCfIENbGA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

搜索结果会显示非常多的开源项目，简直让你应接不暇，无从下手，很多小伙伴搜到这一步就放弃了，因为项目太多了，根本找不到如何找到自己感兴趣的开源项目，所以这样搜索非常的不准确。所以我们来学习一下稍微精确一点的搜索方法。

### **按照 name 搜索**

搜索项目名里面包含React的项目:

```
in:name React
```

得到如下结果：

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZguyXGXPgpbMKu4Oh7KsFRibGzgvVvhSAhXZQXbPj3icPT6KNhn7EoN7Kvw/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

可以看到，这些搜索结果都是项目名里面带有“React”关键字的项目，但是项目数量依旧很多。

现在我们来约束一下

比如我再精确到项目的star数大于5000+：

```
in:name React stars:>5000
```

结果是这样的：

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZguJibwpdtJzJdzbLmZYN6o8USDyf9dhJibia1yaEvZIbVXH7A2MCVTCibLxg/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

搜索结果瞬间精确了很多，现在只有114个项目可供选择。当然我们一般不会把star数设置得这么高，一般设置个1000就差不多了。

同理，我们也可以按照fork的数量来进行搜索:

```
in:name React stars:>5000 forks:>3000
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZguicic1ZBZQSFcpYBF9R07QV24ib1ibOKKt8PV3N8rVkwJDQpIEdzHaYW5ZA/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

你会发现，结果越来越精确！

### **按照README来搜索**

搜索README.md里面包含React的项目:

```
 in:readme React
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZguAMpvZagDyiaHOtCVNbI1b7YQYXNj8SFQlORJ4ylBaMdQqMg5ukicG0ww/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

结果有这么多，那么我们再限制一下它的star数和fork数：

```
in:readme React stars:>3000 forks:>3000
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZguMsQqmqRicOiaM4LUvvzqNvfLavKPeHOJZaTNaqONyQ9NNMp5SKY2ZEHQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

搜索结果一下子精确到了90个。这个时候你再去选择项目，就会变得容易很多。

### **按照descriptin搜索**

假设我们现在要学习微服务的项目，我们搜索项目描述(description)里面包含微服务的项目:

```
in:description 微服务
```

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZguwDumbB8X8lrnQINiaO2MUwLrscjvpvQ6cb61lZtpzLb33QxSLXV7s1A/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

结果有这么多，那我们接着增加一些筛选条件:

```
in:description 微服务 language:python 
```

language:python的意思是我们把语言限制为python，我们来看看结果如何:

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZguE18x3q5iaNPODucm4licHuJSnbzIN2GVBrPUekj29trNfiaN6CskKg7ow/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

搜索结果精确了很多。

假如在这些项目里面，我们想要找到最近才更新的项目，意思是更新时间就在最近，我们可以这样：

```
in:description 微服务 language:python pushed:>2020-01-01
```

pushed:>2020-01-01的意思是我们把项目的最后更新时间限制到2020-01-01，我们来看看结果如何:

![图片](https://mmbiz.qpic.cn/mmbiz_png/ePw3ZeGRruzTpKC8s1FAM1adk187WZgu6NfRx2ryNuC2O0UJmAwOsicopwVPJmzh2MNyQ6nHlkELDOPCC4n4SSQ/640?wx_fmt=png&tp=webp&wxfrom=5&wx_lazy=1&wx_co=1)

搜索结果只有8个了，这几个项目就属于更新比较活跃的项目，这下再也不纠结了。

## **总结**

好，我们来总结一下。我们想要进行精准搜索，无非就是增加筛选条件。

- in:name xxx // 按照项目名搜索
- in:readme xxx // 按照README搜索
- in:description xxx // 按照description搜索

那么在这里面呢，我们又可以增加筛选条件

- stars:>xxx // stars数大于xxx
- forks:>3000 // forks数大于xxx
- language:xxx // 编程语言是xxx
- pushed:>YYYY-MM-DD // 最后更新时间大于YYYY-MM-DD

以上就是我们在GitHub上面精准搜索项目的一些小技巧，希望对你有所帮助！