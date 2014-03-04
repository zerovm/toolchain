ZeroVM gcc toolchain
=====
----
_How to build the full toolchain from scratch_

----

Install Prerequisites
---------------------

### Ubuntu 12.04

Toolchain requires multiple dependencies, including
[zerovm-zmq-dev](http://github.com/zerovm/zerovm). To install `zerovm-zmq-dev`,
first choose from one of the following PPAs:

- Latest: [ppa:zerovm-ci/zerovm-latest](https://launchpad.net/~zerovm-ci/+archive/zerovm-latest)
- Stable: [ppa:zerovm-ci/zerovm-stable](https://launchpad.net/~zerovm-ci/+archive/zerovm-stable)

Add the PPA to your sources list:

    sudo apt-get install python-software-properties
    sudo add-apt-reposistory ppa:zerovm-ci/zerovm-latest
    # or 'sudo add-apt-repository ppa:zerovm-ci/zerovm-stable'
    sudo apt-get update

Install dependencies:

    sudo apt-get install libc6-dev-i386 libglib2.0-dev pkg-config git \
        build-essential automake autoconf libtool g++-multilib texinfo \
        flex bison groff gperf texinfo subversion \
        zerovm-zmq-dev

Setup Environment Variables
----------------------------

You need to set them up prior to building anything. We'll use the
following variables:

* `ZVM_PREFIX`: should point to an *empty writable directory* all
    files will be installed here after `make install`
* `ZRT_ROOT`: should point to git clone of `zrt` repository
* `LD_LIBRARY_PATH`: library path for libvalidator.so (from
  [zvm-validator](https://github.com/zerovm/validator))
* `CPATH`: include directory containing `zvm.h` (from `zerovm-zmq-dev`)

We will use these values for this guide:

    export ZVM_PREFIX=$HOME/zvm-root
    export ZRT_ROOT=$HOME/zrt
    export LD_LIBRARY_PATH=/usr/lib64
    export CPATH=/usr/x86_64-nacl/include

Clone Things
------------

    git clone https://github.com/zerovm/zrt.git $ZRT_ROOT

    git clone https://github.com/zerovm/toolchain.git $HOME/zvm-toolchain
    cd $HOME/zvm-toolchain/SRC
    git clone https://github.com/zerovm/linux-headers-for-nacl.git
    git clone https://github.com/zerovm/gcc.git
    git clone https://github.com/zerovm/glibc.git
    git clone https://github.com/zerovm/newlib.git
    git clone https://github.com/zerovm/binutils.git

Build Toolchain
---------------

    cd $HOME/zvm-toolchain
    make -j8 ZEROVM=`which zerovm`  # e.g., '/usr/bin/zerovm'

If something goes wrong you will need to *delete* everything
(apart from zerovm and validator) in the $ZVM_PREFIX directory and
only then do `make clean` and `make` (this is how the gcc
toolchain works, sadly).

Example of cleanup procedures:

    cd $HOME/zvm-toolchain
    make clean
    cd $ZVM_PREFIX
    rm -rf *
    cd $ZEROVM_ROOT
    make install PREFIX=$ZVM_PREFIX

Install Debugger
----------------

Debugger prerequisites:

    sudo apt-get install flex bison groff libncurses5-dev libexpat1-dev

    cd $HOME/zvm-toolchain/SRC
    git clone https://github.com/zerovm/gdb.git
    cd gdb
    mkdir BUILD
    cd BUILD
    ../configure --program-prefix=x86_64-nacl- --prefix=$ZVM_PREFIX
    make -j4
    make install
