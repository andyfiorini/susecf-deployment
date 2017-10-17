#!/bin/bash
#
# Script for prequisites on Linux-Kubernetes-SuseCF
# Author: Andres Lucas Garcia Fiorini
# Altoros S.A. (Argentina) 
# date: 10/17/2017

. common/function.scr

function usage {
    echo "usage: $0 -i OPENSTACK_SSH_KEY -n MASTER_NETWORK FINAL_ADDR_OCT1...";
    echo "Example: $0 -i kubernets.pem -n 172.16.0. 10 11 12 13 14 15";
    exit 254;
}
if [ $# -lt 4 ] || [ $1 = "-h" ];
then
    usage;
fi

echo "
********************************
This scrpt must be executed from 
the jumpbox or the k8s master.
********************************
"
printf "continue(Y/n): ";
read a
case $a in
  n)
   exit;;
  *)
   echo "go!";
esac

for i in  $4 $5 $6 $7 $8 $9;do ssh -l centos -i $2 172.16.0.$i "sudo su - -c 'yum install -y ntp; systemctl enable ntpd ; systemctl start ntpd'"; done
