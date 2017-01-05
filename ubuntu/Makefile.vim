
# vim: ft=make

VIM_VERSION?=master

/usr/local/bin/vim: /usr/local/stow/vim-${VIM_VERSION}/bin/vim
	cd /usr/local/stow && for i in vim-*; do sudo stow -D $$i; done
	cd /usr/local/stow && sudo stow vim-${VIM_VERSION}
	@sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 100

/usr/local/stow/vim-${VIM_VERSION}/bin/vim: /src/vim/src/vim
	cd /src/vim && sudo make -j 2 install
	sudo touch $@

vim: /usr/local/bin/vim

/src/vim/src/vim: /src/vim/src/auto/config.cache
	cd /src/vim && make -j 2

/src/vim/src/auto/config.cache: /src/vim/.git/HEAD
	cd /src/vim && ./configure --prefix=/usr/local/stow/vim-${VIM_VERSION} --enable-pythoninterp --enable-rubyinterp --enable-python3interp --with-features=huge

/src/vim/.git/HEAD:
	mkdir -p /src
	cd /src && git clone https://github.com/vim/vim.git
	cd /src/vim && git checkout ${VIM_VERSION}
