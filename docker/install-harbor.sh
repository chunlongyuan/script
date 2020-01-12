#!/bin/bash

# CentOS Linux release 7.5.1804 (Core) 上使用
# 本脚本仅用于虚拟机学习docker时使用
# 新装的机器执行该脚本进行安装harbor

# 访问harbor的hostname，请在这里修改
BARBOR_HOSTNAME harbor.andy.com

# 初始化并安装docker
curl https://raw.githubusercontent.com/everest-8844/script/master/docker/init-and-install-docker.sh | bash

# 安装docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# 下载harbor安装包并解压至/usr/local
wget -c https://github.com/goharbor/harbor/releases/download/v1.9.4/harbor-offline-installer-v1.9.4.tgz
tar xf harbor-offline-installer-v1.9.4.tgz -C /usr/local/

# 修改harbor的hostname配置后执行安装脚本
cd /usr/local/harbor/
cp harbor.yaml harbor.yaml.bak
sed s/reg.mydomain.com/$BARBOR_HOSTNAME/ harbor.yml
./install