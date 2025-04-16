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

RUN dnf update -y ca-certificates \
    && dnf install -y epel-release \
    && dnf install -y automake bc bison diffutils elfutils-libelf-devel file flex gcc gcc-c++ git glibc-devel \
    gmp-devel lbzip2 libmpc-devel make mpfr-devel ncurses-devel patch perl pkgconfig rsync \
    wget xz \
    && yum install -y texinfo --enablerepo=powertools \
    && bash -c "LINUX_KERNEL_VERSION='linux-4.18.20' \
    GCC_VERSION='gcc-8.4.0' \
    GLIBC_VERSION='glibc-2.28' \
    BINUTILS_VERSION='binutils-2.30' \
    ./setup.sh" \
    && rm -rf /build/* \
    && dnf erase -y automake bison diffutils epel-release flex gcc gcc-c++ gmp-devel lbzip2 libmpc-devel \
    make mpfr-devel ncurses-devel patch perl pkgconfig texinfo wget \
    && dnf clean all

ENV PATH="/opt/cross/bin:${PATH}"