FROM centos:7

# Update image
RUN yum -y update && yum clean all

RUN export \
		MAKEFLAGS=-j$(nproc) \
		DEP='cyrus-sasl-plain cyrus-sasl-gssapi cyrus-sasl-md5' \
		BUILD_DEP='git make cmake gcc swig python-devel cyrus-sasl-devel openssl-devel libuuid-devel' \
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
	# qpid-proton master
	&& git clone https://github.com/apache/qpid-proton.git --depth 1 \
	# qpid-dispatch master
	&& git clone https://github.com/apache/qpid-dispatch.git --depth 1 \
	#
	# Prepare build dir
	&& mkdir -p /main/{libwebsockets,qpid-{dispatch,proton}}/build \
	#
	# Build libwebsockets
	&& cd /main/libwebsockets/build \
	&& cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DLWS_WITH_HTTP2=1 \
	&& cmake --build . --target install \
	#
	# Build Qpid Proton
	&& cd /main/qpid-proton/build \
	&& cmake .. \
		-DSYSINSTALL_BINDINGS=ON \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DSYSINSTALL_PYTHON=ON \
	&& cmake --build . --target install  \
	#
	# Build Qpid Dispatch
	&& cd /main/qpid-dispatch/build \
	&& cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DUSE_LIBWEBSOCKETS=ON \
		-DBUILD_DOCS=OFF \
	&& cmake --build . --target install \
	#
	# Clean image
	&& yum -y history undo 4 \
	&& yum -y clean all \
	&& rm -rf /var/cache/yum /main \
	&& rm -rf /usr/share/proton-0.24.0/examples /usr/lib/qpid-dispatch/tests

# Add qdrouterd group / user
RUN groupadd -r qdrouterd && useradd -r -d /var/lib/qdrouterd -m -g qdrouterd qdrouterd \
	&& chown -R qdrouterd.qdrouterd /var/lib/qdrouterd \
	&& cp /etc/qpid-dispatch/qdrouterd.conf /var/lib/qdrouterd/qdrouterd.conf \
	&& cp /etc/sasl2/qdrouterd.conf /var/lib/qdrouterd/sasl2.conf

USER qdrouterd:qdrouterd
VOLUME /var/lib/qdrouterd

# Expose port and run
EXPOSE 5672
CMD ["qdrouterd", "-c", "/var/lib/qdrouterd/qdrouterd.conf"]
