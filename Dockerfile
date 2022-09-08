# syntax=docker/dockerfile:1.4

FROM quay.io/vexxhost/bindep-loci:latest AS bindep

FROM quay.io/vexxhost/openstack-builder-focal:latest AS builder
COPY --from=bindep --link /runtime-pip-packages /runtime-pip-packages

FROM quay.io/vexxhost/openstack-runtime-focal:58ed2e86aace994854ebef3f0033cb7f73ac63b2 AS runtime
COPY --from=bindep --link /runtime-dist-packages /runtime-dist-packages
COPY --from=builder --link /var/lib/openstack /var/lib/openstack
