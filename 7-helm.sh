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

cd /tmp
check_err;
curl -LO https://storage.googleapis.com/golang/go1.7.linux-amd64.tar.gz
check_err;
sudo tar -C /usr/local -xvzf go1.7.linux-amd64.tar.gz
check_err;
mkdir -p ~/projects/{bin,pkg,src}
check_err;
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile.d/path.sh
check_err;

export GOBIN="$HOME/projects/bin"
check_err;
export GOPATH="$HOME/projects/src"
check_err;

cd $GOPATH
check_err;
mkdir -p src/k8s.io
check_err;
cd src/k8s.io
check_err;
git clone https://github.com/kubernetes/helm.git
check_err;
cd helm
check_err;
make bootstrap build
check_err;


helm init --canary-image
check_err;
