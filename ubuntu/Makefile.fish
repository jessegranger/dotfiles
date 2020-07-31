
# vim: ft=make

FISH_VERSION?=3.1.2

PACKAGES+=ncurses-dev libncurses5-dev gettext

PREFIX=/usr/local/stow/fish-${FISH_VERSION}
MAKE=env PREFIX='${PREFIX}' make -f GNUmakefile

fish: /usr/local/bin/fish

/usr/local/bin/fish: ${PREFIX}/bin/fish
	# [fish] stowing...
	@cd /usr/local/stow && for i in fish-*; do sudo stow -D $$i; done
	@cd /usr/local/stow && sudo stow fish-${FISH_VERSION}
	# [fish] adding to /etc/shells
	@grep -q /usr/local/bin/fish /etc/shells || (sudo bash -c "echo /usr/local/bin/fish >> /etc/shells")

${PREFIX}/bin/fish: /src/fish/build/fish
	# [fish] installing...
	@cd /src/fish && sudo ${MAKE} install > /dev/null
	@sudo touch $@

/src/fish/build/fish: /src/fish/.git/HEAD
	# [fish] building...
	@cd /src/fish && ${MAKE} > /dev/null

/src/fish/.git/HEAD: Makefile.fish
	# [fish] getting latest code...
	@mkdir -p /src
	@cd /src && [ -d "fish" ] || git clone https://github.com/fish-shell/fish-shell.git fish
	@cd /src/fish && git fetch && git checkout ${FISH_VERSION} > /dev/null
	@touch $@
