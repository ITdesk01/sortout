#!/bin/bash

#set -x

mulu="动漫/大王不高兴/S02/"
del_name="大王不高兴 S02E"

#获取当前脚本目录copy脚本之家
Source="$0"
while [[ -h "$Source"  ]]; do
    dir_file="$( cd -P "$( dirname "$Source"  )" && pwd  )"
    Source="$(readlink "$Source")"
    [[ $Source != /*  ]] && Source="$dir_file/$Source"
done
dir_file="$( cd -P "$( dirname "$Source"  )" && pwd  )"


ls $dir_file/$mulu | grep -v ".sh" > /tmp/old.txt
ls $dir_file/$mulu | grep -v ".sh" > /tmp/new.txt
sed -i "s/$del_name//g" /tmp/new.txt

old_num=$(cat /tmp/old.txt | wc -l)
new_num=$(cat /tmp/new.txt | wc -l)

num="1"

while [[ `expr $new_num + 1 ` -gt "$num"  ]];do
		
		for i in `cat /tmp/new.txt`
		do
			old_name=$(cat /tmp/old.txt | awk -v a="$num" 'NR==a{print $0}')
			echo "	【$old_name】 重命名 $i"
			mv "$dir_file/$mulu$old_name" "$dir_file/$mulu$i"
			num=$(expr $num + 1)
		done	
done

echo "替换完成"
