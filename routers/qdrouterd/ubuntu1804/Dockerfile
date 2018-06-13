FROM ubuntu:bionic
MAINTAINER "Dominik Lenoch" <dlenoch@redhat.com>

# Update image
RUN apt-get update -y && apt-get clean && apt-get autoclean -y && apt-get autoremove -y

RUN export \
			MAKEFLAGS=-j$(nproc) \
			DEP='libsasl2-2 libsasl2-modules libsasl2-modules-gssapi-heimdal libsasl2-modules-ldap' \
			BUILD_DEP='git make cmake gcc zlib1g-dev swig python-dev libssl-dev libev-dev libuv1-dev libsasl2-dev uuid-dev' \
			OTHER='valgrind' \
	#
	# Update latest
	&& apt-get install -y $DEP \
	&& apt-get install -y $BUILD_DEP $OTHER \
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
	#&& mkdir -p /main/{libwebsockets,qpid-{dispatch,proton}}/build \
	#
	# Build libwebsockets
	&& mkdir -p /main/libwebsockets/build && cd /main/libwebsockets/build \
	&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DLWS_WITH_HTTP2=1 \
	&& make && make install \
	#
	# Build Qpid Proton
	&& mkdir -p /main/qpid-proton/build && cd /main/qpid-proton/build \
	&& cmake .. -DSYSINSTALL_BINDINGS=ON -DCMAKE_INSTALL_PREFIX=/usr -DSYSINSTALL_PYTHON=ON \
	&& cmake --build . --target install  \
	#
	# Build Qpid Dispatch
	&& mkdir -p /main/qpid-dispatch/build && cd /main/qpid-dispatch/build \
	&& cmake .. \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DUSE_LIBWEBSOCKETS=ON \
		-DBUILD_DOCS=OFF \
	&& cmake --build . --target install \
	#
	# Clean
	&& apt-get remove -y $BUILD_DEP $OTHER \
	&& apt-get clean \
	&& apt-get autoclean -y && apt-get autoremove -y \
	&& rm -rf /main \
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
