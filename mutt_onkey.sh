#!/bin/bash
#author: Hank (chenhanhank@icloud.com)
#date: 2014-09-14 13:57:41
#Name: MUTT_OneKey

#----------------------------------------------------------#
#常量设置

MAIL_SERVICE="" #smtp service
MAIL_USER="" #xxx@xxx.com
MAIL_PASS="" 

#muttmail 安装###################################################
MUTT(){
cd /usr/local/src
wget --no-check-certificate "http://jaist.dl.sourceforge.net/project/msmtp/msmtp/1.4.32/msmtp-1.4.32.tar.bz2"
tar -jxf msmtp-1.4.32.tar.bz2
cd ./msmtp-1.4.32
./configure --prefix=/usr/local/msmtp
make
make install
mkdir /usr/local/msmtp/etc/
cat << EOF >> /usr/local/msmtp/etc/msmtprc
account default
host $MAIL_SERVICE
from $MAIL_USER
auth login
user $MAIL_USER
password $MAIL_PASS

logfile /var/log/mmlog
EOF
touch /var/log/mmlog
chmod 662 /var/log/mmlog
yum install mutt -y
echo 'set sendmail="/usr/local/msmtp/bin/msmtp"' >> /etc/Muttrc
echo "set use_from=yes" >> /etc/Muttrc
echo "set realname=\"$HOSTNAME\"" >> /etc/Muttrc
echo "set from="noreply@limei.com"" >> /etc/Muttrc
echo "set editor=\"vi\"" >> /etc/Muttrc
echo "mutt 邮件发件软件安装完毕:"
echo "发件服务器以及账户设置位置:/usr/local/msmtp/etc/msmtprc"
echo "邮件上发件人邮箱、名称修改位置:/etc/Muttrc"
echo "邮件发送语法:echo "testmail" | mutt -s "测试" -a /etc/hosts xxx@xxxx.com "
echo "echo 正文 -a 附件 -s 主题"

}
#muttmail 安装完毕##############################################
