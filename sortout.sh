#!/bin/bash

#set -x

#获取当前脚本目录copy脚本之家
Source="$0"
while [[ -h "$Source"  ]]; do
    dir_file="$( cd -P "$( dirname "$Source"  )" && pwd  )"
    Source="$(readlink "$Source")"
    [[ $Source != /*  ]] && Source="$dir_file/$Source"
done
dir_file="$( cd -P "$( dirname "$Source"  )" && pwd  )"

anime_file="$dir_file/动漫"
movie_file="$dir_file/电影"

#颜色调整参考wen55333
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
white="\033[0m"

movie() {
	sudo chmod -R 777 $movie_file
	ls $movie_file  | grep -E "flv|mkv|mp4" >/tmp/movie_name.log
	movie_num=$(cat /tmp/movie_name.log | wc -l)

	#整理电影名字，然后创建文件夹
	while [[ "$movie_num" -gt 0 ]];do
		movie_name=$(cat /tmp/movie_name.log | awk -v a="$movie_num" 'NR==a{print $0}')
		echo $movie_name >/tmp/movie_name_sort.log

		for i in `cat $dir_file/config/filter.txt`
		do
			sed -i "s/$i//g" /tmp/movie_name_sort.log 
		done
	
		movie_name_sort=$(cat /tmp/movie_name_sort.log | sed "s/^[[ \t]]*//g" | sed "s/ //g")
		movie_name_mk=$(echo  $movie_name_sort | awk -F "." '{print $1}' )
		
		echo -e "将旧文件$yellow $movie_name$white 重命名为 $green$movie_name_sort$white"
		mv "$movie_file/$movie_name" "$movie_file/$movie_name_sort"
		mkdir $movie_file/$movie_name_mk
		sudo chmod -R 777 $movie_file
		mv $movie_file/$movie_name_sort $movie_file/$movie_name_mk
		movie_num=$(expr $movie_num - 1)
	done
	
	#整理一下已经有的文件夹
	ls $movie_file >/tmp/movie_file_name.log
	movie_file_num=$(cat /tmp/movie_file_name.log | wc -l)
	if [[ "$movie_file_num" == "0" ]];then
		echo -e "$green 电影文件夹空空如也，你在逗我。。。。$white"
		exit 0
	fi

	while [[ "$movie_file_num" -gt 0 ]];do
		movie_file_name=$(cat /tmp/movie_file_name.log | awk -v a="$movie_file_num" 'NR==a{print $0}')
		echo $movie_file_name >/tmp/movie_file_name_sort.log
		 
		for i in `cat $dir_file/config/filter.txt`
		do
			sed -i "s/$i//g" /tmp/movie_file_name_sort.log 
		done
	
		movie_file_name_sort=$(cat /tmp/movie_file_name_sort.log | sed "s/^[[ \t]]*//g" | sed "s/ //g")
		
		if [[ "$movie_file_name" == "$movie_file_name_sort" ]];then
			echo -e "$yellow【$movie_file_name】$white文件夹一致不更改"
		else
			echo -e "将旧文件夹 $yellow$movie_file_name$white 重命名为 $green$movie_file_name_sort$white"
			mv "$movie_file/$movie_file_name" "$movie_file/$movie_file_name_sort"
			echo ""
		fi
		
		cd $movie_file/$movie_file_name_sort
		ls ./ | grep -v ".torrent" > /tmp/movie_content.log
		movie_content_num=$(cat /tmp/movie_content.log | wc -l)

		while [[ "$movie_content_num" -gt 0 ]];do
			movie_content=$(cat /tmp/movie_content.log | awk -v a="$movie_content_num" 'NR==a{print $0}')
			echo $movie_content >/tmp/movie_content_sort.log

			for i in `cat $dir_file/config/filter.txt`
			do
				sed -i "s/$i//g" /tmp/movie_content_sort.log 
			done
			
			movie_content_sort=$(cat /tmp/movie_content_sort.log | sed "s/^[[ \t]]*//g" | sed "s/ //g")
		
			if [[ "$movie_content" == "$movie_content_sort" ]];then
				echo -e "$yellow【$movie_content】$white文件名一致不更改"
			else
				echo -e "将旧文件名 $white$movie_content$white 重命名为 $green$movie_content_sort$white"
				mv "$movie_file/$movie_file_name_sort/$movie_content" "$movie_file/$movie_file_name_sort/$movie_content_sort"
				echo ""
			fi
			
			nfo_if=$(ls $movie_file/$movie_file_name_sort | grep ".nfo")
			if [[ ! $nfo_if ]];then
				echo "没有nfo文件跳过"
			else
				
				sudo sed -i "s/$movie_content/$movie_content_sort/g" $movie_file/$movie_file_name_sort/$nfo_if
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
		if [[ ! $movie_name  ]];then
			rm -rf $movie_file/$i
		else
			mv $movie_name $movie_file
			rm -rf $movie_file/$i
		fi
		
	done
}

anime() {
	sudo chmod -R 777 $anime_file
	#获取当前文件夹有多少动漫目录
	ls $anime_file | grep -v "flv$" >/tmp/anime_name.log
	ls $anime_file | grep -v "flv$" >/tmp/old_anime_name.log
	anime_num=$(cat /tmp/anime_name.log | wc -l)
	old_anime_num=$(cat /tmp/old_anime_name.log | wc -l)

	if [[ "$anime_num" == "0" ]];then
		echo -e "$green 动漫文件夹空空如也，你在逗我。。。。$white"
		exit 0
	fi


	#开始重命名文件夹（解决空格问题）
	for i in `cat $dir_file/config/filter.txt`
	do
		sed -i "s/$i//g" /tmp/anime_name.log
	done
	sed -i "s/^[[ \t]]*//g" /tmp/anime_name.log
	sed -i "s/ //g" /tmp/anime_name.log

	while [[ "$old_anime_num" -gt 0 ]];do
		anime_name=$(cat /tmp/anime_name.log | awk -v a="$old_anime_num" 'NR==a{print $0}')
		old_anime_name=$(cat /tmp/old_anime_name.log | awk -v a="$old_anime_num" 'NR==a{print $0}')

		if [[ "$old_anime_name" == "$anime_name" ]];then
			echo "$anime_name 一样，不做改变"
		else
			mv $anime_file/"$old_anime_name" $anime_file/"$anime_name"
		fi

		old_anime_num=$(expr $old_anime_num - 1)
	done

	num="1"
	while [[ `expr $anime_num + 1` -gt "$num" ]];do
		anime_name=$(cat /tmp/anime_name.log | awk -v a="$num" 'NR==a{print $0}')
		cd $anime_file/"$anime_name"
		ls ./ | grep -v "torrent" >/tmp/anime_seasons.log
		anime_seasons_num=$(cat /tmp/anime_seasons.log | grep -E "S00|S01|S02|S03|S04|S05|S06|S07|S08|S09|S10"| wc -l)
		if [[ "$anime_seasons_num" == "0" ]];then
			echo -e "$yellow 【$anime_name】$green文件夹,没有分几季，暂停脚本$white"
			exit 0
		fi
			for anime_seasons in `cat /tmp/anime_seasons.log`
			do
				cd $anime_seasons
				ls ./ >/tmp/anime_content.log
				anime_content_num=$(cat /tmp/anime_content.log | wc -l)
				num1="1"
				echo -e "$green[$anime_name $anime_seasons]$white"
				while [[ `expr $anime_content_num + 1` -gt "$num1" ]];do
					cat /tmp/anime_content.log | awk -v a="$num1" 'NR==a{print $0}' > /tmp/anime_content_sort.log
					cat /tmp/anime_content.log | awk -v a="$num1" 'NR==a{print $0}' > /tmp/old_anime_content_sort.log

					sed -i "s/^[[ \t]]*//g" /tmp/anime_content_sort.log
					sed -i "s/ //g" /tmp/anime_content_sort.log
					filter_num=$(cat $dir_file/config/filter.txt | wc -l)
					while [[ $filter_num -gt 0 ]];do
						filter_content=$(cat $dir_file/config/filter.txt | awk -v a="$filter_num" 'NR==a{print $0}')
						sed -i "s/$filter_content//g" /tmp/anime_content_sort.log
						filter_num=$(expr $filter_num - 1)
					done

					anime_content_sort=$(cat /tmp/anime_content_sort.log)
					old_anime_content_sort=$(cat /tmp/old_anime_content_sort.log)

					if [[ "$old_anime_content_sort" == "$anime_content_sort" ]];then
						echo ""
					else
						mv "$old_anime_content_sort" "$anime_content_sort"
					fi

					E="E"
					anime_content=$(cat /tmp/anime_content_sort.log)
					anime_content_if=$(echo "$anime_content" | grep "$anime_name" | wc -l )
					anime_content_if2=$(echo "$anime_content" | grep "$anime_name$anime_seasons$E" | wc -l )

					if [[ "$anime_content_if" -ge "1" ]];then
						if [[ "$anime_content_if2" -ge "1" ]];then
							anime_content_sort=$(cat /tmp/anime_content_sort.log)
							echo -e "$yellow【$anime_content_sort】$white 已经修改过，不再操作"
							num1=$(expr $num1 + 1)
						else
							anime_content_sort=$(cat /tmp/anime_content_sort.log | sed "s/$anime_name/$anime_name$anime_seasons$E/")
							echo -e "开始将旧文件$yellow$anime_content$white 重命名为 $green$anime_content_sort$white"
							mv "$anime_content" "$anime_content_sort"
							num1=$(expr $num1 + 1)
						fi
					else
							anime_content_sort=$(cat /tmp/anime_content_sort.log | sed "s/^/$anime_name$anime_seasons$E/")
							echo -e "开始将旧文件$yellow$anime_content$white 重命名为 $green$anime_content_sort$white"
							mv "$anime_content" "$anime_content_sort"
							num1=$(expr $num1 + 1)
					fi
				done
				echo ""
				cd $anime_file/"$anime_name"
			done
			num=$(expr $num + 1)
			echo ""
			cd $anime_file/"$anime_name"
	done

}


help() {
	echo "---------------------------------------------------------------------".
	echo "			     SortOut"
	echo "命令如下"
	echo ""
	echo -e  "$green bash \$sortout movie$white         整理电影"
	echo ""
	echo -e  "$green bash \$sortout movie_out$white     把电影从文件夹里面拿出来"
	echo ""
	echo -e  "$green bash \$sortout anime$white         整理动漫"
	echo ""
	echo "				By:ITdesk"
	echo "---------------------------------------------------------------------"

}

system_variable() {
	clear
	#添加系统变量
	sortout_path=$(cat /etc/profile | grep -o sortout.sh | wc -l)
	sortout_file_path=$(cat /etc/profile | grep -o sortout_file | wc -l)
	if [[ "$sortout_file_path" == "0" ]]; then
		echo "开始添加系统变量"
		echo "export sortout_file=$dir_file" | sudo tee -a /etc/profile
		source /etc/profile
		echo "建议重启系统以生效"
	elif [[ "$sortout_path" == "0" ]]; then
		echo "export sortout=$dir_file/sortout.sh" | sudo tee -a /etc/profile
		source /etc/profile
	else
		echo "系统变量已经添加"
	fi


	if [[ ! -d "$dir_file/电影" ]]; then
		mkdir  $dir_file/电影
	fi

	if [[ ! -d "$dir_file/动漫" ]]; then
		mkdir  $dir_file/动漫
	fi

	config_file="$dir_file/config/sortout_config.txt"
	filter_file=$(grep "filter_file" $config_file | awk -F "'" '{print $2}')
	synology_user=$(grep "synology_user" $config_file | awk -F "'" '{print $2}')
	synology_passwd=$(grep "synology_passwd" $config_file | awk -F "'" '{print $2}')
	synology_ip=$(grep "synology_ip" $config_file | awk -F "'" '{print $2}')
	synology_movie_file=$(grep "synology_movie_file" $config_file | awk -F "'" '{print $2}')
	synology_anime_file=$(grep "synology_anime_file" $config_file | awk -F "'" '{print $2}')
	
	if [[ "$action1" == "umount_file" ]];then
		$action1
	else
		if [[ `echo $synology_ip | wc -l ` == "1" ]];then
			mount_file
			clear
		fi
	fi
}

mount_file() {
	#检测是否挂载
	mount_movie_file_if=$(mount | grep "$movie_file" | wc -l)
	mount_anime_file_if=$(mount | grep "$anime_file" | wc -l)

	if [[ ! $synology_user ]];then
		echo "用户名：为空"
		exit 0
	fi

	if [[ ! $synology_passwd ]];then
		echo "密码：为空"
		exit 0
	fi

	if [[ ! $synology_movie_file ]];then
		echo "群晖电影目录：为空"
		exit 0
	fi

	if [[ ! $synology_anime_file ]];then
		echo "群晖动漫目录：为空"
		exit 0
	fi

	if [[ $mount_movie_file_if == "1" ]];then
		echo ""
		echo "群晖movie文件已经挂载"
	else
		echo "开始挂载群晖movie文件到$movie_file"
		sudo mount -t cifs -o username=$synology_user,password=$synology_passwd,vers=1.0 //$synology_ip/$synology_movie_file $movie_file
		sudo chmod -R 777 $movie_file
	fi
	
	if [[ $mount_anime_file_if == "1" ]];then
		echo ""
		echo "群晖anime文件已经挂载"
	else
		echo "开始挂载群晖anime文件到$anime_file"
		sudo mount -t cifs -o username=$synology_user,password=$synology_passwd,vers=1.0 //$synology_ip/$synology_anime_file $anime_file
		sudo chmod -R 777 $anime_file
	fi
	echo "挂载结束，如果没有报错就是成功了，如果失败请检查你的目录文件是否正确"
}

umount_file() {
	echo ">> 开始卸载挂载的群晖文件"
	echo "开始卸载群晖movie文件夹"
	sudo umount $movie_file && sleep 2
	echo "开始卸载群晖anime文件夹"
	sudo umount $anime_file && sleep 2
	echo "卸载结束"
}


system_variable
action1="$1"
action2="$2"
if [[ -z $action1 ]]; then
	help
else
	case "$action1" in
		movie|movie_out|anime|umount_file)
		$action1
		;;
		*)
		help
		;;
	esac

	if [[ -z $action2 ]]; then
		echo ""
	else
		case "$action2" in
			movie|movie_out|anime|umount_file)
			$action2
			;;
			*)
			help
			;;
		esac
	fi
fi
