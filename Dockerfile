ARG ALPINE_VERSION edge
ARG CEPH_RGW_PACKAGE ceph17-radosgw

FROM alpine:${ALPINE_VERSION}

# Installation of packages
RUN apk add --no-cache ${CEPH_RGW_PACKAGE}

# Entrypoint
COPY --chown=root:root entrypoint.sh /entrypoint.sh

# Ceph configuration to mount
VOLUME [ "/etc/ceph/ceph.conf" ]
