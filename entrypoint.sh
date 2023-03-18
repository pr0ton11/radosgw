#!/bin/env ash

ulimit -S 8096

radosgw \
    -c ${CEPH_CONFIG} \
    -i ${RADOSGW_ID} \
    -d
