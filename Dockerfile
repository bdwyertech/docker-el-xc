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
    && yum install -y automake bison flex gcc gcc-c++ gmp-devel mpfr-devel libmpc-devel \
    lbzip2 make ncurses-devel patch perl pkgconfig wget xz \
    glibc-devel elfutils-libelf-devel file rsync bc git \
    && yum install -y texinfo --enablerepo=powertools \
    && bash -c "LINUX_KERNEL_VERSION='linux-4.18.20' \
    GCC_VERSION='gcc-8.4.0' \
    GLIBC_VERSION='glibc-2.28' \
    BINUTILS_VERSION='binutils-2.30' \
    ./setup.sh" \
    && rm -rf /build/* \
    && yum erase -y automake bison epel-release flex gcc gcc-c++ gmp-devel mpfr-devel libmpc-devel \
    lbzip2 make ncurses-devel patch perl pkgconfig texinfo wget \
    && yum clean all

ENV PATH="/opt/cross/bin:${PATH}"