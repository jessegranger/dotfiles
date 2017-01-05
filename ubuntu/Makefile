all: packages /src gcc node vim git fish mosh libdb zcash nheqminer cpuminer

packages:
	# Checking for bootstrap packages...
	@sudo apt -qqq install -y build-essential libboost-all-dev libncurses5-dev ncurses-dev zlib1g-dev \
		make cmake git autoconf automake protobuf-compiler libutempter-dev apt-transport-https \
		unzip libc6-dev wget bsdmainutils libcurl4-openssl-dev libmpfr-dev libmpc-dev flex bison \
		libprotoc-dev stow libssl-dev libtool libjansson\* ruby-dev python-dev exfat-fuse exfat-utils \
		chromium-browser python-qt4 python-pip screen gpp par

/src:
	# Creating /src directory...
	@sudo mkdir -p /src
	@sudo chmod 775 /src
	@sudo chown `whoami` /src

include Makefile.*

.PHONY: packages node vim git gcc fish mosh libdb zcash nheqminer cpuminer
