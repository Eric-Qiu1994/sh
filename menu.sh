#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Script_version="2.7bate"
HTTP="eblog.ink"
Blue_2="\033[34m"
Font="\033[0m"
Red="\033[31m" 
Blue="\033[36m"
Blue_Info="${Blue}[信息]${Font}"
Red_Info="${Red}[注意]${Font}"

#更新系统
Check_ver_update(){
	if [[ "${release}" == "centos" ]]; then
		yum -y update
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		apt-get -y update
	fi
	echo -e "${Blue_2}系统更新完成！！${Font}"
	sleep 2s
	echo -e "${Blue_2}正在返回主菜单...${Font}"	
	sleep 2s
	main
}


#开启远程ssh链接
ssh_alter(){
	CON1="PermitRootLogin yes"
	CON2="PasswordAuthentication yes"
	if [[ "${release}" == "centos" ]]; then
		yum -y install openssh-server
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		apt-get -y install openssh-server
	fi
	sed -i "38c${CON1}" /etc/ssh/sshd_config
	sed -i "63c${CON2}" /etc/ssh/sshd_config
	echo -e "Please Input Your passwd："
	passwd root
	service sshd restart
	/etc/init.d/ssh restart
	echo -e "${Blue_2}已成功开启ssh！！${Font}"
	sleep 2s
	echo -e "${Blue_2}正在返回主菜单...${Font}"
	sleep 2s
	main
}




#开始菜单
main(){
root_need
check_sys
set_management
clear
echo
echo -e " Welcome Linux 便捷管理菜单 ${Red}[v${Script_version}]${Font}"
echo -e "    -- 不喜勿喷 | Eblog.ink --"
echo
echo -e "${Blue_2}    0.${Font} 脚本升级" 
echo
echo -e "——————————系统管理——————————————"
echo
echo -e "${Blue_2}    1.${Font} 系统  更新"
echo -e "${Blue_2}    2.${Font} 开启  SSH"
echo -e "${Blue_2}    3.${Font} 内核  更新"
echo -e "${Blue_2}    4.${Font} 设置  Swap"
echo -e "${Blue_2}    5.${Font} 用户  管理"
echo -e "${Blue_2}    6.${Font} 查看系统信息"
echo
echo -e "——————————软件类别——————————————"
echo
echo -e "${Blue_2}    7.${Font} 安装第三方"
echo -e "${Blue_2}    8.${Font} Docker管理"
echo -e "${Blue_2}    9.${Font} 常用工具些"
echo -e "${Blue_2}   10.${Font} 安装  软件"
echo -e "${Blue_2}   11.${Font} 退出  脚本"
echo
echo -e "—————————————底线———————————————"
echo
read -p "请输入数字 [0-11]:" num
case "$num" in
		0)Update_Shell
		;;
		1)Check_ver_update
		;;
		2)ssh_alter
		;;
		3)kernel_update
		;;
		4)set_swap
		;;
		5)user_management
		;;
		6)check_sys_information
		;;
		7)install_third_party
		;;
		8)docker_menu
		;;
		9)some_tools
		;;
		10)install_software
		;;
		11)exit
		;;
		*)
		clear
		echo -e "${Blue_2}请输入正确数字 [0-11]${Font}"
		sleep 2s
		main
		;;
		esac
}

#安装第三方
install_third_party(){
clear
echo && echo -e "${Blue_2}你想安装那个软件？${Font}

${Blue_2} 1. ${Font}调用TCP一键加速脚本
——————————————
${Blue_2} 2. ${Font}调用系统一键测试脚本
${Blue_2} 3. ${Font}安装带Web页面的nps(服务端)
——————————————
${Blue_2} 4. ${Font}安装常用软件
${Blue_2} 5. ${Font}安装指定软件
${Blue_2} 6. ${Font}卸载指定软件
${Blue_2} 7. ${Font}查找安装软件
——————————————
${Blue_2} 8. ${Font}返回主菜单
——————————————"&& echo 

echo -e "请输入数字【0-8】："
read num10
case "${num10}" in 
	1)call_tcp
	;;
	2)call_Test
	;;
	3)install_nps_server
	;;
	4)
	;;
	5)
	;;
	6)
	;;
	7)
	;;
	8)main
	;;
	*)
	clear
	echo -e "${Red_Info}请输入正确的数字【0-8】："
	sleep 2s
	install_third_party
	;;
	esac
}

#调用系统一键测试脚本
call_Test(){
wget -qO- bench.sh | bash
sleep 5s
main
}

#调用TCP一键加速脚本
call_tcp(){
wget https://eblog.ink/sh/tcp.sh && chmod +x tcp.sh && bash tcp.sh
}

#安装软件
install_software(){
clear
echo && echo -e " ${Red}你想要进行哪个操作？${Font}

${Blue_2} 1. ${Font}安装tree
——————————————
${Blue_2} 2. ${Font}安装网络iproute2
${Blue_2} 3. ${Font}安装网络net-tools
——————————————
${Blue_2} 4. ${Font}安装常用软件
${Blue_2} 5. ${Font}安装指定软件
${Blue_2} 6. ${Font}卸载指定软件
${Blue_2} 7. ${Font}查找安装软件
——————————————
${Blue_2} 8. ${Font}返回主菜单
——————————————" && echo

read -p "请输入数字 [0-6]:" num9
case "${num9}" in
	1)install_tree
	;;
	2)install_iproute2
	;;
	3)install_net-tools
	;;
	4)install_in_common_use_software
	;;
	5)install_assign_software
	;;
	6)uninstall_assign_software
	;;
	7)find_assign_software
	;;
	8)main
	;;
	*)
	echo -e "${Blue_Info}请输入正确的数字[1-6]："
	sleep 2s
	install_software
	;;
	esac
}

#安装常用软件
install_in_common_use_software(){
	if [[ "${release}" == "centos" ]]; then
		yum -y install wget vim unzip zip initscripts lrzsz
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		apt-get -y install wget vim unzip zip lrzsz
		apt-get -y install apt-transport-https ca-certificates curl software-properties-common  
	fi
	echo -e "${Blue_2}安装完成！！${Font}"
	sleep 2s
	echo -e "${Blue_2}正在返回主菜单...${Font}"	
	sleep 2s
	main
}

#查找安装软件
find_assign_software(){
if [[ "${release}" == "centos" ]]; then
	echo -e "${Blue_Info}请输入需要安装的软件名："
	read need_find_software
	temp16=`rpm -qa | grep ${need_find_software}`
	if [[ "${temp16}" =~ "${need_find_software}" ]] ; then
		rpm -qa | grep ${need_find_software}
		echo -e "${Blue_2}输入x返回主菜单，输入y返回当前菜单，输入z继续查找，输入其他任意键退出:${Font}" 
		read xyz
		[[ -z "${xyz}" ]] && xyz="y" 
		if [[ $xyz == [Xx] ]]; then
			echo -e "${Green}进入主菜单....${Font}"
			sleep 3s
			main
		elif [[ $xyz == [Yy] ]]; then
			echo -e "${Green}正在返回当前菜单....${Font}"
			sleep 3s
			install_software
		elif [[ $xyz == [Zz] ]]; then
			find_assign_software
		fi
	else
		echo -e "${Red_Info}系统中没有该软件！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	echo -e "${Blue_Info}请输入需要安装的软件名："
	read need_find_software
	temp16=`dpkg -l | grep ${need_find_software}`
	if [[ "${temp16}" =~ "${need_find_software}" ]] ; then
		dpkg -l | grep ${need_find_software}
		echo -e "${Blue_2}输入x返回主菜单，输入y返回当前菜单，输入z继续查找，输入其他任意键退出:${Font}" 
		read xyz
		[[ -z "${xyz}" ]] && xyz="y" 
		if [[ $xyz == [Xx] ]]; then
			echo -e "${Green}进入主菜单....${Font}"
			sleep 3s
			main
		elif [[ $xyz == [Yy] ]]; then
			echo -e "${Green}正在返回当前菜单....${Font}"
			sleep 3s
			install_software
		elif [[ $xyz == [Zz] ]]; then
			find_assign_software
		fi
	else
		echo -e "${Red_Info}系统中没有该软件！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
fi
}

