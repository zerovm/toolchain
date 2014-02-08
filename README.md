ZeroVM gcc toolchain
=====
----
_How to build the full toolchain from scratch_

----

Install Prerequisites
---------------------

On Debian and Ubuntu, you will want to install these packages:

    sudo apt-get install libc6-dev-i386 libglib2.0-dev pkg-config git \
        build-essential automake autoconf libtool g++-multilib texinfo \
        flex bison groff gperf texinfo subversion

Install ZeroMQ version 3.2.4 or greater. You can either install it
through these packages:

    http://packages.zerovm.org/apt/ubuntu/pool/main/z/zeromq3/libzmq3_4.0.1-ubuntu1_amd64.deb
    http://packages.zerovm.org/apt/ubuntu/pool/main/z/zeromq3/libzmq3-dev_4.0.1-ubuntu1_amd64.deb

or you can install it manually (don't forget to `sudo ldconfig`
after install) by following the
[ZeroMQ installation guide](http://zeromq.org/area:download).

Setup Environment Variables
----------------------------

You need to set them up prior to building anything. We'll use the
following variables:

* `ZEROVM_ROOT`: should point to git clone of `zerovm` repository
* `ZVM_PREFIX`: should point to an *empty writable directory* all
    files will be installed here after `make install`
* `ZRT_ROOT`: should point to git clone of `zrt` repository

We will use these values for this guide:

    export ZEROVM_ROOT=$HOME/zerovm
    export ZVM_PREFIX=$HOME/zvm-root
    export ZRT_ROOT=$HOME/zrt

Clone Things
------------

    git clone https://github.com/zerovm/validator.git $HOME/validator
    git clone https://github.com/zerovm/zerovm.git $ZEROVM_ROOT

    git clone https://github.com/zerovm/zrt.git $ZRT_ROOT

    git clone https://github.com/zerovm/toolchain.git $HOME/zvm-toolchain
    cd $HOME/zvm-toolchain/SRC
    git clone https://github.com/zerovm/linux-headers-for-nacl.git
    git clone https://github.com/zerovm/gcc.git
    git clone https://github.com/zerovm/glibc.git
    git clone https://github.com/zerovm/newlib.git
    git clone https://github.com/zerovm/binutils.git

Build Validator
---------------

    cd $HOME/validator
    make validator
    make install PREFIX=$ZVM_PREFIX

A library was installed in `$ZVM_PREFIX/lib`, so you will want to set
`LD_LIBRARY_PATH` or install the library globally. We'll just continue
with the library path set:

    export LD_LIBRARY_PATH=$ZVM_PREFIX/lib

Build ZeroVM
------------

    cd $ZEROVM_ROOT
    make all install PREFIX=$ZVM_PREFIX

Build Toolchain
---------------

    cd $HOME/zvm-toolchain
    make -j8

If something goes wrong you will need to *delete* everything
(apart from zerovm and validator) in the $ZVM_PREFIX directory and
only then do `make clean` and `make` (this is how the gcc
toolchain works, sadly).

Example of cleanup procedures:

    cd $HOME/zvm-toolchain
    make clean
    cd $ZVM_PREFIX
    rm -fr *
    cd $ZEROVM_ROOT
    make install PREFIX=$ZVM_PREFIX

Now you can run zerovm tests

    export PATH=$ZVM_PREFIX/bin:$PATH
    cd $ZEROVM_ROOT
    ./ftests.sh

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
