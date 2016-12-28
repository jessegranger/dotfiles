all: packages /src node vim git gcc fish mosh libdb zcash

packages:
	# Checking for bootstrap packages...
	@sudo apt -qqq install build-essential libboost-all-dev libncurses5-dev ncurses-dev zlib1g-dev \
		make cmake git autoconf automake protobuf-compiler libutempter-dev apt-transport-https \
		unzip libc6-dev wget bsdmainutils

/src:
	# Creating /src directory...
	@sudo mkdir -p /src
	@sudo chmod 775 /src
	@sudo chown `whoami` /src

include Makefile.*

.PHONY: node vim git gcc fish mosh packages libdb zcash
