# syntax=docker/dockerfile:1.4

FROM quay.io/vexxhost/bindep-loci:latest AS bindep

FROM quay.io/vexxhost/openstack-builder-focal:latest AS builder
COPY --from=bindep --link /runtime-pip-packages /runtime-pip-packages

FROM quay.io/vexxhost/openstack-runtime-focal:4c527d0620405558f513ce89c297133151a34c31 AS runtime
COPY --from=bindep --link /runtime-dist-packages /runtime-dist-packages
COPY --from=builder --link /var/lib/openstack /var/lib/openstack
