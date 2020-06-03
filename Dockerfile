FROM centos:7

WORKDIR /build

COPY setup.sh .

RUN yum install -y epel-release \
    && yum install -y gcc gcc-c++ lbzip2 make wget \
    && bash setup.sh \
    && rm -rf /build/* \
    && yum erase -y epel-release gcc gcc-c++ lbzip2 make wget
