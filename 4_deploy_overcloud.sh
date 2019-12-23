#!/bin/bash -x

export VIRTHOST=172.172.3.100

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr0

## Deploy overcloud
bash quickstart.sh -R rocky --no-clone --tags all --nodes custom/1ctlr_1comp.yml \
    -I --teardown none -p quickstart-extras-overcloud.yml $VIRTHOST
