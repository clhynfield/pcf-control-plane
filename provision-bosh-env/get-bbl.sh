#!/bin/sh

set -e

base_url='https://github.com/cloudfoundry/bosh-bootloader'
version='v6.6.5'

bbl_download="bbl-${version}_linux_x86-64"

curl -L -O "$base_url/releases/download/$version/$bbl_download"

mkdir -p "$HOME/bin"

install -m 0755 "$bbl_download" "$HOME/bin/bbl"

rm "$bbl_download"