#安装指定软件
install_assign_software(){
if [[ "${release}" == "centos" ]]; then
	echo -e "${Blue_Info}请输入需要安装的软件名："
	read need_install_software
	temp16=`rpm -qa | grep ${need_install_software}`
	if [[ "${temp16}" =~ "${need_install_software}" ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		yum -y install ${need_install_software}
		echo -e "${Blue_Info}安装${need_install_software}完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	echo -e "${Blue_Info}请输入需要安装的软件名："
	read need_install_software
	temp16=`dpkg -l | grep ${need_install_software}`
	if [[ "${temp16}" =~ "${need_install_software}" ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		apt-get -y install ${need_install_software}
		echo -e "${Blue_Info}安装${need_install_software}完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
fi
}

#卸载指定软件
uninstall_assign_software(){
if [[ "${release}" == "centos" ]]; then
	echo -e "${Blue_Info}请输入需要卸载的软件名："
	read need_uninstall_software
	temp17=`rpm -qa | grep ${need_uninstall_software}`
	if [[ "${temp17}" =~ "${need_uninstall_software}" ]] ; then
		yum -y remove *${need_uninstall_software}*
		echo -e "${Blue_Info}卸载${need_uninstall_software}完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		echo -e "${Red_Info}系统没有安装了该软件！！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	echo -e "${Blue_Info}请输入需要安装的软件名："
	read need_uninstall_software
	temp17=`dpkg -l | grep ${need_uninstall_software}`
	if [[ "${temp17}" =~ "${need_uninstall_software}" ]] ; then
		apt-get -y purge *${need_uninstall_software}*
		echo -e "${Blue_Info}卸载${need_uninstall_software}完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		echo -e "${Red_Info}系统没有安装了该软件！！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
fi
}

#安装net-tools
install_net-tools(){
if [[ "${release}" == "centos" ]]; then
	temp14=`rpm -qa | grep net-tools`
	if [[ "${temp14}" =~ "net-tools"  ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		yum -y install net-tools
		echo -e "${Blue_Info}安装net-tools完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	temp15=`dpkg -l | grep net-tools`
	if [[ "${temp15}" =~ "net-tools"  ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		apt-get -y install net-tools
		echo -e "${Blue_Info}安装net-tools完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
fi
}

#安装iproute2
install_iproute2(){
if [[ "${release}" == "centos" ]]; then
	temp14=`rpm -qa | grep iproute2`
	if [[ "${temp14}" =~ "iproute2"  ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		yum -y install iproute2
		echo -e "${Blue_Info}安装iproute2完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	temp15=`dpkg -l | grep iproute2`
	if [[ "${temp15}" =~ "iproute2"  ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		apt-get -y install iproute2
		echo -e "${Blue_Info}安装iproute2完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
fi
}

#安装tree
install_tree(){
if [[ "${release}" == "centos" ]]; then
	temp14=`rpm -qa | grep tree`
	if [[ "${temp14}" =~ "tree"  ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		yum -y install tree
		echo -e "${Blue_Info}安装tree完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	temp15=`dpkg -l | grep tree`
	if [[ "${temp15}" =~ "tree"  ]] ; then
		echo -e "${Red_Info}系统中已经安装了该软件.."
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	else
		apt-get -y install tree
		echo -e "${Blue_Info}安装tree完成！"
		sleep 1s
		echo -e "${Blue_Info}正在返回菜单..."
		sleep 2s
		install_software
	fi
fi
}

#用户管理
user_management(){
clear
echo && echo -e "${Red}你要做什么？${Font}

${Blue_2}1. ${Font}新建    系统用户
${Blue_2}2. ${Font}新建    系统用户组
${Blue_2}3. ${Font}查找添加&&添加用户
————————————
${Blue_2}4. ${Font}查找    指定用户
${Blue_2}5. ${Font}查找    指定用户组
${Blue_2}6. ${Font}删除    指定用户
${Blue_2}7. ${Font}删除    系统用户组
————————————
${Blue_2}8. ${Font}系统用户密码修改
${Blue_2}9. ${Font}指定用户加入用户组
${Blue_2}10.${Font}用户从一个组中移除
————————————
${Blue_2}11.${Font}测试
${Blue_2}12.${Font}返回主菜单
—————————————" && echo

read -p "请输入数字 [1-12]:" num8
case "${num8}" in
	1)system_user_add
	;;
	2)system_add_user_group
	;;
	3)find_add_usr
	;;
	4)find_usr
	;;
	5)find_user_group
	;;
	6)del_usr
	;;
	7)del_system_user_group
	;;
	8)user_passwd_alter
	;;
	9)user_join_group
	;;
	10)move_user_in_group
	;;
	11)test_1
	;;
	12)main
	;;
	*)
	echo -e "${Red_Info}${Blue_2}请输入正确数字[1-12]:${Font}"
	sleep 2s
	user_management
	;;
	esac
}


#测试
test_1(){
read -p "请输入一个测试的值" jkx
echo -e "${jkx}"
echo -e "$jkx"
echo -e ""$jkx""
echo -e ""${jkx}""
}

#删除    系统用户组
del_system_user_group(){
echo -e "${Blue}请输入需要删除的用户组：${Font}"
read need_del_group_name
temp13=`cat /etc/group | cut -f1 -d':' | grep -w "$need_del_group_name" -c`
if [[ $temp13 == 1 ]] ;then
	groupdel ${need_del_group_name}
	echo -e "${Blue_Info}用户组删除完成"
	sleep 2s
	echo -e "${Blue_Info}正在返回用户管理菜单..."
	sleep 2s
	user_management
else
	echo -e "${Red_Info} 系统中不存在该用户组！！"
	sleep 2s
	echo -e "${Blue_Info}正在返回用户管理菜单..."
	sleep 2s
	user_management
fi
}

#新建    系统用户组
system_add_user_group(){
echo -e "${Blue}请输入需要新建的用户组：${Font}"
read new_user_group
temp12=`cat /etc/group | cut -f1 -d':' | grep -w "$new_user_group" -c`
if [[ $temp12 == 0 ]] ;then
	echo -e "${Blue_Info}请输入组标识号："
	read group_id3
	groupadd -g ${group_id3} ${new_user_group}
	echo -e "${Blue_Info}用户组新建完成"
	sleep 2s
	echo -e "${Blue_Info}正在返回用户管理菜单..."
	sleep 2s
	user_management
else
	echo -e "${Red_Info} 系统中已存在该用户组！！"
	sleep 2s
	echo -e "${Blue_Info}正在返回用户管理菜单..."
	sleep 2s
	user_management
fi
}

#新建    系统用户
system_user_add(){
echo -e "${Blue}请输入需要新建的用户：${Font}"
read user_add_name
temp11=`cat /etc/passwd | cut -f1 -d':' | grep -w "$user_add_name" -c`
if [[ $temp11 == 0 ]] ; then
	echo -e "${Blue_Info}请输入用户UID:"
	read user_uid
	useradd -u ${user_uid} -d /home/${user_add_name} ${user_add_name}
	echo -e "${Blue_Info}用户新建完成"
	sleep 2s
	echo -e "${Blue_Info}正在返回用户管理菜单..."
	sleep 2s
	user_management
else
	echo -e "${Red_Info} 系统中已存在该用户名！！"
	sleep 2s
	echo -e "${Blue_Info}正在返回用户管理菜单..."
	sleep 2s
	user_management
fi
}

#用户从一个组中移除
move_user_in_group(){
echo -e "${Blue_Info}请输入需要移除用户组的用户:"
read need_move_user
temp9=`cat /etc/passwd | cut -f1 -d':' | grep -w "$need_move_user" -c`
if [[ $temp9 == 1 ]] ;then
	echo -e "${Blue_Info}请输入需要从哪个组里面移除："
	read need_move_group
	temp10=`cat /etc/group | cut -f1 -d':' | grep -w "$need_move_group" -c`
	if [[ $temp10 == 0 ]] ;then
		echo -e "${Red_Info}系统中没有该用户组存在请核实...."
		sleep 1s
		echo -e "${Blue_Info}正在返回用户管理菜单...."
		sleep 2s
		user_management
	elif [[ $temp10 == 1 ]] ;then
		echo -e "${Blue_Info}正把${need_move_user}从${need_move_group}组中移除"
		gpasswd -d ${need_move_user} ${need_move_group}
		sleep 2s
		echo -e "${Blue_Info}移除完成..."
		sleep 1s
		echo -e "${Blue_Info}正在返回用户管理菜单....."
		sleep 2s
		user_management
	fi
elif [[ $temp9 == 0 ]]; then
	echo -e "${Red_Info}输入的用户在系统中不存在！！"
	sleep 1s
	echo -e "{${Blue_Info}正在返回用户管理菜单.....}"
	sleep 2s
	user_management
fi
}

#指定用户加入用户组
user_join_group(){
echo -e "${Blue_Info}请输入需要加用户组的用户:"
read need_join_group_user
temp7=`cat /etc/passwd | cut -f1 -d':' | grep -w "$need_join_group_user" -c`
if [[ $temp7 == 1 ]] ;then
	echo -e "${Blue_Info}请输入需要加到的用户组："
	read need_join_group
	temp8=`cat /etc/group | cut -f1 -d':' | grep -w "$need_join_group" -c`
	if [[ $temp8 == 1 ]];then
		usermod -G ${need_join_group} ${need_join_group_user}
		echo -e "${Blue_Info}正在把${need_join_group_user}用户加入 ${need_join_group}"
		sleep 1s
		echo -e "${Blue_Info}完成...."
		sleep 1s
		echo -e "${Blue_Info}正在返回用户管理菜单....."
		sleep 2s
		user_management
	else
		echo -e "${Red_Info}用户组不存在,是否添加用户组【Y or N】："
		read YN
		[[ -z "${YN}" ]] &&YN="N"
		if [[ $YN == [Yy] ]] ; then
			echo -e "${Blue_Info}请输入组标识号："
			read group_id2
			groupadd -g ${group_id2} ${need_join_group}
			echo -e "${Blue_Info}用户组创建完成"
			echo -e "${Blue_Info}正在把${need_join_group_user}用户加入 ${need_join_group}"
			usermod -G ${need_join_group} ${need_join_group_user}
			echo -e "${Blue_Info}完成...."
			echo -e "${Blue_Info}正在返回用户管理菜单....."
			sleep 2s
			user_management
		elif [[ $YN == [Nn] ]] ;then
			echo -e "${Red_Info}没有添加用户组！！！"
			echo -e "${Blue_Info}正在返回用户管理菜单...."
			sleep 2s
			user_management
		fi
	fi
elif [[ $temp7 == 0 ]] ;then
	echo -e "${Red_Info}用户不存在...."
	echo -e "${Blue_Info}正在返回用户管理菜单..."
	sleep 2s
	user_management
fi
}

#系统用户密码修改
user_passwd_alter(){
echo -e "${Blue_Info}请输入需要修改的用户:"
read need_alter_user_passwd
temp6=`cat /etc/passwd | cut -f1 -d':' | grep -w "$need_alter_user_passwd" -c`
if [[ $temp6 == 1 ]];then
	passwd ${need_alter_user_passwd}
	echo -e "${Blue_Info}用户 ${need_alter_user_passwd} 密码修改完成"
	sleep 2s
	echo -e "${Blue_Info}正在返回用户管理菜单...."
	sleep 3s
	user_management
else
	echo -e "${Red_Info}用户 ${need_alter_user_passwd} 不在系统中"
	echo -e "${Blue_Info}正在返回用户管理菜单...."
	sleep 2s
	user_management
fi
}

#删除    指定用户
del_usr(){
echo -e "${Blue_Info} 请输入需要删除的用户名："
read need_del_user
temp5=`cat /etc/passwd | cut -f1 -d':' | grep -w "$need_del_user" -c`
if [[ $temp5 == 0 ]] ;then
	echo -e "${Red_Info}输入的用户在系统中不存在..."
	echo -e "${Blue_2}正在返回用户管理菜单....."
	sleep 2s
	user_management
else
	userdel ${need_del_user}
	rm -rf /var/spool/mail/${need_del_user}
	rm -rf /home/${need_del_user}
	echo -e "${Blue_Info}${Blue_2}删除完成,正在返回用户管理菜单.... ${Font}"
	sleep 2s
	user_management
fi
}
#查找    指定用户
find_usr(){
	echo -e "${Blue_Info}请输入需要查找的用户:"
	read usr_name
	temp3=`cat /etc/passwd | cut -f1 -d':' | grep -w "$usr_name" -c`
	if [[ $temp3 == 1 ]];then
		echo -e "${Blue_Info}用户 ${usr_name} 在系统中...."
		echo -e "${Blue_Info}正在返回用户管理菜单...."
		sleep 2s
		user_management
	else
		echo -e "${Red_Info}用户 ${usr_name} 不在系统中"
		echo -e "${Blue_Info}正在返回用户管理菜单...."
		sleep 2s
		user_management
	fi
}

#查找    指定用户组
find_user_group(){
echo -e "${Blue_Info}请输入需要查找的用户组："
read group_name
temp4=`cat /etc/group | cut -f1 -d':' | grep -w "$group_name" -c`
if [[ $temp4 == 1 ]];then
	echo -e "${Blue_Info}用户组 ${group_name} 在系统中...."
	echo -e "${Blue_Info}正在返回用户管理菜单...."
	sleep 2s
	user_management
else
	echo -e "${Red_Info}用户组 ${group_name} 不在系统中"
	echo -e "${Blue_Info}正在返回用户管理菜单...."
	sleep 2s
	user_management
fi
}

#查找添加&&添加用户
find_add_usr(){
	echo -e "${Blue_Info}请输入需要查找的账户:"
	read usr_name
	temp3=`cat /etc/passwd | cut -f1 -d':' | grep -w "$usr_name" -c`
	if [[ $temp3 == 1 ]];then
		echo -e "${Blue_Info}用户 ${usr_name} 在系统中...."
		echo -e "${Blue_Info}正在返回用户管理菜单...."
		sleep 2s
		user_management
	else
		echo -e "${Red_Info}用户 ${usr_name} 不在系统中，是否添加【Y or N】 :"
		read YN
		[[ -z "${YN}" ]] && YN="Y"
		if [[ $YN == [Yy] ]] ; then
			echo -e "${Blue_Info}请输入需要添加到的组别："
			read group_name
			temp4=`cat /etc/group | cut -f1 -d':' | grep -w "$group_name" -c`
			if [[ $temp4 == 1 ]];then
				echo -e "${Blue_Info}请输入用户UID，以继续添加用户："
				read usr_uid
				useradd -u ${usr_uid} -d /home/${usr_name} -g ${group_name} ${usr_name}
				echo -e "${Blue_Info}用户添加完成,正在返回用户管理菜单...."
				sleep 2s
				user_management
			else
				echo -e "${Red_Info}系统中没有该组别，是否添加该组【Y or N】："
				read yn
				[[ -z "${yx}" ]] && yn="y"
				if [[ $yn == [Yy] ]] ;then
					echo -e "${Blue_Info}请输入组标识号："
					read group_id
					groupadd -g ${group_id} ${group_name}
					echo -e "${Blue_Info}用户组已经添加"
					sleep 2s
					echo -e "${Blue_Info}请输入用户UID，以继续添加用户："
					read usr_uid
					useradd -u ${usr_uid} -d /home/${usr_name} -g ${group_name} ${usr_name}
					echo -e "${Blue_Info}用户添加完成,正在返回用户管理菜单...."
					sleep 2s
					user_management
				elif [[ $yn == [Nn] ]] ;then
					echo -e "${Blue_Info}不添加组无法继续，正在返回用户管理菜单...."
					sleep 2s
					user_management
				fi
			fi
		elif [[ $YN == [Nn] ]] ;then
			echo -e "${Blue_Info}不添加用户，正在返回用户管理菜单...."
			sleep 2s
			user_management
		fi
	fi
	
}

#常用工具些
some_tools(){
clear
echo && echo -e "${Blue_2} 你想要做什么？${Font}

${Blue_2}  1. ${Font}文件查找
${Blue_2}  2. ${Font}vim中文乱码解决
${Blue_2}  3. ${Font}修改服务器主机名
——————————————————
${Blue_2}  5. ${Font}脚本权限别名设置
${Blue_2}  4. ${Font}设置Linux中的别名
${Blue_2}  6. ${Font}Centos终端-bash-4.2#
——————————————————
${Blue_2}  7. ${Font}结束指定端口所在的进程
${Blue_2}  8. ${Font}设置系统时间，同步时间
${Blue_2}  9. ${Font}获取Linux kernel版本号
${Blue_2} 10. ${Font}返回主菜单
——————————————————" && echo

read -p "请输入数字 [1-10]:" num7
case "${num7}" in
	1)find_file
	;;
	2)vim_code
	;;
	3)revise_hostname
	;;
	4)set_alias
	;;
	5)Script_permissions_alias
	;;
	6)centos_bash
	;;
	7)kill_port_process
	;;
	8)set_localtime
	;;
	9)Linux_kernel_version
	;;
	10)main
	;;
	*)
	clear
	echo -e "${Blue_2}请输入正确数字 [1-10]${Font}"
	sleep 2s
	some_tools
	;;
	esac
}

