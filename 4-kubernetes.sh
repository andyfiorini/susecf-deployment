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

kubeadm --kubernetes-version “stable-1.6” --token-ttl 0 \
 --pod-network-cidr=10.244.0.0/16 
check_err;

kubectl apply -f https://raw.githubusercontent.com/projectcalico/canal/master/k8s-install/1.6/rbac.yaml
check_err;

kubectl apply -f https://raw.githubusercontent.com/projectcalico/canal/master/k8s-install/1.6/canal.yaml
check_err;

kubectl annotate ns uaa "net.beta.kubernetes.io/network-policy={\"ingress\":{\"isolation\":\"DefaultAllow\"}}"
check_err;

kubectl annotate ns scf "net.beta.kubernetes.io/network-policy={\"ingress\":{\"isolation\":\"DefaultAllow\"}}"
check_err;

