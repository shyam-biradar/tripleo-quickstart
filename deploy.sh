#!/bin/bash -x

export VIRTHOST=172.172.3.100

## Provision VMs

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr0
bash quickstart.sh -X -R rocky -e overcloud_full_root_pwd=test1234 --no-clone --tags all \
    --nodes custom/1ctlr_1comp.yml -p quickstart.yml $VIRTHOST
	
## Deploy undercloud
bash quickstart.sh -R rocky --no-clone --tags all --nodes custom/1ctlr_1comp.yml \
    -I --teardown none -p quickstart-extras-undercloud.yml $VIRTHOST

## 	Prepare for overcloud deployment
bash quickstart.sh -R rocky --no-clone --tags all --nodes custom/1ctlr_1comp.yml \
    -I --teardown none -p quickstart-extras-overcloud-prep.yml $VIRTHOST
	
## Deploy overcloud
bash quickstart.sh -R rocky --no-clone --tags all --nodes custom/1ctlr_1comp.yml \
    -I --teardown none -p quickstart-extras-overcloud.yml $VIRTHOST	
	
## Validate overcloud
bash quickstart.sh -R rocky --no-clone --tags all --nodes custom/1ctlr_1comp.yml \
    -I --teardown none -p quickstart-extras-validate.yml $VIRTHOST	
