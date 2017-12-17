# Shadowsowcks1Click
## 特别感谢
修改自Hao-Luo大佬的SSR脚本！
<br>https://github.com/Hao-Luo/
<br>感谢Teddysun的BBR脚本！
<br>https://github.com/teddysun/
## 说明
添加更多自定义设置，省去配置步骤，修改设置一键安装完毕。
<br>脚本在centos7上测试通过，其他发行版未测试。
## 使用方法
````
wget -N --no-check-certificate https://raw.githubusercontent.com/maxzh0916/Shadowsowcks1Click/master/Shadowsowcks1Click.sh;chmod +x Shadowsowcks1Click.sh;./Shadowsowcks1Click.sh
````
<br>复制上方代码并执行开始安装。
## 脚本功能
````
1.检查是否安装了git、libsodium（可能会有点慢）。
2.选择安装功能，
  1）SSR
  2）BBR
  3）定时重启节点
3.BBR安装以后需要重启。
4.SSR下载并安装以后会按提示输入配置即可。
API接口：mudbjson, sspanelv2, sspanelv3, sspanelv3ssr, glzjinmod, legendsockssr，根据面板要求输入。
mysql服务器地址：SSR和数据库在同一台服务器输入127.0.0.1，远程节点填写数据库IP。
mysql服务器端口：默认端口输入3306，更改过的输入自己的端口。
mysql服务器用户名：root或者其他设置的用户名。
mysql服务器密码:与用户名对应的密码。
mysql服务器数据库名:前端建立数据库时的数据库名，ssrpanel或其他。
SSR节点ID（nodeid）:前端建立节点时的ID。
加密（method）：SSR的加密方式，aes-256-cfb等。
协议（protocol）：SSR的协议插件，origin等。
混淆（obfs）：SSR的混淆插件，plain等。
5.配置完成会关闭iptables、firewalld，大佬请自行设置。
````