#结束指定端口所在的进程
kill_port_process(){
if [[ "${release}" == "centos" ]]; then
	yum -y install net-tools
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	apt-get -y install net-tools
fi
echo -e "${Red_Info}请输入需要结束进程的端口号:"
read port
if [[ "${port}" == "" ]] ; then
	echo -e "${Red_Info} 请输入正确的端口号!!"
	kill_port_process
else
	process_pid=`netstat -anp|grep ${port}|awk '{printf $7}'|cut -d/ -f1`
	if [[ "${process_pid}" == "" ]] ;then
		echo -e "${Red_Info}该端口没有被占用！！"
		echo -e "${Blue_Info}正在返回菜单.."
		sleep 2s
		some_tools
	else
		echo -e "${Red_Info}确定结束该端口所在的进程？？"
		read -p "${Red}Y Or N (默认为N)" yn
		[[ -z "${yn}" ]] && yn="n" 
		if [[ $yn == [Yn] ]]; then
			echo -e "${Red_Info}正在结束进程!!"
			kill -9 ${process_pid}
			echo -e "${Red_Info}已成功结束进程，正在返回！"
			sleep 3s
			main
		elif [[ $yn == [Nn] ]]; then
			echo -e "${Green}正在返回当前菜单....${Font}"
			sleep 3s
			some_tools
		fi
	fi
fi
}

#设置系统时间，并且同步时间
set_localtime(){
if [[ "${release}" == "centos" ]]; then
	yum -y install ntpdate
elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
	apt-get -y install ntpdate
fi
rm -rf /etc/localtime
echo -e "请设置需要设置的时区："
echo -e "${Red_Info}如Asia/Shanghai"
echo -e "${Red_Info}默认为：Asia/Shanghai"
read -p "默认为：Asia/Shanghai" Timezone
echo -e "您设置的时区为${Timezone}"
[[ -z "${Timezone}" ]] && Timezone="Asia/Shanghai"
if [[ "${Timezone}" == "" ]] ; then
	echo -e "请不要设置无效时区"
	set_localtime
else
	ln -s /usr/share/zoneinfo/${Timezone} /etc/localtime
fi
echo -e "正在设置同步时间"
ntpdate us.pool.ntp.org
echo -e "${Blue_Info}设置完成正在返回菜单"
sleep 3s
some_tools
}

