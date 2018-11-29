FROM centos:7

# Update image
RUN yum -y update && yum clean all

WORKDIR /main

RUN export \
        MAKEFLAGS=-j$(nproc) \
		DEP='cyrus-sasl-plain cyrus-sasl-gssapi cyrus-sasl-md5' \
		BUILD_DEP='git make cmake gcc gcc-c++ swig python-devel cyrus-sasl-devel openssl-devel libuuid-devel' \
	# Update latest
	&& yum -y install $DEP \
	&& yum -y install $BUILD_DEP \
	#
	# qpid-proton master
    && git clone https://github.com/apache/qpid-proton.git --depth 1 \
	#
	# Build Qpid Proton
	&& mkdir -p /main/qpid-proton/build && cd /main/qpid-proton/build \
	&& cmake .. -DSYSINSTALL_BINDINGS=ON -DCMAKE_INSTALL_PREFIX=/usr -DSYSINSTALL_PYTHON=ON \
	&& cmake --build . --target install \
	&& cd "/main/qpid-proton" \
  	&& echo "Proton commit:("$(git rev-list --count HEAD).$(git rev-parse --short HEAD)")" >> /PROTON_VERSION.txt \
	#
	# Clean image
	&& yum -y history undo 4 \
	&& yum -y clean all \
	&& rm -rf /var/cache/yum /main \
	&& rm -rf /usr/share/proton-*/examples

WORKDIR /
