#Require Root Permission
[ $(id -u) != "0" ] && { echo "Error: You must be root to run this script"; exit 1; }

install_ssr(){
	cd /root/
	echo '下载ssr'
	git clone -b master https://github.com/maxzh0916/1ClickDeploy.git && mv 1ClickDeploy shadowsocksr && cd shadowsocksr && chmod +x setup_cymysql.sh && chmod +x ./initcfg.sh && ./setup_cymysql.sh && ./initcfg.sh
	rm -rf 1ClickDeploy.sh
	echo 'ssr安装完成'
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
	cd
	echo 'ssr已开始运行'
	service iptables stop
	service firewalld stop
	echo '暂时关闭iptables、firewalld，如有需求请自行配置。'
}

open_bbr(){
	cd
	wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh
	chmod +x bbr.sh
	./bbr.sh

}

if [ `rpm -qa | git |wc -l` -ne 0 ];then
	echo "已安装git" 
else
	if [ -f /etc/redhat-release ]; then
	yum -y install git
	elif cat /etc/issue | grep -Eqi "debian"; then
	apt-get -y install git
	elif cat /etc/issue | grep -Eqi "ubuntu"; then
	apt-get -y install git
	elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
	yum -y install git
	elif cat /proc/version | grep -Eqi "debian"; then
	apt-get -y install git
	elif cat /proc/version | grep -Eqi "ubuntu"; then
	apt-get -y install git
	elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
	yum -y install git
	fi
fi
echo ' 1. 安装SSR'
echo ' 2. 安装BBR'
stty erase '^H' && read -p " 请输入数字 [1-2]:" num
case "$num" in
	1)
	install_ssr
	;;
	2)
	open_bbr
	;;
	*)
	echo '请输入正确数字 [1-2]'
	;;
esac
