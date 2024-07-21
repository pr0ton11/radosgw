# Reference: https://docs.ceph.com/en/latest/man/8/radosgw/

ARG ALPINE_VERSION=edge

FROM ghcr.io/pr0ton11/ceph-cft:main as cft
FROM alpine:${ALPINE_VERSION}

ARG CEPH_RGW_PACKAGE=ceph18-radosgw

# Install ceph-cft
COPY --from=cft --chown=root:root /app/ceph-cft /usr/local/bin/ceph-cft
RUN chmod +x /usr/local/bin/ceph-cft

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

# Entrypoint
COPY --chown=root:root entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/ash", "/entrypoint.sh" ]
