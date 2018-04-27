: "${BBL_STATE_DIRECTORY:=../bbl-state}"
: "${BBL_ENV_NAME:=control-plane}"

eval "$(bbl print-env)"

rm "$HOME/.credhub/config.json"


export CREDHUB_CLIENT=concourse_to_credhub
export CREDHUB_CA_CERT="$(credhub get -n /bosh-$BBL_ENV_NAME/concourse/atc_tls -j | jq -r '.value.ca')"
export CREDHUB_SECRET="$(credhub get -n /bosh-$BBL_ENV_NAME/concourse/concourse_to_credhub_secret -j | jq -r .value)"
export CREDHUB_SERVER="10.39.28.15:8844"
credhub api

unset CREDHUB_USER
unset CREDHUB_PASSWORD
