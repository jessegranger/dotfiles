# vim: ft=make

VIM_VERSION?=master
SRC_DIR=/opt/src
VIM_PREFIX=/usr/local/stow/vim-${VIM_VERSION}
UNAME:=$(shell uname -s)

ifeq (${UNAME},Darwin)
# macOS: interpreters come from homebrew, terminal-only build (no X/GTK)
BREW:=$(shell brew --prefix)
VIM_PATH=${BREW}/opt/perl/bin:${BREW}/opt/ruby/bin:${BREW}/opt/python3/bin:${PATH}
VIM_CONFIGURE_FLAGS=\
	--enable-python3interp=yes \
	--with-python3-command=${BREW}/opt/python3/bin/python3 \
	--with-ruby-command=${BREW}/opt/ruby/bin/ruby \
	--with-lua-prefix=${BREW}/opt/lua \
	--with-tlib=ncurses \
	--disable-gui \
	--without-x
else
PACKAGES+=libncurses5-dev libgnome2-dev libgnomeui-dev \
	libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
	libcairo2-dev libx11-dev libxpm-dev libxt-dev \
	python3-dev ruby-dev lua5.1 liblua5.1-dev libperl-dev git
VIM_PATH=${PATH}
VIM_CONFIGURE_FLAGS=\
	--enable-python3interp=yes \
	--enable-gui=gtk2
endif

/usr/local/bin/vim: ${VIM_PREFIX}/bin/vim
	# [vim] stowing version '${VIM_VERSION}'...
	@cd /usr/local/stow && for i in vim-*; do sudo stow -D $$i; done
	@cd /usr/local/stow && sudo stow --no-folding vim-${VIM_VERSION}
	@[ -e "`which update-alternatives`" ] && sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 100 || true

${VIM_PREFIX}/bin/vim: ${SRC_DIR}/vim/src/vim
	# [vim] installing...
	@cd ${SRC_DIR}/vim && sudo make install > /dev/null
	@sudo touch $@

vim: /usr/local/bin/vim

${SRC_DIR}/vim/src/vim: ${SRC_DIR}/vim/src/auto/config.cache
	# [vim] building...
	@cd ${SRC_DIR}/vim && PATH=${VIM_PATH} make -j > /dev/null
	@touch $@

${SRC_DIR}/vim/src/auto/config.cache: ${SRC_DIR}/vim/.git/make-rev Makefile.vim
	# [vim] configuring...
	@cd ${SRC_DIR}/vim && rm -f src/auto/config.cache && PATH=${VIM_PATH} ./configure \
		--prefix=${VIM_PREFIX} \
		--with-features=huge \
		--enable-multibyte \
		--enable-terminal \
		--enable-rubyinterp=yes \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-cscope \
		${VIM_CONFIGURE_FLAGS} > /dev/null

# always pull, but only touch the stamp (and trigger a rebuild) when the commit changes
${SRC_DIR}/vim/.git/make-rev: FORCE
	# [vim] pulling source from github...
	@mkdir -p ${SRC_DIR}
	@cd ${SRC_DIR} && [ -d "vim" ] || git clone https://github.com/vim/vim.git
	@cd ${SRC_DIR}/vim && git checkout -q ${VIM_VERSION} && git pull -q --ff-only
	@cd ${SRC_DIR}/vim && git rev-parse HEAD | cmp -s - $@ || git rev-parse HEAD > $@

.PHONY: FORCE
FORCE:
