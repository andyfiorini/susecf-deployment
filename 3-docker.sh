#!/bin/bash
#
# Script for prequisites on Linux-Kubernetes-SuseCF
# Author: Andres Lucas Garcia Fiorini
# Altoros S.A. (Argentina) 
# date: 10/17/2017

. common/function.scr

function usage {
    echo "usage: $0";
    exit 254;
}
if [ $1 = "-h" ];
then
    usage;
fi

yum remove docker \
                  docker-common \
                  docker-selinux \
                  docker-engine
check_err;
yum install -y yum-utils \
                  device-mapper-persistent-data \
                  lvm2
check_err;
yum-config-manager \
                  --add-repo \
                  https://download.docker.com/linux/centos/docker-ce.repo
check_err;
yum-config-manager --enable docker-ce-edge
check_err;
yum install docker-1.12
check_err;


