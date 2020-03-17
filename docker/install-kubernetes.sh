#!/bin/bash

# CentOS Linux release 7.5.1804 (Core) 上使用
# 本脚本仅用于虚拟机学习kubenetes时使用
# 新装的虚拟机执行该脚本进行docker和kubernetes安装
# 除了安装脚本还需要关闭swap分区

bash <(curl -s -L https://raw.githubusercontent.com/everest-8844/script/master/docker/install-docker.sh)

tee /etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

systemctl enable kubelet && systemctl start kubelet

tee /etc/sysctl.d/k8s.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system