#获取Linux kernel版本号
Linux_kernel_version(){
var=`uname -r`
temp_kernel_version="${var:0:6}"
echo -e "${Blue_2}${temp_kernel_version}${Font}"
read -p "输入x返回主菜单，输入y返回本菜单，任意键退出:" xyz
[[ -z "${xyz}" ]] && xyz="y" 
if [[ $xyz == [Xx] ]]; then
	echo -e "${Blue_2}进入主菜单${Font}"
	main
elif [[ $xyz == [Yy] ]]; then
	echo -e "${Blue_2}回到本菜单${Font}"
	some_tools
fi
}

#脚本权限别名设置
Script_permissions_alias(){
#set -i '$a alias o="rm -rf menu.*"' /root/.bashrc
#set -i '$a alias p="chmod 777 menu.sh"' /root/.bashrc
echo "alias o='rm -rf menu.*' " >> /root/.bashrc
echo "alias p='chmod 777 menu.sh' " >> /root/.bashrc
cd /root
source ~/.bashrc
echo -e "${Blue_2}设置完成，正在本菜单"
sleep 2s
some_tools
}

#查找文件
find_file(){
read -p "请输入需要查找的文件名：" file_name
if [[ "${file_name}" == "" ]]; then
	echo -e "${Blue_2}请输入文件名称，不要唬我！！${Font}"
	find_file
else
	find / -name ${file_name}
	echo -e "${Blue_2}只有上面这些了！！${Font}"
fi
read -p "输入x返回主菜单，输入y返回当前菜单，输入z继续查找，输入其他任意键退出:" xyz
[[ -z "${xyz}" ]] && xyz="y" 
if [[ $xyz == [Xx] ]]; then
	echo -e "${Blue_2}进入主菜单....${Font}"
	sleep 3s
	main
elif [[ $xyz == [Yy] ]]; then
	echo -e "${Blue_2}正在返回当前菜单....${Font}"
	sleep 3s
	some_tools
elif [[ $xyz == [Zx] ]]; then
	find_file
fi
}

#解决vim中文乱码问题
vim_code(){
	sed -i  '$a set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936' /etc/vimrc
	sed -i  '$a set termencoding=utf-8' /etc/vimrc
	sed -i  '$a set encoding=utf-8' /etc/vimrc
	
	#echo "set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936" >> /etc/vimrc
	#echo "set termencoding=utf-8" >> /etc/vimrc
	#echo "set encoding=utf-8" >> /etc/vimrc
	
	echo -e "${Blue_2}vimrc更新完成，打开文件测试！！${Font}"
	read -p "输入x返回主菜单，输入y返回当前菜单，输入其他任意键退出:" xyz
	[[ -z "${xyz}" ]] && xyz="y" 
	if [[ $xyz == [Xx] ]]; then
		echo -e "${Blue_2}进入主菜单....${Font}"
		sleep 3s
		main
	elif [[ $xyz == [Yy] ]]; then
		echo -e "${Blue_2}正在返回当前菜单....${Font}"
		sleep 3s
		some_tools
	fi
}

#设置别名
set_alias(){
	if [[ "${release}" == "centos" ]]; then
		read -p "请输入需要设置的别名：" alias1
		read -p "请输入命令行：" cmd1
		if [[ "${alias1}" == "" || "${cmd1}" == "" ]]; then
			echo -e "别名和命令行都不能为空值，请重新输入"
			sleep 2s
			set_alias
		else
			cd /root
			echo "alias ${alias1}='${cmd1}'" >> /root/.bashrc
			source .bashrc
			echo -e "设置完成...."
			read -p "输入x返回主菜单，输入y返回当前菜单，输入z继续设置，其他任意键退出:" xyz
			[[ -z "${xyz}" ]] && xyz="y" 
			if [[ $xyz == [Xx] ]]; then
				echo -e "${Blue_2}进入主菜单....${Font}"
				sleep 3s
				main
			elif [[ $xyz == [Yy] ]]; then
				echo -e "${Blue_2}正在返回当前菜单....${Font}"
				sleep 3s
				some_tools
			elif [[ $xyz == [Zz] ]]; then
				set_alias
			fi
		fi	
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		read -p "请输入需要设置的别名：" alias1
		read -p "请输入命令行：" cmd1
		if [[ "${alias1}" == "" || "${cmd1}" == "" ]]; then
			echo -e "别名和命令行都不能为空值，请重新输入"
			sleep 2s
			set_alias
		else
			cd /root
			echo "alias ${alias1}='${cmd1}'" >> /root/.bash_aliases
			. .bash_aliases
			read -p "输入x返回主菜单，输入y返回当前菜单，输入z继续设置，其他任意键退出:" xyz
			[[ -z "${xyz}" ]] && xyz="y" 
			if [[ $xyz == [Xx] ]]; then
				echo -e "${Blue_2}进入主菜单....${Font}"
				sleep 3s
				main
			elif [[ $xyz == [Yy] ]]; then
				echo -e "${Blue_2}正在返回当前菜单....${Font}"
				sleep 3s
				some_tools
			elif [[ $xyz == [Zz] ]]; then
				set_alias
			fi
		fi
	fi
}



#修改服务器主机名
revise_hostname(){
sed -i '1,$d' /etc/hostname
read -p "请输入你要改为的主机名:" host_name
sed -i '$a ${host_name}' /etc/hostname
read -p "需要重启VPS后，显示才生效，是否现在重启 ? [Y/n] :" yn
[ -z "${yn}" ] && yn="y"
if [[ $yn == [Yy] ]]; then
	echo -e "${Blue_2} VPS 重启中...${Font}"
		reboot
else 
	echo -e "${Blue_2}正在返回菜单...${Font}"	
	sleep 3s
	some_tools
fi
}

#Centos终端-bash-4.2#
centos_bash(){
cp /etc/skel/.bashrc /root/
cp /etc/skel/.bash_profile  /root/
read -p "需要重启VPS后，显示才生效，是否现在重启 ? [Y/n] :" yn
[ -z "${yn}" ] && yn="y"
if [[ $yn == [Yy] ]]; then
	echo -e "${Blue_2} VPS 重启中...${Font}"
		reboot
else 
	echo -e "${Blue_2}正在返回菜单...${Font}"	
	sleep 3s
	some_tools
fi
}


#更新kernel
kernel_update(){
clear
echo && echo -e "${Red}你想做什么?${Font}

${Blue_2}1. ${Font}Centos内核更新
${Blue_2}2. ${Font}Ubuntu内核更新至4.20
——————————————————
${Blue_2}4. ${Font}删除系统多余内核
${Blue_2}5. ${Font}返回主菜单
——————————————————" && echo

read -p "请输入数字【1-5】：" num6
case "${num6}" in
	1)centos_update
	;;
	2)ubuntu_update
	;;
	#3)debian_update
	#;;
	4)detele_kernel
	;;
	5)main
	;;
	*)
	clear
	echo -e "${Blue_2}请输入正确数字 [1-5]${Font}"
	sleep 2s
	kernel_update
	;;
	esac
}


#Ubuntu内核更新至4.20
#https://kernel.ubuntu.com/~kernel-ppa/mainline/
ubuntu_update(){
apt-get -y update
apt-get -y upgrade
wget -c --tries=3 --no-check-certificate https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20/linux-headers-4.20.0-042000-generic_4.20.0-042000.201812232030_amd64.deb
wget -c --tries=3 --no-check-certificate https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20/linux-headers-4.20.0-042000_4.20.0-042000.201812232030_all.deb
wget -c --tries=3 --no-check-certificate https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20/linux-image-4.20.0-042000-generic_4.20.0-042000.201812232030_arm64.deb
dpkg -i *.deb
read -p "需要重启VPS后，才能切换到最新内核，是否现在重启 ? [Y/n] :" yn
[ -z "${yn}" ] && yn="y"
if [[ $yn == [Yy] ]]; then
	echo -e "${Info} VPS 重启中..."
		reboot
else 
	echo -e "${Blue_2}正在返回菜单...${Font}"	
	sleep 3s
	kernel_update
fi
}

#centos内核更新到最新版本
centos_update(){
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
yum --disablerepo="*" --enablerepo="elrepo-kernel" list available
yum -y --enablerepo=elrepo-kernel install kernel-ml
sed -i '1,$d' /etc/default/grub
sed -i '$a GRUB_TIMEOUT=5' /etc/default/grub
sed -i '$a GRUB_DEFAULT=0' /etc/default/grub
sed -i '$a GRUB_DISABLE_SUBMENU=true' /etc/default/grub
sed -i '$a GRUB_TERMINAL_OUTPUT="console"' /etc/default/grub
sed -i '$a GRUB_CMDLINE_LINUX="rd.lvm.lv=centos/root rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet"' /etc/default/grub
sed -i '$a GRUB_DISABLE_RECOVERY="true"' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
read -p "需要重启VPS后，才能切换到最新内核，是否现在重启 ? [Y/n] :" yn
[ -z "${yn}" ] && yn="y"
if [[ $yn == [Yy] ]]; then
	echo -e "${Info} VPS 重启中..."
		reboot
else 
	echo -e "${Blue_2}正在返回菜单...${Font}"	
	sleep 3s
	kernel_update
fi
}

