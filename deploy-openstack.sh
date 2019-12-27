#!/bin/bash -x

export VIRTHOST=172.172.3.100
export OPENSTACK_RELEASE="rocky"
export NODES_CONFIG_FILE="trilio/1ctlr_1comp.yml"

## Provision VMs

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr0
bash quickstart.sh -X -R $OPENSTACK_RELEASE --no-clone --tags all \
    --nodes $NODES_CONFIG_FILE -p quickstart.yml $VIRTHOST
	
## Deploy undercloud
bash quickstart.sh -R $OPENSTACK_RELEASE --no-clone --tags all --nodes $NODES_CONFIG_FILE \
    -I --teardown none -p quickstart-extras-undercloud.yml $VIRTHOST

## 	Prepare for overcloud deployment
bash quickstart.sh -R $OPENSTACK_RELEASE --no-clone --tags all --nodes $NODES_CONFIG_FILE \
    -I --teardown none -p quickstart-extras-overcloud-prep.yml $VIRTHOST
	
## Deploy overcloud
bash quickstart.sh -R $OPENSTACK_RELEASE --no-clone --tags all --nodes $NODES_CONFIG_FILE \
    -I --teardown none -p quickstart-extras-overcloud.yml $VIRTHOST	
	
## Validate overcloud
bash quickstart.sh -R $OPENSTACK_RELEASE --no-clone --tags all --nodes $NODES_CONFIG_FILE \
    -I --teardown none -p quickstart-extras-validate.yml $VIRTHOST	
