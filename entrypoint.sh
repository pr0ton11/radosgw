#!/bin/env ash

# Execute the ceph-cft tool to generate the configuration file based on the environment variables
ceph-cft

ulimit -S 8096

exec radosgw \
    -c ${CEPH_CONFIG} \
    -i ${RADOSGW_ID} \
    -n ${RADOSGW_TYPE} \
    -d
