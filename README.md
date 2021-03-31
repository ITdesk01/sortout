# sortout
用于电影或者动漫重命名，方便刮削

## 目录
* [测试平台](#测试平台)
* [使用办法](#使用办法)
* [文件目录](#文件目录)
* [电影例子](#电影例子)
* [动漫例子](#动漫例子)

## 测试平台
      
      ubuntu 18.4

## ubuntu18.4使用办法
```

1.git clone https://github.com/ITdesk01/sortout.git

2.cd  sourtout && sh sortout.sh (创建主要文件夹)

3.把电影或者动漫放到目录下去，下面有例子

```

## 文件目录
```
sortout
├── 电影（文件夹）
│   └── XXXX电影.后缀名
├── 动漫（文件夹）
│   └── XXXX.动漫
│         ├──S01  第一季
│         ├──S02  第二季
│         └──以此类推.....
│ 
├── sortout.sh  （核心脚本）
└── filter.txt  （过滤关键字文本）
```

**如果你有群辉电影文件需要整理可以这么做**
```
1.完成上面的操作

2.挂载群辉nas文件夹到ubuntu，参考：https://blog.csdn.net/bairw_Bella/article/details/108449039

3.删除sortout/电影  sortout/动漫 ，两个文件夹

4.把挂载的nas/电影  nas/动漫 文件夹映射到 sortout/电影  sortout/动漫

5.sh sortout.sh 查看说明开始测试

```



## 电影例子：
**整理前**

![image](https://user-images.githubusercontent.com/38835844/112927366-736a8b80-9147-11eb-91e2-f83056cfe2b1.png)

![image](https://user-images.githubusercontent.com/38835844/112927415-867d5b80-9147-11eb-9e36-f39659003c88.png)


**执行代码**
```      
      sh $sortout movie
```
**整理后**

![image](https://user-images.githubusercontent.com/38835844/112947346-429b4e00-9169-11eb-876f-7d135e9fc3b0.png)


![image](https://user-images.githubusercontent.com/38835844/112928790-d2c99b00-9149-11eb-807a-5d26d3db6384.png)

![image](https://user-images.githubusercontent.com/38835844/112929378-e32e4580-914a-11eb-8d33-3286958fe61f.png)


## 动漫例子：
**整理前**

![image](https://user-images.githubusercontent.com/38835844/112947664-aaea2f80-9169-11eb-81e1-2cb2c148cfe9.png)


**执行代码**
```      
      sh $sortout anime
```
**整理后**

![image](https://user-images.githubusercontent.com/38835844/112948122-3f549200-916a-11eb-8121-c61208bf44ea.png)

![image](https://user-images.githubusercontent.com/38835844/112948205-5bf0ca00-916a-11eb-900a-6ec582ac651d.png)





