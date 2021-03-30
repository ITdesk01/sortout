# sourtout
用于电影或者动漫重命名，方便刮削

## 测试平台

**群辉**

## 使用办法
```
1.先把sortout.sh下载到你的目录，坑爹的群辉wget
2.cd 过去，然后执行sh sortout.sh，生成filter.txt（过滤文本） 动漫 电影（文件夹）
3.然后把电影和动漫按文件目录分类
4.管理员执行sh sortout.sh sys_variable (加上变量以后，重启nas)
5.sh $sortout 查看命令使用
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


**执行代码**
```      
      sh $sortout movie
```
**整理后**

![image](https://user-images.githubusercontent.com/38835844/112928827-e117b700-9149-11eb-9d75-5535dec81edb.png)


![image](https://user-images.githubusercontent.com/38835844/112928790-d2c99b00-9149-11eb-807a-5d26d3db6384.png)



