# syntax=docker/dockerfile-upstream:master-labs

ARG BUILDER_IMAGE
ARG RUNTIME_IMAGE

FROM quay.io/vexxhost/bindep-loci:latest AS bindep

FROM ${BUILDER_IMAGE} AS builder
COPY --from=bindep --link /runtime-pip-packages /runtime-pip-packages

FROM ${RUNTIME_IMAGE} AS runtime
COPY --from=bindep --link /runtime-dist-packages /runtime-dist-packages
COPY --from=builder --link /var/lib/openstack /var/lib/openstack
