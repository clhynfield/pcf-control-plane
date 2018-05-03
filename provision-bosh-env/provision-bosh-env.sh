#!/bin/bash

set -xe

: "${BBL_STATE_DIRECTORY:=../bbl-state}"
: "${BBL_ENV_NAME:=control-plane}"

bbl plan --iaas vsphere

cp director-dns.yml "$BBL_STATE_DIRECTORY/cloud-config/"
cp static-ips.yml "$BBL_STATE_DIRECTORY/cloud-config/"
cp create-director-override.sh "$BBL_STATE_DIRECTORY/"
cp create-jumpbox-override.sh "$BBL_STATE_DIRECTORY/"

bbl up

