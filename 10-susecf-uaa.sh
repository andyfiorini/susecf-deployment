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

helm install helm/uaa \
    --namespace uaa \
    --set kube.storage_class.persistent=hostpath \
    --values certs/uaa-cert-values.yaml \
    --values scf-config-values.yaml
check_err;
