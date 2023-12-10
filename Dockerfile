# Reference: https://docs.ceph.com/en/latest/man/8/radosgw/

ARG ALPINE_VERSION=edge

FROM alpine:${ALPINE_VERSION}

ARG CEPH_RGW_PACKAGE=ceph18-radosgw

# Installation of packages
RUN echo ${CEPH_RGW_PACKAGE}
RUN apk add --no-cache ${CEPH_RGW_PACKAGE}

# Configuration
ENV CEPH_CONFIG /etc/ceph/ceph.conf
ENV CEPH_CLUSTER_NAME ceph
ENV RADOSGW_ID 0
ENV RADOSGW_TYPE client.radosgw.gateway
ENV RADOSGW_REGION default
ENV RADOSGW_ZONE default

# Ceph configuration to mount
VOLUME [ "/etc/ceph/ceph.conf" ]

# Entrypoint
COPY --chown=root:root entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/ash", "/entrypoint.sh" ]
