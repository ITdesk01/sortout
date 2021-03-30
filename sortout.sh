#!/bin/sh

#set -x

#获取当前脚本目录copy脚本之家
Source="$0"
while [ -h "$Source"  ]; do
    dir_file="$( cd -P "$( dirname "$Source"  )" && pwd  )"
    Source="$(readlink "$Source")"
    [[ $Source != /*  ]] && Source="$dir_file/$Source"
done
dir_file="$( cd -P "$( dirname "$Source"  )" && pwd  )"
anime_file="$dir_file/动漫"
movie_file="$dir_file/电影"

filter() {
cat > /$dir_file/filter.txt<<EOF
_电影_bilibili_哔哩哔哩
-正片
-粤语版
-原版
-普通话版
【更多高清电影访问 www.BBQDDQ.com】
梦幻天堂·龙网(www.LWgod.org).1080p.
追光寻影 (www.zgxyi.com)
【WEBRIP_1080P】
【桜都】 - 完结番组 - 吐槽弹幕网 - tucao.one_
【BDRIP_1080P】
tucao.one
EOF
}

movie() {
	ls $movie_file  | grep -E "flv|mkv|mp4" >/tmp/movie_name.log
	movie_num=$(cat /tmp/movie_name.log | wc -l)

	#整理电影名字，然后创建文件夹
	while [ "$movie_num" -gt 0 ];do
		movie_name=$(cat /tmp/movie_name.log | awk -v a="$movie_num" 'NR==a{print $0}')
		echo $movie_name >/tmp/movie_name_sort.log

		for i in `cat $dir_file/filter.txt`
		do
			sed -i "s/$i//g" /tmp/movie_name_sort.log 
		done
	
		movie_name_sort=$(cat /tmp/movie_name_sort.log | sed "s/^[ \t]*//g" | sed "s/ //g")
		movie_name_mk=$(echo  $movie_name_sort | awk -F "." '{print $1}' )
		
		echo "将旧文件 $movie_name 重命名为 $movie_name_sort"
		mv "$movie_file/$movie_name" "$movie_file/$movie_name_sort"
		mkdir $movie_file/$movie_name_mk
		mv $movie_file/$movie_name_sort $movie_file/$movie_name_mk
		movie_num=$(expr $movie_num - 1)
	done
	
	#整理一下已经有的文件夹
	ls $movie_file >/tmp/movie_file_name.log
	movie_file_num=$(cat /tmp/movie_file_name.log | wc -l)

	while [ "$movie_file_num" -gt 0 ];do
		movie_file_name=$(cat /tmp/movie_file_name.log | awk -v a="$movie_file_num" 'NR==a{print $0}')
		echo $movie_file_name >/tmp/movie_file_name_sort.log
		 
		for i in `cat $dir_file/filter.txt`
		do
			sed -i "s/$i//g" /tmp/movie_file_name_sort.log 
		done
	
		movie_file_name_sort=$(cat /tmp/movie_file_name_sort.log | sed "s/^[ \t]*//g" | sed "s/ //g")
		
		if [ "$movie_file_name" == "$movie_file_name_sort" ];then
			echo "文件夹一致不更改"
		else
			echo "将旧文件夹 $movie_file_name 重命名为 $movie_file_name_sort"
			mv "$movie_file/$movie_file_name" "$movie_file/$movie_file_name_sort"
			echo ""
		fi
		
		cd $movie_file/$movie_file_name_sort
		ls ./ | grep -v ".torrent" > /tmp/movie_content.log
		movie_content_num=$(cat /tmp/movie_content.log | wc -l)

		while [ "$movie_content_num" -gt 0 ];do
			movie_content=$(cat /tmp/movie_content.log | awk -v a="$movie_content_num" 'NR==a{print $0}')
			echo $movie_content >/tmp/movie_content_sort.log

			for i in `cat $dir_file/filter.txt`
			do
				sed -i "s/$i//g" /tmp/movie_content_sort.log 
			done
			
			movie_content_sort=$(cat /tmp/movie_content_sort.log | sed "s/^[ \t]*//g" | sed "s/ //g")
		
			if [ "$movie_content" == "$movie_content_sort" ];then
				echo "文件名一致不更改"
			else
				echo "将旧文件名 $movie_content 重命名为 $movie_content_sort"
				mv "$movie_file/$movie_file_name_sort/$movie_content" "$movie_file/$movie_file_name_sort/$movie_content_sort"
				echo ""
			fi
			
			nfo_if=$(ls $movie_file/$movie_file_name_sort | grep ".nfo")
			if [ ! $nfo_if ];then
				echo "没有nfo文件跳过"
			else
				
				sed -i "s/$movie_content/$movie_content_sort/g" $movie_file/$movie_file_name_sort/$nfo_if
			fi
			movie_content_num=$(expr $movie_content_num - 1)
		done
		movie_file_num=$(expr $movie_file_num - 1)
		cd $movie_file
	done

	
	
}

movie_out() {
	cd $movie_file
	for i in `ls ./ | grep -v ".flv"`
	do
		cd $movie_file/$i
		movie_name=$(ls ./)
		if [ ! $movie_name  ];then
			rm -rf $movie_file/$i
		else
			mv $movie_name $movie_file
			rm -rf $movie_file/$i
		fi
		
	done
}

anime() {
	cd $anime_file
	#获取当前文件夹有多少动漫目录
	ls $anime_file | grep -v "flv$" >/tmp/anime_name.log

	for anime_name in `cat /tmp/anime_name.log`
	do
		cd $anime_file/$anime_name
		ls ./ >/tmp/anime_seasons.log
			for anime_seasons in `cat /tmp/anime_seasons.log`
			do
				cd $anime_seasons
				ls ./ >/tmp/anime_content.log
				anime_content_num=$(cat /tmp/anime_content.log | wc -l)
				while [ "$anime_content_num" -gt 0 ];do
					anime_content=$(cat /tmp/anime_content.log | awk -v a="$anime_content_num" 'NR==a{print $0}')
					echo $anime_content > /tmp/anime_content_sort.log
					for i in `cat $dir_file/filter.txt`
					do
						sed -i "s/$i//g" /tmp/anime_content_sort.log 
					done

					E="E"
					anime_content_if=$(echo "$anime_content" | grep "$anime_name" | wc -l )
					anime_content_if2=$(echo "$anime_content" | grep "$anime_name $anime_seasons$E" | wc -l )

					if [ "$anime_content_if" -ge "1" ];then
						if [ "$anime_content_if2" -ge "1" ];then
							echo "已经修改过，不再操作"
							anime_content_num=$(expr $anime_content_num - 1)
						else
							anime_content_sort=$(cat /tmp/anime_content_sort.log  | sed "s/^[ \t]*//g" | sed "s/ //g" | sed "s/$anime_name/$anime_name $anime_seasons$E/")
							echo "开始将旧文件$anime_content 重命名为 $anime_content_sort"
							mv "$anime_content" "$anime_content_sort"
							anime_content_num=$(expr $anime_content_num - 1)
						fi
					else
							anime_content_sort=$(cat /tmp/anime_content_sort.log  | sed "s/^[ \t]*//g" | sed "s/ //g" | sed "s/^/$anime_name $anime_seasons$E/")
							echo "开始将旧文件$anime_content 重命名为 $anime_content_sort"
							mv "$anime_content" "$anime_content_sort"
							anime_content_num=$(expr $anime_content_num - 1)
					fi
				done
				cd ..
			done
			cd $anime_file/$anime_name
	done

}

anime_del_nfo() {
	
	echo ""
}

sys_variable() {
	#添加系统变量
	read -p "你要添加系统变量还是删除(1.添加 2.删除) ：" sys_variable_num
	echo "开始检测是否存在之前的变量"
	sleep 2
	sortout_path=$(cat /etc/profile | grep -o sortout.sh | wc -l)
	
	if [ "$sys_variable_num" == "1" ]; then
		if [ $sortout_path -gt "1"  ];then
			echo "检测到已经存在变量，请删除以后再重新添加"
		else
			echo "export sortout_file=$dir_file" >> /etc/profile
			echo "export sortout=$dir_file/sortout.sh" >> /etc/profile
			echo "添加完成，重启以后生效"
		fi
	elif [ "$sys_variable_num" == "2" ];then
		echo "开始删除之前的变量"
		sed -i "/sortout/d" /etc/profile
		echo "删除完成"	
	fi
}




help() {
	echo "---------------------------------------------------------------------".
	echo "sortout.sh命令如下"
	echo ""
	echo " sh \$sortout movie         整理电影"
	echo " sh \$sortout movie_out     把电影拿出来"
	echo " sh \$sortout anime         整理动漫"
	echo " sh \$sortout sys_variable  添加系统变量"
	echo ""
	echo "PS： 如果sh \$sortout没有反应，建议先添加系统变量（要用管理员权限）"
	echo ""
	echo "				By:ITdesk"
	echo "---------------------------------------------------------------------"

}

system_variable() {
	if [ ! -d "$dir_file/电影" ]; then
		mkdir  $dir_file/电影
	fi

	if [ ! -d "$dir_file/动漫" ]; then
		mkdir  $dir_file/动漫
	fi

	if [ ! -f "$dir_file/filter.txt" ]; then
		filter
	fi

}

system_variable
action1="$1"
action2="$2"
if [ -z $action1 ]; then
	help
else
	case "$action1" in
		movie|movie_out|anime|sys_variable)
		$action1
		;;
		*)
		help
		;;
	esac

	if [ -z $action2 ]; then
		echo ""
	else
		case "$action2" in
			movie|movie_out|anime|sys_variable)
			$action2
			;;
			*)
			help
			;;
		esac
	fi
fi
