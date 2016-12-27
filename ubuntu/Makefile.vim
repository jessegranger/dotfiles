
# vim: ft=make

VIM_VERSION?=master

vim: /usr/local/bin/vim

/usr/local/bin/vim: /usr/local/stow/vim-${VIM_VERSION}/bin/vim
	cd /usr/local/stow && for i in vim-*; do stow -D $$i; done
	cd /usr/local/stow && stow vim-${VIM_VERSION}

/usr/local/stow/vim-${VIM_VERSION}/bin/vim: /src/vim/src/vim
	cd /src/vim && make -j 2 install

/src/vim/src/vim: /src/vim/src/auto/config.cache
	cd /src/vim && make -j 2

/src/vim/src/auto/config.cache: /src/vim/.git/HEAD
	cd /src/vim && ./configure --prefix=/usr/local/stow/vim-${VIM_VERSION} --enable-pythoninterp --enable-rubyinterp --enable-python3interp --with-features=huge

/src/vim/.git/HEAD:
	mkdir -p /src
	cd /src && git clone https://github.com/vim/vim.git
	cd /src && git checkout ${VIM_VERSION}
	