#删除多余内核
detele_kernel(){
	kernel_version=`uname -r`
	if [[ "${release}" == "centos" ]]; then
		rpm_total=`rpm -qa | grep kernel | grep -v "${kernel_version}" | grep -v "noarch" | wc -l`
		if [ "${rpm_total}" > "1" ]; then
			echo -e "检测到 ${rpm_total} 个其余内核，开始卸载..."
			for((integer = 1; integer <= ${rpm_total}; integer++)); do
				rpm_del=`rpm -qa | grep kernel | grep -v "${kernel_version}" | grep -v "noarch" | head -${integer}`
				echo -e "开始卸载 ${rpm_del} 内核..."
				rpm --nodeps -e ${rpm_del}
				echo -e "卸载 ${rpm_del} 内核卸载完成，继续..."
			done
			echo --nodeps -e "内核卸载完毕，继续..."
		else
			echo -e " 检测到 内核 数量不正确，请检查 !" && exit 1
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		deb_total=`dpkg -l | grep linux-image | awk '{print $2}' | grep -v "${kernel_version}" | wc -l`
		if [ "${deb_total}" > "1" ]; then
			echo -e "检测到 ${deb_total} 个其余内核，开始卸载..."
			for((integer = 1; integer <= ${deb_total}; integer++)); do
				deb_del=`dpkg -l|grep linux-image | awk '{print $2}' | grep -v "${kernel_version}" | head -${integer}`
				echo -e "开始卸载 ${deb_del} 内核..."
				apt-get purge -y ${deb_del}
				echo -e "卸载 ${deb_del} 内核卸载完成，继续..."
			done
			echo -e "内核卸载完毕，继续..."
		else
			echo -e " 检测到 内核 数量不正确，请检查 !" && exit 1
		fi
	fi
	echo -e "${Blue_2}正在返回菜单...${Font}"	
	sleep 3s
	kernel_update
}
#判断内核版本脚本
judge_kernel_version(){
var=`uname -r`
temp_kernel_version="${var:0:6}"
if [[ "${temp_kernel_version}" < 3.8 ]] ;then
	echo -e "当前内核小于3.8；请选择内核更新，正在返回主菜单..."
	sleep 2s
	main
fi
}
#Docker管理
docker_menu(){
ovz_no
judge_kernel_version
clear
echo && echo -e "${Blue_2}  你想做什么？${Font}

${Blue_2}  1. ${Font}卸载docker
${Blue_2}  2. ${Font}安装Docker并启动
-————————————
${Blue_2}  3. ${Font}查看运行中的容器
${Blue_2}  4. ${Font}查看已本地的镜像
${Blue_2}  5. ${Font}HUB 镜像仓库操作
${Blue_2}  6. ${Font}网易镜像仓库操作
————————————
${Blue_2}  7. ${Font}删除所有镜像
${Blue_2}  8. ${Font}删除所有容器
${Blue_2}  9. ${Font}删除没运行容器
————————————
${Blue_2}  10.${Font}docker状态管理
${Blue_2}  11.${Font}进入docker容器
${Blue_2}  12.${Font}新建常用的容器
————————————
${Blue_2}  13.${Font}返回主菜单
————————————" && echo

read -p "请输入数字[1-13]:" num2
case "$num2" in
	1)docker_remove
	;;
	2)docker_start
	;;
	3)docker_ps
	;;
	4)docker_images
	;;
	5)docker_hub
	;;
	6)docker_163
	;;
	7)docker_rmi_all
	;;
	8)docker_rm_all
	;;
	9)docker_rm_not_run
	;;
	10)docker_status
	;;
	11)Enter_docker
	;;
	12)crete_docker
	;;
	13)main
	;;
	*)
	clear
	echo -e "${Blue_2}请输入正确数字 [1-13]${Font}"
	sleep 2s
	docker_menu
	;;
	esac
}

#删除所有镜像
docker_rmi_all(){
if [[ "${release}" == "centos" ]]; then
		tmp=`rpm -qa | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker rmi `docker images -q`
			echo -e "${Red_Info}已删除所有镜像！！"
			sleep 2s
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		tem=`dpkg -l | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker rmi `docker images -q`
			echo -e "${Red_Info}已删除所有镜像！！"
			sleep 2s
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		fi
	fi
}

#进入docker容器
Enter_docker(){
docker ps -ql
temp2=`docker ps -ql`
read -p "请输入上方的容器ID：" container_ID
if [[ "${container_ID}" =~ "${temp2}" ]] ; then
	docker exec -it ${container_ID} /bin/bash
else 
	echo -e "请输入正确的容器ID ："
	Enter_docker
fi
}
#删除所有没有运行的容器
docker_rm_not_run(){
if [[ "${release}" == "centos" ]]; then
		tmp=`rpm -qa | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker rm $(docker ps -qa)
			echo -e "${Red_Info}已删除所有没有运行的容器！！"
			sleep 2s
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		tem=`dpkg -l | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker rm $(docker ps -qa)
			echo -e "${Red_Info}已删除所有没有运行的容器！！"
			sleep 2s
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		fi
	fi
}

#删除所有容器
docker_rm_all(){
if [[ "${release}" == "centos" ]]; then
		tmp=`rpm -qa | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker rm $(docker stop $(docker ps -qa))
			echo -e "${Blue_Info}所有容器删除完成！！"
			sleep 2s
			echo -e "${Blue_Info}正在返回Docker菜单..."
			sleep 2s
			docker_menu
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		tem=`dpkg -l | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker rm $(docker stop $(docker ps -qa))
			echo -e "${Blue_Info}所有容器删除完成！！"
			sleep 2s
			echo -e "${Blue_Info}正在返回Docker菜单..."
			sleep 2s
			docker_menu
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	fi
}

#查看正在运行的容器
docker_ps(){
	if [[ "${release}" == "centos" ]]; then
		tmp=`rpm -qa | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker ps
			echo -e "${Blue_Info}只有上面这么多了"
			read -p "输入x返回主菜单，输入y返回当前菜单，输入其他任意键退出:" xyz
			[[ -z "${xyz}" ]] && xyz="y" 
			if [[ $xyz == [Xx] ]]; then
				echo -e "${Blue_2}进入主菜单....${Font}"
				sleep 2s
				main
			elif [[ $xyz == [Yy] ]]; then
				echo -e "${Blue_2}正在返回当前菜单....${Font}"
				sleep 2s
				docker_menu
			fi
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		tem=`dpkg -l | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker ps
			echo -e "${Blue_Info}只有上面这么多了"
			read -p "输入x返回主菜单，输入y返回当前菜单，输入其他任意键退出:" xyz
			[[ -z "${xyz}" ]] && xyz="y" 
			if [[ $xyz == [Xx] ]]; then
				echo -e "${Blue_2}进入主菜单....${Font}"
				sleep 2s
				main
			elif [[ $xyz == [Yy] ]]; then
				echo -e "${Blue_2}正在返回当前菜单....${Font}"
				sleep 2s
				docker_menu
			fi
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			sleep 2s
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		fi
	fi
}

#查看本地的镜像
docker_images(){
	if [[ "${release}" == "centos" ]]; then
		tmp=`rpm -qa | grep docker  `
		if [[ $tmp =~ "docker" ]]; then
			docker images
			echo -e "${Blue_Info}只有上面这么多了"
			read -p "输入x返回主菜单，输入y返回当前菜单，输入其他任意键退出:" xyz
			[[ -z "${xyz}" ]] && xyz="y" 
			if [[ $xyz == [Xx] ]]; then
				echo -e "${Blue_2}进入主菜单....${Font}"
				sleep 2s
				main
			elif [[ $xyz == [Yy] ]]; then
				echo -e "${Blue_2}正在返回当前菜单....${Font}"
				sleep 2s
				docker_menu
			fi
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			sleep 2s
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 2s
			docker_menu
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		tem=`dpkg -l | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker images
			echo -e "${Blue_Info}只有上面这么多了"
			read -p "输入x返回主菜单，输入y返回当前菜单，输入其他任意键退出:" xyz
			[[ -z "${xyz}" ]] && xyz="y" 
			if [[ $xyz == [Xx] ]]; then
				echo -e "${Blue_2}进入主菜单....${Font}"
				sleep 2s
				main
			elif [[ $xyz == [Yy] ]]; then
				echo -e "${Blue_2}正在返回当前菜单....${Font}"
				sleep 2s
				docker_menu
			fi
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	fi
}


#网易云镜像仓库操作判断脚本
docker_163(){
	if [[ "${release}" == "centos" ]]; then
		tmp=`rpm -qa | grep docker  `
		if [[ $tmp =~ "docker" ]]; then
			docker_163_163
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		tem=`dpkg -l | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker_163_163
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	fi
}

