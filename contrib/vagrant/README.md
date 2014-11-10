# ZeroVM toolchain appliance

This is self-contained development environment for cross-compiling applications
to run on ZeroVM. The environment is built using Vagrant and includes a working
modified NaCl toolchain and a freshly built zpython2 image.

## Installation

Setting up the virtual machine and compiling the toolchain and zpython2 will
take about 25-30 minutes on a modern machine.

### Ubuntu Linux 12.04

1. Install VirtualBox and Vagrant:

        sudo apt-get install virtualbox vagrant

2. Change into this directory (the one with `Vagrantfile`).

3. Run Vagrant:

        vagrant up


### OSX

1. Download and install VirtualBox and Vagrant from .dmgs. See https://www.virtualbox.org/wiki/Downloads
   and https://www.vagrantup.com/downloads.

2. Change into this directory (the one with `Vagrantfile`).

3. Run Vagrant:

        vagrant up
