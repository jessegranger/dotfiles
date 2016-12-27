all: /src node vim git gcc fish mosh

/src:
	sudo mkdir -p /src
	sudo chmod 775 /src
	sudo chown `whoami` /src

include Makefile.node
include Makefile.vim
include Makefile.git
include Makefile.gcc
include Makefile.fish
include Makefile.mosh

.PHONY: node vim git gcc fish mosh

