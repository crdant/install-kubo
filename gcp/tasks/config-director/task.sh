#!/bin/bash

set -eu

git clone environment-state director-config

director_vars=director-config/director.yml
director_secrets=director-config/director-secrets.yml

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

pushd director-config
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_USER

git add -A
git commit -m "Added initial director configuration for ${KUBO_DIRECTOR_NAME}"
popd
