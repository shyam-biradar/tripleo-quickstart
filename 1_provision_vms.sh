#!/bin/bash -x

export VIRTHOST=172.172.3.100

export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr0

bash quickstart.sh -X -R rocky --no-clone --tags all \
    --nodes custom/1ctlr_1comp.yml -p quickstart.yml $VIRTHOST
