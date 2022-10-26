# syntax=docker/dockerfile-upstream:master-labs

FROM quay.io/vexxhost/bindep-loci:latest AS bindep

FROM quay.io/vexxhost/openstack-builder-focal:5b36c8ca71f52dafacafc8b65715d3a82943e0b4 AS builder
COPY --from=bindep --link /runtime-pip-packages /runtime-pip-packages

FROM quay.io/vexxhost/openstack-runtime-focal:9138ca743e114e4688ed9c2757307fb2ea1d0b74 AS runtime
COPY --from=bindep --link /runtime-dist-packages /runtime-dist-packages
COPY --from=builder --link /var/lib/openstack /var/lib/openstack
