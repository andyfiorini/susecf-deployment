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
mkdir storage && cd storage;
check_err;
git clone https://github.com/nailgun/k8s-hostpath-provisioner.git
check_err;
cd k8s*prov*
check_err;
cd example
check_err;
kubectl create -f sa.yaml -f cluster-roles.yaml -f cluster-role-bindings.yaml -f ds.yaml
check_err;
kubectl label node --all nailgun.name/hostpath=enabled
check_err;
kubectl annotate node NODE_NAME hostpath.nailgun.name/local-magnetic=/mnt
check_err;
cat > sc.yml <<EOF
kind: StorageClass
apiVersion: storage.k8s.io/v1beta1
metadata:
  name: local-magnetic
provisioner: nailgun.name/hostpath
parameters:
  hostPathName: local-magnetic
EOF
kubectl create -f sc.yaml -f pvc.yaml
check_err;
