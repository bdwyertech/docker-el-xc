FROM rockylinux:8 as build

WORKDIR /build

RUN dnf update -y ca-certificates \
    && dnf install -y automake bison bzip2 diffutils file findutils flex gcc gcc-c++ git libtool make ncurses-devel patch unzip wget which xz \
    && dnf install -y help2man texinfo --enablerepo=powertools \
    && git clone https://github.com/crosstool-ng/crosstool-ng -b crosstool-ng-1.27.0 \
    && cd crosstool-ng && ./bootstrap \
    && ./configure \
    && make \
    && make install \
    && cd .. && rm -rf crosstool-ng

COPY crosstool.config .config

RUN ct-ng upgradeconfig

RUN CT_ALLOW_BUILD_AS_ROOT_SURE=y ct-ng build

FROM rockylinux:8

ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="bdwyertech/el8-xc" \
    org.opencontainers.image.version=$VCS_REF\
    org.opencontainers.image.description="For cross compiling for arm64" \
    org.opencontainers.image.authors="Brian Dwyer <bdwyertech@github.com>" \
    org.opencontainers.image.url="https://hub.docker.com/r/bdwyertech/el-xc" \
    org.opencontainers.image.source="https://github.com/bdwyertech/docker-el-xc.git" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE \
    org.label-schema.name="bdwyertech/el8-xc" \
    org.label-schema.description="For cross-compiling for arm64" \
    org.label-schema.url="https://hub.docker.com/r/bdwyertech/el-xc" \
    org.label-schema.vcs-url="https://github.com/bdwyertech/docker-el-xc.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.build-date=$BUILD_DATE

RUN dnf update -y && dnf install -y findutils --setopt=keepcache=0 && dnf clean all

COPY --from=build /opt/cross /opt/cross

ENV PATH="/opt/cross/bin:${PATH}"


# CT_LOCAL_TARBALLS_DIR="/build/src"  # Where downloaded source packages are stored
# CT_WORK_DIR="/build/work"          # Where the build happens
# CT_PREFIX_DIR="/opt/cross"         # Where the toolchain is installed
# CT_PREFIX_DIR_RO=n                 # Allow write access to the toolchain