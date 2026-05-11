#!/usr/bin/env bash

if type dep &>/dev/null; then
    dep include log2/k8s-common kube-config
else
    include log2/k8s-common lib/kube-config.sh
fi

req_ver az 2.81.0 azure-cli

set_azure_profile()
{
    # TBD: implement profile switching (like set_aws_profile does for AWS_PROFILE)
    :
}