#网易云镜像仓库操作
docker_163_163(){
echo &&echo -e "${Blue_2}     你想做什么？${Font}

${Blue_2}  1.  ${Font}登录hub.c.163.com
${Blue_2}  2.  ${Font}退出hub.c.163.com
————————————
${Blue_2}  3.  ${Font}查看本地镜像
${Blue_2}  4.  ${Font}修改本地镜像
${Blue_2}  5.  ${Font}上传本地镜像
————————————
${Blue_2}  6.  ${Font}返回上级菜单
${Blue_2}  7.  ${Font}返回主菜单
————————————" &&echo

read -p "请输入数字[1-7] :" num3
case "$num3" in
	1)docker_login163
	;;
	2)docker logout hub.c.163.com
	;;
	3)docker_images163
	;;
	4)docker_tag163
	;;
	5)docker_push163
	;;
	6)docker_menu
	;;
	7)main
	;;
	*)
	clear
	echo -e "${Blue_2}请输入正确数字 [1-7]${Font}"
	sleep 2s
	docker_163
	;;
	esac
}
#登录网易云镜像仓库
docker_login163(){
read -p "请输入登录账户：" user
read -p "请输入密码：" passwd
docker login -u ${user} -p ${passwd} hub.c.163.com

echo -e "正在返回Docker菜单"
sleep 3s
docker_163
}
#网易云查看本地镜像
docker_images163(){
docker images
docker_163
}

#修改镜像名
docker_tag163(){
echo -e "${Blue_2}网易云镜像仓修改格式：hub.c.163.com/{你的用户名}/{仓库名}:标签名${Font}"
echo -e "${Red}如果在修改的时候有两个相同的镜像ID，则使用镜像名来进行修改${Font}"
read -p " 请输入镜像ID或者带标签的镜像名： " image_id
read -p " 请输入需要改为的镜像名： " image_name
docker tag ${image_id} ${image_name}

echo -e "修改完成正在返回！！"
echo -e "${Blue_2}正在返回Docker菜单...${Font}"
sleep 3s
docker_163
}

#网易云上传镜像
docker_push163(){
read -p "${Blue_2}请输入需要改为的镜像名：" image_name
docker push ${image_name}
echo -e "${Blue_2}正在返回Docker菜单...${Font}"
sleep 3s
docker_163
}

#Hub菜单判断脚本
docker_hub(){
	if [[ "${release}" == "centos" ]]; then
		tmp=`rpm -qa | grep docker  `
		if [[ $tmp =~ "docker" ]]; then
			docker_hub_hub
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		tem=`dpkg -l | grep docker`
		if [[ $tmp =~ "docker" ]]; then
			docker_hub_hub
		else
			echo -e "${Blue_2}没有安装docker${Font}"
			echo -e "${Blue_2}正在返回docker菜单${Font}"
			sleep 3s
			docker_menu
		fi
	fi
}

#Hub镜像仓库操作
docker_hub_hub(){
echo && echo -e "${Red} 你想做什么？${Font}

${Blue_2}  1.  ${Font}登录hub官方镜像仓库
${Blue_2}  2.  ${Font}退出hub官方镜像仓库
————————————
${Blue_2}  3.  ${Font}查看本地镜像
${Blue_2}  4.  ${Font}修改本地镜像
${Blue_2}  5.  ${Font}上传本地镜像
————————————
${Blue_2}  6.  ${Font}返回上级菜单
${Blue_2}  7.  ${Font}返回主菜单
————————————" && echo

read -p "请输入数字[1-7] :" num4
case "$num4" in
	1)docker_login_hub
	;;
	2)docker logout
	;;
	3)docker_images_hub
	;;
	4)docker_tag_hub
	;;
	5)docker_push_hub
	;;
	6)docker_menu
	;;
	7)main
	;;
	*)
	clear
	echo -e "${Blue_2}请输入正确数字 [1-7]${Font}"
	sleep 2s
	docker_hub
	;;
	esac
}

#HUB登录
docker_login_hub(){
read -p "请输入登录账户：" user
read -p "请输入密码：" passwd
docker login -u ${user} -p ${passwd}

echo -e "正在返回Docker菜单..."
sleep 3s
docker_hub
}
#Hub显示镜像
docker_images_hub(){
docker images
docker_hub
}
#Hub修改镜像
docker_tag_hub(){
echo -e "${Blue_2}HUB镜像仓修改格式：{你的用户名}/{仓库名}:标签名${Font}"
echo -e "${Red}如果在修改的时候有两个相同的镜像ID，则使用镜像名来进行修改${Font}"
read -p "请输入镜像ID或者带标签的镜像名： " image_id
read -p "请输入需要改为的镜像名： " image_name
docker tag ${image_id} ${image_name}

echo -e "修改完成正在返回！！"
sleep 3s
docker_hub
}
#Hub上传镜像
docker_push_hub(){
read -p "${Blue_2}请输入需要改为的镜像名：" image_name
docker push ${image_name}

echo -e "上传完成正在返回！！"
sleep 3s
docker_hub
}


#卸载Docker
docker_remove(){
	if [[ "${release}" == "centos" ]]; then
		yum -y remove docker*
		rm -rf /var/lib/docker
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		apt-get -y purge docker*
		rm -rf /var/lib/docker
	fi
	echo -e "${Blue_2}Docker卸载完成！！正在返回主菜单${Font}"
	echo -e "${Blue_2}正在返回主菜单...${Font}"
	sleep 3s
	main
}

#Docker状态管理
docker_status(){
clear
echo &&echo -e "${Blue_2}  1.  ${Font}启动Docker
${Blue_2}  2.  ${Font}停止Docker
${Blue_2}  3.  ${Font}重启Docker
————————————
${Blue_2}  4.  ${Font}返回Docker菜单
${Blue_2}  5.  ${Font}返回主菜单
————————————" && echo


read -p "请输入数字[1-5] :" num5
case "$num5" in
	1)service docker start
	;;
	2)service docker stop
	;;
	3)service docker restart
	;;
	4)docker_menu
	;;
	5)main
	;;
	*)
	clear
	echo -e "${Blue_2}请输入正确数字 [1-5]${Font}"
	sleep 2s
	docker_status
	;;
	esac
}

#新建常用的容器
crete_docker(){
	clear
	echo -e "${Blue_2}下面输入在容器中需要新建的系统${Font}"
	read -p "输入ubuntu\centos\apline\debian系统：" system_os
	if [[ "${system_os}" == "centos" ]]; then
		system="centos"
	elif [[ "${system_os}" == "ubuntu" ]]; then
		system="ubuntu"
	elif [[ "${system_os}" == "apline" ]]; then
		system="apline"
	elif [[ "${system_os}" == "debian" ]]; then
		system="debian"
	fi
	echo -e "${Blue_2}当前选择的系统为：${system}${Font}"
	echo -e "${Blue_2}下面输入需要映射的端口,前面为外围端口，后面为容器内端口${Font}"
	echo -e "${Blue_2}单端口为：-p 80:80${Font}"
	echo -e "${Blue_2}多端口为：-p 80:80 -p 443:443${Font}"
	echo -e "${Blue_2}如果没有输入,默认为：-p 80:80 -p 443:443 -p 88:88 -p 33060:33060 -p 3306:3306 -p 1000:22${Font}"
	read -p "请输入端口:" port
	[[ -z "${port}" ]] && port="-p 80:80 -p 443:443 -p 88:88 -p 33060:33060 -p 3306:3306 -p 1000:22"
	docker run -itd --privileged --cap-add SYS_ADMIN --name=${system} ${port} ${system}
	
	echo -e "${Blue_2}如果没有报错则新建成功，查看容器${Font}"
	docker ps
	read -p "输入x返回主菜单，输入y返回本菜单，输入z退出:" xyz
	[[ -z "${xyz}" ]] && xyz="y" 
	if [[ $xyz == [Xx] ]]; then
		echo -e "${Blue_2}进入主菜单${Font}"
		main
	elif [[ $xyz == [Yy] ]]; then
		echo -e "${Blue_2}回到本菜单${Font}"
		docker_menu
	fi
}

