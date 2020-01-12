#!/bin/bash

# 本脚本仅用于虚拟机学习docker时使用

# 安装net-tools ntp-date
yum install -y net-tools
yum install -y ntpdate

# 设置时区并且同步时间
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate time.windows.com

# 关闭防火墙
systemctl stop firewalld
systemctl disable firewalld

# 关闭安全组
sed 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

# 设置阿里云的docker源
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# 安装docker
yum install -y docker-ce-18.09.9-3.el7 docker-ce-cli-18.09.9-3.el7 containerd.io

# 配置docker阿里云镜像
mkdir -p /etc/docker | echo "mkdir ok"
tee /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://5q2ljnga.mirror.aliyuncs.com","http://registry.docker-cn.com","http://docker.mirrors.ustc.edu.cn","http://hub-mirror.c.163.com"]
}
EOF

# 设置docker开机启动
systemctl enable docker

# 重启docker
systemctl daemon-reload
systemctl restart docker


