#!/bin/bash

set -e

eval "$(bbl print-env)"

bosh deployments

bosh cloud-config | grep 10.193.163.2

credhub set -n doofenschmirtz -v wogga -t value
credhub get -n doofenschmirtz | grep wogga 
