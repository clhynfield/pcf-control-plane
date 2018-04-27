#!/bin/bash

: "${BBL_STATE_DIRECTORY:=../bbl-state}"
: "${BBL_ENV_NAME:=control-plane}"

eval "$(bbl print-env)"

concourse_bosh_deployment='./concourse-bosh-deployment'
concourse_cluster="$concourse_bosh_deployment/cluster"

if [ $# -ne 0 ]; then
  bosh_command="interpolate"
else
  bosh_command="deploy -d concourse"
fi

bosh $bosh_command "$concourse_cluster/concourse.yml" \
  -l "$concourse_bosh_deployment/versions.yml" \
  -o "$concourse_cluster/operations/basic-auth.yml" \
  -o "$concourse_cluster/operations/static-web.yml" \
  -o "$concourse_cluster/operations/tls.yml" \
  -o "set-db-static-ip.yml" \
  -o "add-self-signed-cert.yml" \
  -o 'generate-basic-auth-creds.yml' \
  -o "add-credhub.yml" \
  --var web_ip=10.193.163.17 \
  --var db_ip=10.193.163.16 \
  --var external_url=https://10.193.163.17 \
  --var network_name=default \
  --var web_vm_type=small \
  --var db_vm_type=small-highmem \
  --var db_persistent_disk_type=100GB \
  --var worker_vm_type=large \
  --var deployment_name=concourse \
  --var skip_ssl_validation=true

