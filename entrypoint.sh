#!/bin/env ash

radosgw \
    -c ${CEPH_CONFIG} \
    --cluster ${CEPH_CLUSTER_NAME} \
    -i ${RADOSGW_ID} \
    -n ${RADOSGW_TYPE} \
    --rgw-region ${RADOSGW_REGION}
    --rgw-zone ${RADOSGW_ZONE}
    -d
