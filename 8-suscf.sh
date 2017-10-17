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

wget  https://github.com/SUSE/scf/releases/download/2.2.0-beta/scf-2.2.0-beta-pre.cf265.1.gd50775b4.linux-amd64.zip
chck_err;

mkdir suse
chck_err;

if !  kubectl get pods -n kube-system | grep kube-dns |grep 3\/3;
then
    echo "kube-dns is NOT running, please check the canal deployment on kubernetes!";
    exit 36;
fi

echo "Please set \'TaskMax=infinity\' on the [Environment] stanza of /etc/systemd/system/multi*/docker";
