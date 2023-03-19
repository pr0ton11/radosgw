#!/bin/env ash

ulimit -S 8096

exec radosgw \
    -c ${CEPH_CONFIG} \
    -i ${RADOSGW_ID} \
    -n ${RADOSGW_TYPE} \
    -d
