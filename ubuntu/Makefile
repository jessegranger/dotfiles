all: packages /src gcc node vim git fish mosh libdb zcash nheqminer cpuminer ansible

PACKAGES=

include Makefile.*

packages:
	# Checking for bootstrap packages...
	@[ -e `which apt` ] && sudo apt -qqq install -y \
		build-essential autoconf automake make git \
		stow wget curl apt-transport-https \
		exfat-fuse exfat-utils \
		python-qt4 python-pip \
		unzip screen gpp par htop ${PACKAGES}

/src:
	# Creating /src directory...
	@sudo mkdir -p /src
	@sudo chmod 775 /src
	@sudo chown `whoami` /src


.PHONY: packages node vim git gcc fish mosh libdb zcash nheqminer cpuminer ansible
