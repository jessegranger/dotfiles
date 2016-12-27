all: packages /src node vim git gcc fish mosh

packages:
	# Checking for bootstrap packages...
	@sudo apt -qqq install build-essential libboost-all-dev libncurses5-dev ncurses-dev zlib1g-dev \
		make cmake git autoconf automake protobuf-compiler libutempter-dev

/src:
	# Creating /src directory...
	@sudo mkdir -p /src
	@sudo chmod 775 /src
	@sudo chown `whoami` /src

include Makefile.node
include Makefile.vim
include Makefile.git
include Makefile.gcc
include Makefile.fish
include Makefile.mosh

.PHONY: node vim git gcc fish mosh packages
