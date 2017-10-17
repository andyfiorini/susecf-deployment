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
if [ $# -lt 1 ] || [ $1 = "-h" ];
then
    usage;
fi

if [ ! -z $1 ];
then
  hostnamectl set-hostname $2;
  check_err;
else 
  hostnamectl set-hostname k8s-master;
  check_err;
fi

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' \ /etc/sysconfig/selinux
check_err;

echo “net.bridge.bridge-nf-call-iptables = 1” >> /etc/sysctl.conf
check_err;

sysctl -p
check_err;

reboot
check_err;
