# syntax=docker/dockerfile-upstream:master-labs

ARG BUILDER_IMAGE=quay.io/vexxhost/openstack-builder-focal
ARG RUNTIME_IMAGE=quay.io/vexxhost/openstack-runtime-focal

FROM quay.io/vexxhost/bindep-loci:latest AS bindep

FROM ${BUILDER_IMAGE}:c4b9bf2fae0fe7b1c12b0425f23c6f411bc024d8 AS builder
COPY --from=bindep --link /runtime-pip-packages /runtime-pip-packages

FROM ${RUNTIME_IMAGE}:39f07fafef2bb38f87cc806a8b6f60c816e6698b AS runtime
COPY --from=bindep --link /runtime-dist-packages /runtime-dist-packages
COPY --from=builder --link /var/lib/openstack /var/lib/openstack
