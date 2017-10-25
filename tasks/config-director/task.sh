#!/bin/bash

set -eu

director_vars=environment-state/director.yml
director_secrets=environment-state/director-secrets.yml
bosh_creds=environment-state/creds.yml
bosh_state=environment-state/state.json

cat <<VARIABLES > ${director_vars}
vcenter_ip: ${VCENTER_HOST}
vcenter_user: ${VCENTER_USER}
vcenter_dc: ${VCENTER_DATACENTER}
vcenter_vms: ${KUBO_VM_FOLDER}
vcenter_templates: ${KUBO_TEMPLATES}
vcenter_disks: ${KUBO_DISK_PATH}
vcenter_ds: ${KUBO_EPHEMERAL_STORE}
vcenter_cluster: ${VCENTER_CLUSTER}
vcenter_rp: ${VCENTER_RESOURCE_POOL}

internal_ip: ${DIRECTOR_IP}
deployments_network: ${VSPHERE_NETWORK}
internal_cidr: ${NETWORK_CIDR}
internal_gw: ${GATEWAY}
director_name: ${KUBO_DIRECTOR_NAME}
dns_recursor_ip: ${DNS}
kubo_release_url: https://storage.googleapis.com/kubo-public/kubo-release-latest.tgz

network_name: ${VSPHERE_NETWORK}
reserved_ips: ${EXCLUDED_RANGE}

iaas: vsphere
VARIABLES

cat <<SECRETS > ${director_secrets}
vcenter_password: ${VCENTER_PASSWORD}
SECRETS

cp ${director_vars} director-config
cp ${director_secrets} director-config

if [ -f "${bosh_state}" ] ; then
  cp ${bosh_state} director-config
fi

if [ -f "${bosh_creds}" ] ; then
  cp ${bosh_creds} director-config
fi