#安装Docker
docker_start(){
	if [[ "${release}" == "centos" ]]; then
		yum install -y epel-release yum-utils device-mapper-persistent-data lvm2
		yum -y update
		tee /etc/yum.repos.d/docker.repo <<-'EOF'
		[dockerrepo]
		name=Docker Repository
		baseurl=https://yum.dockerproject.org/repo/main/centos/7/
		enabled=1
		gpgcheck=1
		gpgkey=https://yum.dockerproject.org/gpg
		EOF
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		curl -ssl https://get.docker.com/ | sh
		apt-get -y update
		apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
		apt-get -y install apt-transport-https ca-certificates curl software-properties-common
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
		apt-key fingerprint 0EBFCD88
		add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
		apt-get update
				
	fi
	if [[ "${release}" == "centos" ]]; then
		read -p "请选择安装的版本docker-io;docker;docker-engine :" docker_version
		[[ -z "${docker_version}" ]] && docker_version="docker"
		if [[ "${docker_version}" == "docker" ]]; then
			yum -y install docker
			service docker start
			systemctl enable docker
			systemctl enable docker
			echo -e "${Blue_2}docker 安装启动完成${Font}"
		elif [[ "${docker_version}" == "docker-io" ]]; then
			yum -y install docker-io
			service docker start
			systemctl enable docker
			systemctl enable docker
			echo -e "${Blue_2}docker 安装启动完成${Font}"
		elif [[ "${docker_version}" == "docker-ce" ]]; then
			yum -y install docker-ce
			service docker start
			systemctl enable docker
			systemctl enable docker
			echo -e "${Blue_2}docker 安装启动完成${Font}"
		elif [[ "${docker_version}" == "docker-engine" ]]; then
			yum -y install docker-engine
			service docker start
			systemctl enable docker
			systemctl enable docker
			echo -e "${Blue_2}docker 安装启动完成${Font}"
		fi
	elif [[ "${release}" == "debian" || "${release}" == "ubuntu" ]]; then
		read -p "${Blue_2}请选择安装的版本docker-ce;docker :${Font}" docker_version
		[[ -z "${docker_version}" ]] && docker_version="docker"
		apt-get -y install ${docker_version}
		service docker start
		update-rc.d docker defaults 90
		echo -e "${Blue_2}docker 安装启动完成${Font}"
	fi
	read -p "输入x返回主菜单，输入y返回本菜单，输入z退出:" xyz
	[[ -z "${xyz}" ]] && xyz="y" 
	if [[ $xyz == [Xx] ]]; then
		echo -e "${Blue_2}进入主菜单${Font}"
		main
	elif [[ $xyz == [Yy] ]]; then
		echo -e "${Blue_2}回到本菜单${Font}"
		docker_menu
	fi
}

#SWAP设置
set_swap(){
root_need
clear
echo && echo -e "${Blue_2}  Linux VPS一键添加/删除swap脚本${Font}
————————————
${Blue_2}  1.  ${Font}添加swap
${Blue_2}  2.  ${Font}删除swap
————————————
${Blue_2}  3.  ${Font}查看SWAP使用情况
${Blue_2}  4.  ${Font}内存与虚拟内存命令
————————————
${Blue_2}  5.  ${Font}返回主菜单
————————————" && echo

read -p "请输入数字 [1-5]:" num1
case "$num1" in
		1)
		add_swap
		;;
		2)
		del_swap
		;;
		3)check_memory_swap
		;;
		4)check_swapmemory
		;;
		5)main
		;;
		*)
		clear
		echo -e "${Blue_2}请输入正确数字 [1-4]${Font}"
		sleep 2s
		set_swap
		;;
		esac
}

#查看swap使用情况
check_swapmemory(){
free -m
read -p "输入x返回主菜单，输入y返回本菜单，任意键退出:" xyz
[[ -z "${xyz}" ]] && xyz="y" 
if [[ $xyz == [Xx] ]]; then
	echo -e "${Blue_2}进入主菜单${Font}"
	main
elif [[ $xyz == [Yy] ]]; then
	echo -e "${Blue_2}回到本菜单${Font}"
	set_swap
fi
}

#查看内存和虚拟内存命令
check_memory_swap(){
cat /proc/meminfo | grep Swap
read -p "输入x返回主菜单，输入y返回本菜单，任意键退出:" xyz
[[ -z "${xyz}" ]] && xyz="y" 
if [[ $xyz == [Xx] ]]; then
	echo -e "${Blue_2}进入主菜单${Font}"
	main
elif [[ $xyz == [Yy] ]]; then
	echo -e "${Blue_2}回到本菜单${Font}"
	set_swap
fi
}

add_swap(){
	ovz_no
	echo -e "${Blue_2}请输入需要添加的swap，建议为内存的2倍！${Font}"
	read -p "请输入swap数值:" swapsize

	#检查是否存在swapfile
	grep -q "swapfile" /etc/fstab

	#如果不存在将为其创建swap
	if [ $? -ne 0 ]; then
		echo -e "${Blue_2}swapfile未发现，正在为其创建swapfile${Font}"
		fallocate -l ${swapsize}M /swapfile
		chmod 600 /swapfile
		mkswap /swapfile
		swapon /swapfile
		echo '/swapfile none swap defaults 0 0' >> /etc/fstab
			 echo -e "${Blue_2}swap创建成功，并查看信息：${Font}"
			 cat /proc/swaps
			 cat /proc/meminfo | grep Swap
	else
		echo -e "${Red}swapfile已存在，swap设置失败，请先运行脚本删除swap后重新设置！${Font}"
	fi
	read -p "输入x返回主菜单，输入y返回本菜单，输入z退出:" xyz
	[[ -z "${xyz}" ]] && xyz="y" 
	if [[ $xyz == [Xx] ]]; then
		echo -e "${Blue_2}进入主菜单${Font}"
		main
	elif [[ $xyz == [Yy] ]]; then
		echo -e "${Blue_2}回到本菜单${Font}"
		set_swap
	fi
}

del_swap(){
	ovz_no
	#检查是否存在swapfile
	grep -q "swapfile" /etc/fstab

	#如果存在就将其移除
	if [ $? -eq 0 ]; then
		echo -e "${Blue_2}swapfile已发现，正在将其移除...${Font}"
		sed -i '/swapfile/d' /etc/fstab
		echo "3" > /proc/sys/vm/drop_caches
		swapoff -a
		rm -f /swapfile
		echo -e "${Blue_2}swap已删除！${Font}"
	else
		echo -e "${Red}swapfile未发现，swap删除失败！${Font}"
	fi
	echo -e "删除swap完成！！"
	read -p "输入x返回主菜单，输入y返回本菜单，输入z退出:" xyz
	[[ -z "${xyz}" ]] && xyz="y" 
	if [[ $xyz == [Xx] ]]; then
		echo -e "${Blue_2}进入主菜单${Font}"
		main
	elif [[ $xyz == [Yy] ]]; then
		echo -e "${Blue_2}回到本菜单${Font}"
		set_swap
	fi
}

#检查系统
check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
}

#检查Linux版本
check_version(){
	if [[ -s /etc/redhat-release ]]; then
		version=`grep -oE  "[0-9.]+" /etc/redhat-release | cut -d . -f 1`
	else
		version=`grep -oE  "[0-9.]+" /etc/issue | cut -d . -f 1`
	fi
	bit=`uname -m`
	if [[ ${bit} = "x86_64" ]]; then
		bit="x64"
	else
		bit="x32"
	fi
}

#root权限
root_need(){
    if [[ $EUID -ne 0 ]]; then
        echo -e "${Red}Error:This script must be run as root!${Font}"
        exit 1
    fi
}

#检测ovz
ovz_no(){
    if [[ -d "/proc/vz" ]]; then
        echo -e "${Red}Your VPS is based on OpenVZ，not supported!${Font}"
        exit 1
    fi
}

#设置全局调用
set_management(){
cp ./menu.sh /root/menu.sh
chmod 777 /root/menu.sh
ln -sf /root/menu.sh /usr/bin/menu
}

