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

if ! kubectl get pods -n uaa | grep mysql | grep 1\/1;
then 
    echo "UAA Mysql is not running!"
    exit 37;
fi

if ! kubectl get pods -n uaa | grep uaa\- | grep 1\/1;
then 
    echo "UAA java app is not running!"
    exit 37;
fi

helm install helm/cf \
    --namespace scf \
    --set kube.storage_class.persistent=hostpath \
    --values certs/scf-cert-values.yaml \
    --values scf-config-values.yaml
check_err;
