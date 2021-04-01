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

2.cd  sourtout && bash sortout.sh (创建主要文件夹)

3.把电影或者动漫放到目录下去，下面有例子

```

## 文件目录
```
sortout
├── 电影（文件夹）
│   └── XXXX电影.后缀名
│
├── 动漫（文件夹）
│   └── XXXX.动漫
│         ├──S01  第一季
│         ├──S02  第二季
│         └──以此类推.....
│
├── config （配置文件夹）
|    ├── sortout_config.txt（配置文件）
│    └── filter.txt （过滤关键字文本）
│         
└── sortout.sh  （核心脚本）
```

**如果你有群辉电影文件需要整理可以这么做**
```
1.完成上面的操作

2.config/sortout_config.txt填上参数

3.bash sortout.sh 开始挂载

PS：如果一直有问题挂载不上去你可以参考连接手动挂载，判断是否自己填错了

挂载群辉nas文件夹到ubuntu，参考：https://blog.csdn.net/bairw_Bella/article/details/108449039


```



## 电影例子：
**整理前**

![image](https://user-images.githubusercontent.com/38835844/113305148-51cef700-9335-11eb-9a16-cceb7b36ceca.png)


**执行代码**
```
      sh $sortout movie
```
**整理后**

![image](https://user-images.githubusercontent.com/38835844/113305719-e5a0c300-9335-11eb-96c0-a60b3b2e9bf6.png)


![image](https://user-images.githubusercontent.com/38835844/113305888-1254da80-9336-11eb-99b5-6646321f8a8e.png)



## 动漫例子：
**整理前**



**执行代码**
```
      sh $sortout anime
```
**整理后**






