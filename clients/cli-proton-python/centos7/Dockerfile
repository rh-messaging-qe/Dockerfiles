FROM rhmessagingqe/proton-lib:centos7

RUN export \
        MAKEFLAGS=-j$(nproc) \
		DEP='python-pip python-wheel python-setuptools' \
		BUILD_DEP='git gcc python-devel openssl-devel cyrus-sasl-devel cyrus-sasl-plain' \
		OTHER='valgrind' \
	#
	# Update latest
	&& yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
	&& yum -y install $DEP \
	&& yum -y install $BUILD_DEP \
	#
	# Prepare sources
    && mkdir -p /main && cd /main \
	&& git clone https://github.com/rh-messaging/cli-proton-python.git --depth 1 \
	# Build Qpid Proton
	&& cd /main/cli-proton-python \
	&& python setup.py install \
	#
	# Clean image
	#&& yum -y history undo 8 \
	#&& yum -y history undo 7 \
	&& yum -y clean all \
	&& rm -rf /var/cache/yum /main

# Add qdrouterd group / user
RUN groupadd -r cli-proton-python && useradd -r -d /var/lib/cli-proton-python -m -g cli-proton-python cli-proton-python \
	&& chown -R cli-proton-python.cli-proton-python /var/lib/cli-proton-python

USER cli-proton-python:cli-proton-python
VOLUME /var/lib/cli-proton-python
WORKDIR /var/lib/cli-proton-python

CMD [ "/bin/bash" ]
