ZeroVM gcc toolchain
=====
----
_How to build the full toolchain from scratch_

----

0. Install prerequisites:

    `sudo apt-get install libc6-dev-i386 libglib2.0-dev pkg-config git build-essential automake autoconf libtool g++-multilib texinfo flex bison groff gperf texinfo subversion`

    Install zeromq >= 3.2.4

    You can install it manually (don't forget to `sudo ldconfig` after install)

    or through these packages:

    `http://zvm.rackspace.com/v1/repo/ubuntu/pool/main/z/zeromq3/libzmq3_4.0.1-ubuntu1_amd64.deb`
    `http://zvm.rackspace.com/v1/repo/ubuntu/pool/main/z/zeromq3/libzmq3-dev_4.0.1-ubuntu1_amd64.deb`

    or by following the ZeroVM installation guide on http://zerovm.org/wiki/Download

1. Set up environment variables. You need to set them up prior to downloading and building anything.
    Or just set it up to the directories where you already downloaded/cloned.

    `ZEROVM_ROOT` - should point to git clone of `zerovm` repository

        export ZEROVM_ROOT=$HOME/zerovm

    `ZVM_PREFIX` - should point to an *empty writable directory*
    all files will be installed here after `make install`

        export ZVM_PREFIX=$HOME/zvm-root

    `ZRT_ROOT` - should point to git clone of `zrt` repository

        export ZRT_ROOT=$HOME/zrt

2. Clone things:

    <pre>
    git clone https://github.com/zerovm/zerovm.git $ZEROVM_ROOT
    git clone https://github.com/zerovm/validator.git $ZEROVM_ROOT/valz
    </pre>

    <pre>
    git clone https://github.com/zerovm/zrt.git $ZRT_ROOT
    </pre>

    <pre>
    git clone https://github.com/zerovm/toolchain.git $HOME/zvm-toolchain
    cd $HOME/zvm-toolchain/SRC
    git clone https://github.com/zerovm/linux-headers-for-nacl.git
    git clone https://github.com/zerovm/gcc.git
    git clone https://github.com/zerovm/glibc.git
    git clone https://github.com/zerovm/newlib.git
    git clone https://github.com/zerovm/binutils.git
    </pre>

3. Build zerovm

    <pre>
    cd $ZEROVM_ROOT/valz
    make validator
    sudo make install
    cd $ZEROVM_ROOT
    make all install PREFIX=$ZVM_PREFIX
    </pre>

4. Build toolchain

    <pre>
    cd $HOME/zvm-toolchain
    make -j8
    </pre>

    If something goes wrong you will need to DELETE everything (apart from zerovm and validator)
    in the $ZVM_PREFIX directory and only then do `make clean` and `make` (this is how the gcc toolchain works, sadly).

    Example of cleanup procedures:

    <pre>
    cd $HOME/zvm-toolchain
    make clean
    cd $ZVM_PREFIX
    rm -fr *
    cd $ZEROVM_ROOT
    make install PREFIX=$ZVM_PREFIX
    </pre>

5. Now you can run zerovm tests

    <pre>
    export PATH=$ZVM_PREFIX/bin:$PATH
    cd $ZEROVM_ROOT
    ./ftests.sh
    </pre>

6. Install debugger

    Debugger prerequisites:

    <pre>
    sudo apt-get install flex bison groff libncurses5-dev libexpat1-dev
    </pre>

    <pre>
    cd $HOME/zvm-toolchain/SRC
    git clone https://github.com/zerovm/gdb.git
    cd gdb
    mkdir BUILD
    cd BUILD
    ../configure --program-prefix=x86_64-nacl- --prefix=$ZVM_PREFIX
    make -j4
    make install
    </pre>
