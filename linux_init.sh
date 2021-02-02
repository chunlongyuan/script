#!/bin/bash
#Usefulness:服务器内核参数初始化脚本
#Run: ./Initialization.sh
#Author:Moka
#Time:202004
####安装必要工具
yum install -y vim ntp bc wget lrzsz
####时间同步
echo 'ZONE="Asia/Shanghai"' > /etc/sysconfig/clock
ntpdate -s pool.ntp.org
echo "10 */1 * * *  /usr/sbin/ntpdate -s pool.ntp.org"  >> /var/spool/cron/root
####系统优化
echo "ulimit -c unlimited
ulimit -s 512000
ulimit -u 1064960
ulimit -d unlimited
ulimit -m unlimited
ulimit -t unlimited
ulimit -v unlimited
ulimit -SHn 65535 " >> /etc/profile
source /etc/profile
####Linux内核优化
echo -ne "net.ipv4.tcp_max_syn_backlog = 65536
net.core.netdev_max_backlog =  32768
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 873200
net.core.wmem_max = 16777216
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.ip_local_port_range = 1024  65535
fs.file-max=102400
">>/etc/sysctl.conf
sysctl -p
