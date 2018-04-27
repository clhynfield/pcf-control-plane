#!/bin/bash
#git clone https://github.com/concourse/concourse-deployment.git
#bosh upload-stemcell https://s3.amazonaws.com/bosh-core-stemcells/vsphere/bosh-stemcell-3541.5-vsphere-esxi-ubuntu-trusty-go_agent.tgz

credhub set -n /bosh-mgmt-system/concourse/atc_tls \
	-r sys-root.pem \
	-p sys-wild-key.pem \
	-c sys-wild-cert.pem \
	-t certificate

#sys-intermediate.pem
#sys-root.pem
#sys-wild-cert.pem
#sys-wild-key.pem
