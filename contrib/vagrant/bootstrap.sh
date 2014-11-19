#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:zerovm-ci/zerovm-latest -y
sudo apt-get update

WORKSPACE=$HOME/toolchain
DEPS="libc6-dev-i386 libglib2.0-dev pkg-config git"
DEPS="$DEPS build-essential automake autoconf libtool g++-multilib texinfo"
DEPS="$DEPS flex bison groff gperf texinfo subversion zerovm-zmq-dev"

sudo apt-get install $DEPS -y

# set up env (ZVM_PREFIX, ZRT_ROOT, etc.)
source /vagrant/toolchainrc

git clone https://github.com/zerovm/zrt.git $ZRT_ROOT
# Copy the current clone of toolchain from the shared dir to another working
# directory
rsync -az --exclude=contrib/vagrant/.* /host-workspace/ $WORKSPACE
cd $WORKSPACE/SRC
git clone https://github.com/zerovm/linux-headers-for-nacl.git
git clone https://github.com/zerovm/gcc.git
git clone https://github.com/zerovm/glibc.git
git clone https://github.com/zerovm/newlib.git
git clone https://github.com/zerovm/binutils.git

######################
# Build the toolchain:
cd $WORKSPACE
# this will take a while; usually about 25-30 minutes
make -j8 ZEROVM=`which zerovm`  # e.g., '/usr/bin/zerovm'

#################
# Build zpython2:
ZEROVM_PORTS=$HOME/zerovm-ports
git clone https://github.com/zerovm/zpython2 $ZPYTHON_ROOT
git clone https://github.com/zerovm/zerovm-ports $ZEROVM_PORTS
# First, we need a couple of libraries in order to build zpython
# (zlib, bzip2, and libffi)

# build/install zlib
cd $ZEROVM_PORTS/zlib
wget http://zlib.net/zlib-1.2.8.tar.gz
tar xf zlib-1.2.8.tar.gz
cd zlib-1.2.8
CC=x86_64-nacl-gcc ./configure --prefix=${ZVM_PREFIX}/x86_64-nacl
make
make install

# build/install bzip2:
cd $ZEROVM_PORTS/bzip2
wget http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz
tar xf bzip2-1.0.6.tar.gz
cd bzip2-1.0.6
patch -p0 < ../Makefile.patch
make
make install

# build/install libffi:
git clone https://github.com/zerovm/libffi $HOME/libffi
cd $HOME/libffi
./configure --host=x86_64-nacl --prefix=$ZVM_PREFIX/x86_64-nacl
make
make install
