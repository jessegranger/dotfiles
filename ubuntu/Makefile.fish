
# vim: ft=make

FISH_VERSION?=master

fish: /usr/local/bin/fish

/usr/local/bin/fish: /usr/local/stow/fish-${FISH_VERSION}/bin/fish
	cd /usr/local/stow && for i in fish-*; do sudo stow -D $$i; done
	cd /usr/local/stow && sudo stow fish-${FISH_VERSION}
	grep -q /usr/local/bin/fish /etc/shells || (sudo bash -c "echo /usr/local/bin/fish >> /etc/shells")

/usr/local/stow/fish-${FISH_VERSION}/bin/fish: /src/fish/fish
	cd /src/fish && sudo make -j 2 install
	sudo touch $@

/src/fish/fish: /src/fish/config.log
	cd /src/fish && make -j 2

/src/fish/config.log: /src/fish/configure
	cd /src/fish && ./configure --prefix=/usr/local/stow/fish-${FISH_VERSION} --without-gettext

/src/fish/configure: /src/fish/.git/HEAD /usr/bin/autoreconf
	cd /src/fish && autoreconf --no-recursive

/usr/bin/autoreconf:
	sudo apt install autoconf

/src/fish/.git/HEAD:
	mkdir -p /src
	cd /src && git clone https://github.com/fish-shell/fish-shell.git fish
	cd /src/fish && git checkout ${FISH_VERSION}
	
