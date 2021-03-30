# sortout
用于电影或者动漫重命名，方便刮削

## 目录
* [测试平台](#测试平台)
* [使用办法](#使用办法)
* [文件目录](#文件目录)
* [电影例子](#电影例子)
* [动漫例子](#动漫例子)

## 测试平台

      群辉（除了添加全局变量，建议不使用管理员权限运行脚本，防止群辉崩溃！！！）
      
      ubuntu 18.4

## 群辉使用办法
```
1.先把sortout.sh下载到你的目录，坑爹的群辉wget

2.cd 过去，然后执行sh sortout.sh，生成filter.txt（过滤文本） 动漫 电影（文件夹）

3.然后把电影和动漫按文件目录分类

4.管理员执行chmod 777 sortout.sh && sh sortout.sh sys_variable (加上变量以后， 给予权限，然后重启 )

5.sh $sortout 查看命令使用

PS：sh $sortout如果出现权限问题，请用管理员把这个文件删掉，复制一份新的，然后切换普通用户重新执行，群辉这个坑爹货，少用管理员跑脚本，容易挂

```

## ubuntu18.4使用办法
```

1.git clone https://github.com/ITdesk01/sortout.git

2.cd  sourtout && sh sortout.sh (创建文件夹)

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

## 电影例子：
**整理前**

![image](https://user-images.githubusercontent.com/38835844/112927366-736a8b80-9147-11eb-91e2-f83056cfe2b1.png)

![image](https://user-images.githubusercontent.com/38835844/112927415-867d5b80-9147-11eb-9e36-f39659003c88.png)


**执行代码**（不要用root执行，不要root执行，不要root执行）
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


**执行代码**（不要用root执行，不要root执行，不要root执行）
```      
      sh $sortout anime
```
**整理后**

![image](https://user-images.githubusercontent.com/38835844/112948122-3f549200-916a-11eb-8121-c61208bf44ea.png)

![image](https://user-images.githubusercontent.com/38835844/112948205-5bf0ca00-916a-11eb-900a-6ec582ac651d.png)





