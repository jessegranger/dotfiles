
# vim: ft=make

FISH_VERSION?=master

PACKAGES+=ncurses-dev libncurses5-dev gettext autoconf

fish: /usr/local/bin/fish

/usr/local/bin/fish: /usr/local/stow/fish-${FISH_VERSION}/bin/fish
	# [fish] stowing...
	@cd /usr/local/stow && for i in fish-*; do sudo stow -D $$i; done
	@cd /usr/local/stow && sudo stow fish-${FISH_VERSION}
	# [fish] adding to /etc/shells
	@grep -q /usr/local/bin/fish /etc/shells || (sudo bash -c "echo /usr/local/bin/fish >> /etc/shells")

/usr/local/stow/fish-${FISH_VERSION}/bin/fish: /src/fish/fish
	# [fish] installing...
	@cd /src/fish && sudo make -j 2 install > /dev/null
	@sudo touch $@

/src/fish/fish: /src/fish/config.log
	# [fish] building...
	@cd /src/fish && make -j 2 > /dev/null

/src/fish/config.log: /src/fish/configure
	# [fish] configuring...
	@cd /src/fish && ./configure --prefix=/usr/local/stow/fish-${FISH_VERSION} --without-gettext > /dev/null

/src/fish/configure: /src/fish/.git/HEAD
	# [fish] creating configure...
	@cd /src/fish && autoreconf --no-recursive > /dev/null
	@touch $@

/src/fish/.git/HEAD: Makefile.fish
	# [fish] building...
	@mkdir -p /src
	@cd /src && [ -d "fish" ] || git clone https://github.com/fish-shell/fish-shell.git fish
	@cd /src/fish && git checkout ${FISH_VERSION} && git pull > /dev/null
	@touch $@
