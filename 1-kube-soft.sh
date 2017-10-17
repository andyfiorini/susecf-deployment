#!/bin/bash
#
# Script for prequisites on Linux-Kubernetes-SuseCF
# Author: Andres Lucas Garcia Fiorini
# Altoros S.A. (Argentina) 
# date: 10/17/2017

. common/function.scr

function usage {
    echo "usage: $0 [ -n MASTER_HOSTNAME]";
    exit 254;
}
if [ $1 = "-h" ];
then
    usage;
fi

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
 [kubernetes]
 name=Kubernetes
 baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
 enabled=1
 gpgcheck=1
 repo_gpgcheck=1
 gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
    	https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install kubeadm-1.6.7-0 kubectl-1.6.7-0 kubelet-1.8.0 -y
check_err;
