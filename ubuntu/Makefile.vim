
# vim: ft=make

VIM_VERSION?=master

PACKAGES+=libncurses5-dev libgnome2-dev libgnomeui-dev \
	libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
	python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git

/usr/local/bin/vim: /usr/local/stow/vim-${VIM_VERSION}/bin/vim
	# [vim] stowing version '${VIM_VERSION}'...
	@cd /usr/local/stow && for i in vim-*; do sudo stow -D $$i; done
	@cd /usr/local/stow && sudo stow vim-${VIM_VERSION}
	@sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 100

/usr/local/stow/vim-${VIM_VERSION}/bin/vim: /src/vim/src/vim
	# [vim] installing...
	@cd /src/vim && sudo make -j 2 install > /dev/null
	@sudo touch $@

vim: /usr/local/bin/vim

/src/vim/src/vim: /src/vim/src/auto/config.cache
	# [vim] building...
	@cd /src/vim && make -j > /dev/null

/src/vim/src/auto/config.cache: /src/vim/.git/HEAD
	# [vim] configuring...
	@cd /src/vim && ./configure --prefix=/usr/local/stow/vim-${VIM_VERSION} \
		--with-features=huge \
		--enable-multibyte \
		--enable-rubyinterp=yes \
		--enable-pythoninterp=yes \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk2 \
		--enable-cscope > /dev/null

/src/vim/.git/HEAD: Makefile.vim
	# [vim] pulling source from github...
	@mkdir -p /src
	@cd /src && [ -d "vim" ] || git clone https://github.com/vim/vim.git
	@cd /src/vim && git checkout ${VIM_VERSION} && git pull
	@touch $@
