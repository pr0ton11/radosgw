# Reference: https://docs.ceph.com/en/latest/man/8/radosgw/

ARG ALPINE_VERSION edge
ARG CEPH_RGW_PACKAGE ceph17-radosgw

FROM alpine:${ALPINE_VERSION}

# Installation of packages
RUN apk add --no-cache ${CEPH_RGW_PACKAGE}

# Configuration
ENV CEPH_CONFIG /etc/ceph/ceph.conf
ENV CEPH_CLUSTER_NAME ceph
ENV RADOSGW_ID 1
ENV RADOSGW_TYPE client.radosgw.gateway
ENV RADOSGW_REGION default
ENV RADOSGW_ZONE default

# Ceph configuration to mount
VOLUME [ "/etc/ceph/ceph.conf" ]

# Entrypoint
COPY --chown=root:root entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
