all: /src node vim git gcc

/src:
	sudo mkdir -p /src
	sudo chmod 775 /src
	sudo chown `whoami` /src

include Makefile.node
include Makefile.vim
include Makefile.git
include Makefile.gcc

.PHONY: node vim git gcc

