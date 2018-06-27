FROM rhmessagingqe/proton-lib:centos7

RUN export \
		MAKEFLAGS=-j$(nproc) \
		DEP='openssl cyrus-sasl-plain cyrus-sasl-gssapi cyrus-sasl-md5' \
		BUILD_DEP='git make cmake gcc swig python-devel cyrus-sasl-devel openssl-devel rpm-build libuuid-devel' \
		OTHER='valgrind' \
	#
	# Update latest
	&& yum -y --setopt=tsflag=nodocs install $DEP \
	&& yum -y --setopt=tsflag=nodocs install $BUILD_DEP $OTHER \
	#
	# Prepare sources
	&& mkdir -p /main && cd /main \
	# libwebsockets 2.4
	&& git clone https://github.com/warmcat/libwebsockets.git \
	&& cd /main/libwebsockets && git checkout v2.4-stable && cd /main \
	# qpid-dispatch master
	&& git clone https://github.com/apache/qpid-dispatch.git \
	#
	# Prepare build dir
	&& mkdir -p /main/{libwebsockets,qpid-dispatch}/build \
	#
	# Build libwebsockets
	&& cd /main/libwebsockets/build \
	&& cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DLWS_WITH_HTTP2=1 \
	&& cmake --build . --target install \
	#
	# Build Qpid Dispatch
	&& cd "/main/qpid-dispatch" \
  	&& echo "Dispatch commit:("$(git rev-list --count HEAD).$(git rev-parse --short HEAD)")" >> VERSION.txt \
  	&& cat /PROTON_VERSION.txt >> VERSION.txt \
	&& cd /main/qpid-dispatch/build \
	&& export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib \
	&& cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DUSE_LIBWEBSOCKETS=ON \
	&& cmake --build . --target install \
	#
	# Clean image
	&& yum -y history undo 7 \
	&& yum -y clean all \
	&& rm -rf /var/cache/yum /main

# Add qdrouterd group / user
RUN groupadd -r qdrouterd && useradd -r -d /var/lib/qdrouterd -m -g qdrouterd qdrouterd \
	&& cp /etc/qpid-dispatch/qdrouterd.conf /var/lib/qdrouterd/qdrouterd.conf \
	&& cp /etc/sasl2/qdrouterd.conf /var/lib/qdrouterd/sasl2.conf \
	&& chown -R qdrouterd.qdrouterd /var/lib/qdrouterd

USER qdrouterd:qdrouterd
VOLUME /var/lib/qdrouterd

# Expose port and run
EXPOSE 5672
CMD ["qdrouterd", "-c", "/var/lib/qdrouterd/qdrouterd.conf"]
