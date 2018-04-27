# Provision BOSH Environment

For Control Plane for Pivotal Cloud Foundry

Set up your environment (perhaps in `.envrc` using [direnv][]):

```shell
export BBL_VSPHERE_VCENTER_IP=10.193.163.11
export BBL_VSPHERE_VCENTER_USER=administrator@vsphere.local
export BBL_VSPHERE_VCENTER_PASSWORD=REDACTED
export BBL_VSPHERE_VCENTER_DC=Datacenter
export BBL_VSPHERE_VCENTER_CLUSTER=Cluster
export BBL_VSPHERE_VCENTER_RP=ResourcePool
export BBL_VSPHERE_NETWORK='VM Network'
export BBL_VSPHERE_VCENTER_DS=LUN01
export BBL_VSPHERE_SUBNET=10.193.163.0/24
```

Configure the following according to your specific IaaS:

```
create-director-override.sh:  -v  internal_dns='[10.193.163.2]' \
create-jumpbox-override.sh:  -v  internal_dns="[10.193.163.2]" \
director-dns.yml:  value: [10.193.163.2]
static-ips.yml:  value: [10.193.163.16-10.193.163.29]
static-ips.yml:  value: [10.193.163.1-10.193.163.15,10.193.163.100-10.193.163.255]
```

Then provision: 

```shell
./provision-bosh-env.sh
```

[direnv]: https://direnv.net (direnv -- Unclutter your .profile)
