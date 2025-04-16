FROM rockylinux:8

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="bdwyertech/el8-xc" \
    org.opencontainers.image.version=$VCS_REF\
    org.opencontainers.image.description="For cross compiling for arm64" \
    org.opencontainers.image.authors="Brian Dwyer <bdwyertech@github.com>" \
    org.opencontainers.image.url="https://hub.docker.com/r/bdwyertech/centos-xc" \
    org.opencontainers.image.source="https://github.com/bdwyertech/docker-centos-xc.git" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE \
    org.label-schema.name="bdwyertech/el8-xc" \
    org.label-schema.description="For cross-compiling for arm64" \
    org.label-schema.url="https://hub.docker.com/r/bdwyertech/centos-xc" \
    org.label-schema.vcs-url="https://github.com/bdwyertech/docker-centos-xc.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.build-date=$BUILD_DATE

WORKDIR /build

COPY setup.sh .

RUN yum update -y ca-certificates \
    && yum install -y epel-release \
    && yum install -y gcc gcc-c++ lbzip2 make wget \
    && bash -c "LINUX_KERNEL_VERSION='linux-3.16.85' \
    GCC_VERSION='gcc-4.8.5' \
    GLIBC_VERSION='glibc-2.17' \
    BINUTILS_VERSION='binutils-2.27' \
    ./setup.sh" \
    && rm -rf /build/* \
    && yum erase -y epel-release gcc gcc-c++ lbzip2 make wget \
    && yum clean all

ENV PATH="/opt/cross/bin:${PATH}"
