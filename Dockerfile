FROM centos:7

RUN yum install -y epel-release \
	&& yum install -y gcc lbzip2 wget

COPY setup.sh .

RUN bash setup.sh
