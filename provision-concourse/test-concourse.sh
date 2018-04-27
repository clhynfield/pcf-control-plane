#!/bin/bash

: "${BBL_STATE_DIRECTORY:=../bbl-state}"
: "${BBL_ENV_NAME:=control-plane}"

cred_path="/bosh-$BBL_ENV_NAME/concourse"

credhub_config="$HOME/.credhub/config.json"
if [ -f "$credhub_config" ]; then
    rm "$credhub_config"
fi

eval "$(bbl print-env)"

concourse_username="$(credhub get --name "$cred_path/atc_basic_auth" --output-json | jq --raw-output '.value.username')"
concourse_password="$(credhub get --name "$cred_path/atc_basic_auth" --output-json | jq --raw-output '.value.password')"
concourse_url="https://$(
    bosh --deployment concourse --json instances \
        | jq --raw-output 'limit(1;
            .Tables[0].Rows[]|select(.instance|startswith("web")))|.ips'
    ):4443"
concourse_ca_cert="/tmp/test-concourse-ca-cert-$$"
credhub get --name "$cred_path/concourse-ca" --output-json | jq --raw-output '.value.certificate' > "$concourse_ca_cert"

fly login \
    --target test \
    --concourse-url "$concourse_url" \
    --username "$concourse_username" \
    --password "$concourse_password" \
    --ca-cert "$concourse_ca_cert"

fly --target test set-pipeline \
    --pipeline simple \
    --config test-pipeline-simple.yml \
    --non-interactive

fly --target test unpause-pipeline \
    --pipeline simple

build="$(
    fly --target test trigger-job \
        --job simple/hello-world \
        --verbose \
        2>&1 \
        | grep job_name \
        | jq --raw-output '.name'
    )"

fly --target test watch \
    --job simple/hello-world \
    --build "$build"
