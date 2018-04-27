#!/bin/sh
bosh create-env \
  ${BBL_STATE_DIR}/bosh-deployment/bosh.yml \
  --state  ${BBL_STATE_DIR}/vars/bosh-state.json \
  --vars-store  ${BBL_STATE_DIR}/vars/director-vars-store.yml \
  --vars-file  ${BBL_STATE_DIR}/vars/director-vars-file.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/vsphere/cpi.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/jumpbox-user.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/uaa.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/credhub.yml \
  -o  ${BBL_STATE_DIR}/bosh-deployment/vsphere/resource-pool.yml \
  -o  director-dns.yml \
  -v  internal_dns='[10.193.163.2]' \
  -v  vcenter_user="${BBL_VSPHERE_VCENTER_USER}" \
  -v  vcenter_password="${BBL_VSPHERE_VCENTER_PASSWORD}" 
