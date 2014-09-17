#history记录加强脚本
#存放地址/data/history
#history 命令格式
# 1  hank:211.157.1.12:2014-09-11 15:30:33:history
# id  name:ip:date:command
#author: hank 周宸翰
#date: 2014年09月11日16:04:36
#email: chenhanhank@icloud.com

#check /data/history
if [ -d /data ];
then
    if [ -d /data/history ];
    then
        echo "已有/data/history目录，停止执行脚本"
        exit 1
    else
        mkdir /data/history
        chmod 777 /data/history
    fi
else
    echo "不存在/data文件夹，请自己建立,停止执行脚本"
    exit 1
fi



cat >> /etc/profile << EOF

#user ip
USER_IP="\`who -u am i 2>/dev/null| awk '{print \$NF}'|sed -e 's/[()]//g'\`"
if [ "\$USER_IP" = "" ]
then
USER_IP="\`hostname\`"
fi
#history env
export HISTSIZE=10024
export HISTTIMEFORMAT="\`whoami\`:\${USER_IP}:%F %T:"
export HISTFILE="/data/history/\${LOGNAME}.his"

EOF


source /etc/profile

echo ">> history文件夹位置/data/history/username.his"
echo ">> 切换到具体用户使用history可见用户IP 等"
echo ">> history 命令格式"
echo "1  hank:211.157.3.4:2014-09-11 15:30:33:history"
echo "id  name:ip:date:command"