#查看系统信息
check_sys_information(){
	os_check() {
			if [ -e /etc/redhat-release ]; then
					REDHAT=`cat /etc/redhat-release |cut -d' '  -f1`
			else
					DEBIAN=`cat /etc/issue |cut -d' ' -f1`
			fi
			if [ "$REDHAT" == "CentOS" -o "$REDHAT" == "Red" ]; then
					P_M=yum
			elif [ "$DEBIAN" == "Ubuntu" -o "$DEBIAN" == "ubutnu" ]; then
					P_M=apt-get
			else
					Operating system does not support.
					exit 1
			fi
	}
	if [ $LOGNAME != root ]; then
		echo "Please use the root account operation."
		exit 1
	fi
	if ! which vmstat &>/dev/null; then
			echo "vmstat command not found, now the install."
			sleep 1
			os_check
			$P_M install procps -y
			echo "-----------------------------------------------------------------------"
	fi
	if ! which iostat &>/dev/null; then
			echo "iostat command not found, now the install."
			sleep 1
			os_check
			$P_M install sysstat -y
			echo "-----------------------------------------------------------------------"
	fi
	 
	while true; do
		select input in cpu_load disk_load disk_use disk_inode mem_use tcp_status cpu_top10 mem_top10 traffic black_main quit; do
			case $input in
				cpu_load)
					#CPU利用率与负载
					echo "---------------------------------------"
					i=1
					while [[ $i -le 3 ]]; do
						echo -e "\033[32m  参考值${i}\033[0m"
						UTIL=`vmstat |awk '{if(NR==3)print 100-$15"%"}'`
						USER=`vmstat |awk '{if(NR==3)print $13"%"}'`
						SYS=`vmstat |awk '{if(NR==3)print $14"%"}'`
						IOWAIT=`vmstat |awk '{if(NR==3)print $16"%"}'`
						echo "Util: $UTIL"
						echo "User use: $USER"
						echo "System use: $SYS"
						echo "I/O wait: $IOWAIT"
						i=$(($i+1))
						sleep 1
					done
					echo "---------------------------------------"
					break
					;;
				disk_load)
					#硬盘I/O负载
					echo "---------------------------------------"
					i=1
					while [[ $i -le 3 ]]; do
						echo -e "\033[32m  参考值${i}\033[0m"
						UTIL=`iostat -x -k |awk '/^[v|s]/{OFS=": ";print $1,$NF"%"}'`
						READ=`iostat -x -k |awk '/^[v|s]/{OFS=": ";print $1,$6"KB"}'`
						WRITE=`iostat -x -k |awk '/^[v|s]/{OFS=": ";print $1,$7"KB"}'`
						IOWAIT=`vmstat |awk '{if(NR==3)print $16"%"}'`
						echo -e "Util:"
						echo -e "${UTIL}"
						echo -e "I/O Wait: $IOWAIT"
						echo -e "Read/s:\n$READ"
						echo -e "Write/s:\n$WRITE"
						i=$(($i+1))
						sleep 1
					done
					echo "---------------------------------------"
					break
					;;
				disk_use)
					#硬盘利用率
					DISK_LOG=/tmp/disk_use.tmp
					DISK_TOTAL=`fdisk -l |awk '/^Disk.*bytes/&&/\/dev/{printf $2" ";printf "%d",$3;print "GB"}'`
					USE_RATE=`df -h |awk '/^\/dev/{print int($5)}'`
					for i in $USE_RATE; do
						if [ $i -gt 90 ];then
							PART=`df -h |awk '{if(int($5)=='''$i''') print $6}'`
							echo "$PART = ${i}%" >> $DISK_LOG
						fi
					done
					echo "---------------------------------------"
					echo -e "Disk total:\n${DISK_TOTAL}"
					if [ -f $DISK_LOG ]; then
						echo "---------------------------------------"
						cat $DISK_LOG
						echo "---------------------------------------"
						rm -f $DISK_LOG
					else
						echo "---------------------------------------"
						echo "Disk use rate no than 90% of the partition."
						echo "---------------------------------------"
					fi
					break
					;;
				disk_inode)
					#硬盘inode利用率
					INODE_LOG=/tmp/inode_use.tmp
					INODE_USE=`df -i |awk '/^\/dev/{print int($5)}'`
					for i in $INODE_USE; do
						if [ $i -gt 90 ]; then
							PART=`df -h |awk '{if(int($5)=='''$i''') print $6}'`
							echo "$PART = ${i}%" >> $INODE_LOG
						fi
					done
					if [ -f $INODE_LOG ]; then
						echo "---------------------------------------"
						rm -f $INODE_LOG
					else
						echo "---------------------------------------"
						echo "Inode use rate no than 90% of the partition."
						echo "---------------------------------------"
					fi
					break
					;;
				mem_use)
					#内存利用率
					echo "---------------------------------------"
					MEM_TOTAL=`free -m |awk '{if(NR==2)printf "%.1f",$2/1024}END{print "G"}'`
					USE=`free -m |awk '{if(NR==3) printf "%.1f",$3/1024}END{print "G"}'`
					FREE=`free -m |awk '{if(NR==3) printf "%.1f",$4/1024}END{print "G"}'`
					CACHE=`free -m |awk '{if(NR==2) printf "%.1f",($6+$7)/1024}END{print "G"}'`
					echo -e "Total: $MEM_TOTAL"
					echo -e "Use: $USE"
					echo -e "Free: $FREE"
					echo -e "Cache: $CACHE"
					echo "---------------------------------------"
					break
					;;
				tcp_status)
					#网络连接状态
					echo "---------------------------------------"
					COUNT=`netstat -antp |awk '{status[$6]++}END{for(i in status) print i,status[i]}'`
					echo -e "TCP connection status:\n$COUNT"
					echo "---------------------------------------"
					;;
				cpu_top10)
					#占用CPU高的前10个进程
					echo "---------------------------------------"
					CPU_LOG=/tmp/cpu_top.tmp
					i=1
					while [[ $i -le 3 ]]; do
						#ps aux |awk '{if($3>0.1)print "CPU: "$3"% -->",$11,$12,$13,$14,$15,$16,"(PID:"$2")" |"sort -k2 -nr |head -n 10"}' > $CPU_LOG
						ps aux |awk '{if($3>0.1){{printf "PID: "$2" CPU: "$3"% --> "}for(i=11;i<=NF;i++)if(i==NF)printf $i"\n";else printf $i}}' |sort -k4 -nr |head -10 > $CPU_LOG
						#循环从11列（进程名）开始打印，如果i等于最后一行，就打印i的列并换行，否则就打印i的列
						if [[ -n `cat $CPU_LOG` ]]; then
						   echo -e "\033[32m  参考值${i}\033[0m"
						   cat $CPU_LOG
						   > $CPU_LOG
						else
							echo "No process using the CPU." 
							break
						fi
						i=$(($i+1))
						sleep 1
					done
					echo "---------------------------------------"
					break
					;;
				mem_top10)
					#占用内存高的前10个进程
					echo "---------------------------------------"
					MEM_LOG=/tmp/mem_top.tmp
					i=1
					while [[ $i -le 3 ]]; do
						#ps aux |awk '{if($4>0.1)print "Memory: "$4"% -->",$11,$12,$13,$14,$15,$16,"(PID:"$2")" |"sort -k2 -nr |head -n 10"}' > $MEM_LOG
						ps aux |awk '{if($4>0.1){{printf "PID: "$2" Memory: "$3"% --> "}for(i=11;i<=NF;i++)if(i==NF)printf $i"\n";else printf $i}}' |sort -k4 -nr |head -10 > $MEM_LOG
						if [[ -n `cat $MEM_LOG` ]]; then
							echo -e "\033[32m  参考值${i}\033[0m"
							cat $MEM_LOG
							> $MEM_LOG
						else
							echo "No process using the Memory."
							break
						fi
						i=$(($i+1))
						sleep 1
					done
					echo "---------------------------------------"
					break
					;;
				traffic)
					#查看网络流量
					while true; do
						read -p "Please enter the network card name(eth[0-9] or em[0-9]): " eth
						#if [[ $eth =~ ^eth[0-9]$ ]] || [[ $eth =~ ^em[0-9]$ ]] && [[ `ifconfig |grep -c "\<$eth\>"` -eq 1 ]]; then
						if [ `ifconfig |grep -c "\<$eth\>"` -eq 1 ]; then
								break
						else
							echo "Input format error or Don't have the card name, please input again."
						fi
					done
					echo "---------------------------------------"
					echo -e " In ------ Out"
					i=1
					while [[ $i -le 3 ]]; do
						#OLD_IN=`ifconfig $eth |awk '/RX bytes/{print $2}' |cut -d: -f2`
						#OLD_OUT=`ifconfig $eth |awk '/RX bytes/{print $6}' |cut -d: -f2`
						OLD_IN=`ifconfig $eth |awk -F'[: ]+' '/bytes/{if(NR==8)print $4;else if(NR==5)print $6}'`
						#CentOS6和CentOS7 ifconfig输出进出流量信息位置不同，CentOS6中RX与TX行号等于8，CentOS7中RX行号是5，TX行号是5，所以就做了个判断.       
						OLD_OUT=`ifconfig $eth |awk -F'[: ]+' '/bytes/{if(NR==8)print $9;else if(NR==7)print $6}'`
						sleep 1
						NEW_IN=`ifconfig $eth |awk -F'[: ]+' '/bytes/{if(NR==8)print $4;else if(NR==5)print $6}'`
						NEW_OUT=`ifconfig $eth |awk -F'[: ]+' '/bytes/{if(NR==8)print $9;else if(NR==7)print $6}'`
						IN=`awk 'BEGIN{printf "%.1f\n",'$((${NEW_IN}-${OLD_IN}))'/1024/128}'`
						OUT=`awk 'BEGIN{printf "%.1f\n",'$((${NEW_OUT}-${OLD_OUT}))'/1024/128}'`
						echo "${IN}MB/s ${OUT}MB/s"
						i=$(($i+1))
						sleep 1
					done
					echo "---------------------------------------"
					break
					;;
				black_main)
					main
					;;
				quit)	
					exit 0
					;;
				   *)
						echo "---------------------------------------"
						echo "Please enter the number." 
						echo "---------------------------------------"
						break
						;;
			esac
		done
	done
}

#更新脚本
Update_Shell(){
	echo -e "当前版本为 [ ${Script_version} ]，开始检测最新版本..."
	sh_new_ver=$(wget --no-check-certificate -qO- "https://${HTTP}/sh/menu.sh"|grep 'Script_version="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
	[[ -z ${sh_new_ver} ]] && echo -e "${Error} 检测最新版本失败 !" && main
	if [[ ${sh_new_ver} != ${Script_version} ]]; then
		echo -e "发现新版本[ ${sh_new_ver} ]，是否更新？[Y/n]"
		read -p "(默认: y):" yn
		[[ -z "${yn}" ]] && yn="y"
		if [[ ${yn} == [Yy] ]]; then
			wget -N --no-check-certificate https://${HTTP}/sh/menu.sh && chmod +x menu.sh
			sleep 2s
			echo -e "脚本已更新为最新版本[ ${sh_new_ver} ] !"
			sleep 2s
			./menu.sh
		else
			echo && echo "	已取消..." && echo
			echo -e "正在返回主菜单..."
			sleep 2s
			main
		fi
	else
		echo -e "当前已是最新版本[ ${sh_new_ver} ] !"
		sleep 3s
		echo -e "正在返回主菜单..."
		sleep 2s
		main
	fi
}
main