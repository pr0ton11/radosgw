# Dockerized Rados Gateway Container

This docker image can be used as an image for the Ceph Rados Gateway. It is based on Alpine Edge and always updates itself automatically on a release of the Ceph Rados Gateway Package in the Alpine Edge Repository.

<p align="center">
   <a aria-label="Latest Alpine Edge Ceph Rados GW Version" href="https://pkgs.alpinelinux.org/package/edge/community/x86_64/ceph17-radosgw" target="_blank">
    <img alt="Latest Alpine Edge Ceph Rados GW Version" src="https://img.shields.io/github/v/release/pr0ton11/radosgw?color=success&display_name=tag&label=latest&logo=docker&logoColor=%23fff&sort=semver&style=flat-square">
  </a>
<a aria-label="Latest docker build" href="https://github.com/pr0ton11/radosgw/pkgs/container/radosgw" target="_blank">
    <img alt="Latest docker build" src="https://github.com/pr0ton11/radosgw/actions/workflows/build.yml/badge.svg">
  </a>
</p>

## Configuration

All configuration values can be set by changing environment variables. In the Dockerfile, the defaults are set.

### Important configuration
The following configuration should be changed for your enviroment

```
CEPH_CLUSTER_NAME:  Name of your ceph cluster (default: ceph)
RADOSGW_ID:  ID of your Rados Gateway (adds a suffix within the ceph cluster) (default: 1)
RADOSGW_TYPE:  Name of your client for the Rados Gatway (default: client.radosgw.gateway)
RADOSGW_REGION:  Region of your Rados Gateway (default: default)
RADOSGW_ZONE:  Zone of your Rados Gateway (default: default)
```

### Additional configuration
```
CEPH_CONFIG:  Path to your ceph.conf within your container (default: /etc/ceph/ceph.conf)
```

### Using Ceph CFT

Since release 18.2.2-r5 you can utilize the [Ceph CFT](https://github.com/pr0ton11/ceph-cft) tool, which is embedded into this image.

It allows to configure your ceph cluster with environment variables:

Example:

```
CEPH_GLOBAL_LOG_FILE='/var/log/ceph/$cluster-$type.$id.log'
CEPH_OSD_OP_QUEUE=wpq
CEPH_MON_LOG_TO_SYSLOG=true
CEPH_TEST_WITHOUT_SECTION=works
CEPH_CONTAINS_WHITESPACES="Hello World"
CEPH_OSD__1_OBJECTER_INFLIGHT_OPS=512
```

```
[global]
log_file             = /var/log/ceph/$cluster-$type.$id.log
test_without_section = works
contains_whitespaces = "hello world"

[osd]
op_queue = wpq

[mon]
log_to_syslog = true

[osd.1]
objecter_inflight_ops = 512
```


## How to use this image

This image can be used as a normal docker image with the following tag

```
ghcr.io/pr0ton11/radosgw:latest
```

For example you could pull the image by:

```
docker pull ghcr.io/pr0ton11/radosgw:latest
```
