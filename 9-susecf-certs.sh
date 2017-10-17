#!/bin/bash
#
# Script for prequisites on Linux-Kubernetes-SuseCF
# Author: Andres Lucas Garcia Fiorini
# Altoros S.A. (Argentina) 
# date: 10/17/2017

. common/function.scr

function usage {
    echo "usage: $0 -d DOMAIN -a FIRST_NODE_ADDRESS ";
    echo "Domain should be .nip.io or .xip.io";
    exit 254;
}
if [ $# -lt 4 ] || [ $1 = "-h" ];
then
    usage;
fi

cd suse
check_err;

mkdir certs
check_err;

./cert-generator.sh -d $2 -n scf -o certs/
check_err;

cat > scf-config-values.yaml <<EOF
env:
    # Password for the cluster
    CLUSTER_ADMIN_PASSWORD: changeme

    # Domain for SCF. DNS for *.DOMAIN must point to the a kube node's (not master)
    # external ip. This must match the value passed to the
    # cert-generator.sh script.
    DOMAIN: $2

    # Password for SCF to authenticate with UAA
    UAA_ADMIN_CLIENT_SECRET: uaa-admin-client-secret

    # UAA host/port that SCF will talk to. If you have a custom UAA
    # provide its host and port here. If you are using the UAA that comes
    # with the SCF distribution, simply use the two values below and
    # substitute the cf-dev.io for your DOMAIN used above.
    UAA_HOST: $4.$2
    UAA_PORT: 2793
kube:
    # The IP address assigned to the kube node pointed to by the domain. The example value here
    # is what the vagrant setup assigns, you will likely need to change it.
    external_ip: $4
EOF
