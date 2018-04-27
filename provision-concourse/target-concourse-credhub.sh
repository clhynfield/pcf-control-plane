: "${BBL_STATE_DIRECTORY:=../bbl-state}"
: "${BBL_ENV_NAME:=control-plane}"

cred_path="/bosh-$BBL_ENV_NAME/concourse"
credhub_config="$HOME/.credhub/config.json"

eval "$(bbl print-env)"

if [ -f "$credhub_config" ]; then
    rm "$credhub_config"
fi

CREDHUB_CA_CERT="$(
    credhub get -n $cred_path/atc_tls -j \
        | jq -r '.value.ca'
    )"
CREDHUB_SECRET="$(
    credhub get -n $cred_path/concourse_to_credhub_secret -j \
        | jq -r '.value'
    )"
CREDHUB_SERVER="$(
    bosh --deployment concourse --json instances \
        | jq --raw-output 'limit(1;
            .Tables[0].Rows[]|select(.instance|startswith("web")))|.ips'
    ):8844"
CREDHUB_CLIENT=concourse_to_credhub

unset CREDHUB_USER CREDHUB_PASSWORD
export CREDHUB_CLIENT CREDHUB_CA_CERT CREDHUB_SECRET CREDHUB_SERVER
credhub api
