#!/bin/bash
[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }
install_ssr(){
	clear
	stty erase '^H' && read -p " API接口（mudbjson, sspanelv2, sspanelv3, sspanelv3ssr, glzjinmod, legendsockssr）:" ssapi
	stty erase '^H' && read -p " mysql服务器地址:" ssserver
	stty erase '^H' && read -p " mysql服务器端口:" ssport
	stty erase '^H' && read -p " mysql服务器用户名:" ssuser
	stty erase '^H' && read -p " mysql服务器密码:" sspass
	stty erase '^H' && read -p " mysql服务器数据库名:" ssdb
	stty erase '^H' && read -p " SSR节点ID（nodeid）:" ssnode
	stty erase '^H' && read -p " 加密（method）:" ssmethod
	stty erase '^H' && read -p " 协议（protocol）:" ssprotocol
	stty erase '^H' && read -p " 混淆（obfs）:" ssobfs
	clear
	cd /root/
  	wget https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz
  	tar xf libsodium-1.0.16.tar.gz && cd libsodium-1.0.16
  	./configure && make -j2 && make install
  	echo /usr/local/lib > /etc/ld.so.conf.d/usr_local_lib.conf
  	cd /root/
  	rm -rf libsodium-1.0.16.tar.gz
	echo 'libsodium安装完成'
  	git clone -b master https://github.com/maxzh0916/Shadowsowcks1Click.git && mv Shadowsowcks1Click shadowsocksr && cd shadowsocksr && chmod +x setup_cymysql.sh && chmod +x ./initcfg.sh && ./setup_cymysql.sh && ./initcfg.sh
	rm -rf Shadowsowcks1Click.sh
	echo 'ssr安装完成'
	sed -i -e "s/ssapi/$ssapi/g" userapiconfig.py
	sed -i -e "s/ssserver/$ssserver/g" usermysql.json
	sed -i -e "s/ssport/$ssport/g" usermysql.json
	sed -i -e "s/ssuser/$ssuser/g" usermysql.json
	sed -i -e "s/sspass/$sspass/g" usermysql.json
	sed -i -e "s/ssdb/$ssdb/g" usermysql.json
	sed -i -e "s/ssnode/$ssnode/g" usermysql.json
	sed -i -e "s/ssmethod/$ssmethod/g" user-config.json
	sed -i -e "s/ssprotocol/$ssprotocol/g" user-config.json
	sed -i -e "s/ssobfs/$ssobfs/g" user-config.json
	echo 'ssr配置完成'
	chmod +x run.sh && ./run.sh
	cd /root/
	echo 'ssr已开始运行'
	service iptables stop
	service firewalld stop
	systemctl disable firewalld.service
	chkconfig iptables off
	echo '已关闭iptables、firewalld，如有需要请自行配置。'
}

open_bbr(){
	clear
	cd
	wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
	chmod +x bbr.sh
	./bbr.sh
}

auto_reboot(){
	clear
	echo '设置每天几点几分重启节点'
	stty erase '^H' && read -p " 小时(0-23):" hour
	stty erase '^H' && read -p " 分钟(0-59):" minute
	chmod +x /etc/rc.d/rc.local
	echo /sbin/service crond start >> /etc/rc.d/rc.local
	echo "/root/shadowsocksr/run.sh" >> /etc/rc.d/rc.local
	echo '设置开机运行SSR'
	echo "$minute $hour * * * root /sbin/reboot" >> /etc/crontab
	service crond start
}

yum -y install git
yum -y groupinstall "Development Tools"
clear
echo ' 注意：此脚本基于centos7编写，其他系统可能会出问题'
echo ' 1. 安装 SSR'
echo ' 2. 安装 BBR'
echo ' 3. 设置定时重启（测试中）'
stty erase '^H' && read -p " 请输入数字 [1-3]:" num
case "$num" in
	1)
	install_ssr
	;;
	2)
	open_bbr
	;;
	3)
	auto_reboot
	;;
	*)
	echo '请输入正确数字 [1-3]'
	;;
esac
