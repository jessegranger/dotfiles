
# vim: ft=make

VIM_VERSION?=master
SRC_DIR=/opt/src

PACKAGES+=libncurses5-dev libgnome2-dev libgnomeui-dev \
	libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
	python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

/usr/local/bin/vim: /usr/local/stow/vim-${VIM_VERSION}/bin/vim
	# [vim] stowing version '${VIM_VERSION}'...
	@cd /usr/local/stow && for i in vim-*; do sudo stow -D $$i; done
	@cd /usr/local/stow && sudo stow vim-${VIM_VERSION}
	@[ which update-alternatives ] && sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 100

/usr/local/stow/vim-${VIM_VERSION}/bin/vim: ${SRC_DIR}/vim/src/vim
	# [vim] installing...
	@cd ${SRC_DIR}/vim && sudo make -j 2 install > /dev/null
	@sudo touch $@

vim: /usr/local/bin/vim

${SRC_DIR}/vim/src/vim: ${SRC_DIR}/vim/src/auto/config.cache
	# [vim] building...
	@cd ${SRC_DIR}/vim && make -j > /dev/null

${SRC_DIR}/vim/src/auto/config.cache: ${SRC_DIR}/vim/.git/HEAD
	# [vim] configuring...
	@cd ${SRC_DIR}/vim && ./configure --prefix=/usr/local/stow/vim-${VIM_VERSION} \
		--with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp=yes \
		--enable-pythoninterp=yes \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk2 \
		--enable-cscope > /dev/null

${SRC_DIR}/vim/.git/HEAD: Makefile.vim
	# [vim] pulling source from github...
	@mkdir -p ${SRC_DIR}
	@cd ${SRC_DIR} && [ -d "vim" ] || git clone https://github.com/vim/vim.git
	@cd ${SRC_DIR}/vim && git checkout ${VIM_VERSION} && git pull
	@touch $@
