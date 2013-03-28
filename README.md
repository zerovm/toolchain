ZeroVM gcc toolchain
=====
----
_How to build the full toolchain from scratch_

----

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
    git clone https://github.com/zerovm/bintools.git
    </pre>

3. Build zerovm

    <pre>
    cd $ZEROVM_ROOT/valz
    make validator install
    cd $ZEROVM_ROOT
    make all install
    </pre>

4. Build toolchain

    <pre>
    cd $HOME/zvm-toolchain
    make -j8
    make install
    </pre>
    
    If something goes wrong you will need to DELETE everything (apart from zerovm and validator) 
    in the $ZVM_PREFIX directory and only then do `make clean` and `make` (this is how the gcc toolchain works, sadly).

