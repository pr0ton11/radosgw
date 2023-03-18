#!/bin/env ash

radosgw \
    -c ${CEPH_CONFIG} \
    -i ${RADOSGW_ID} \
    -d
