
function gst --wraps git
	git status --short $argv
end

function gco --wraps git
	git checkout $argv
end

function lsa --wraps ls
	ls -hal $argv
end

function vi --wraps vim
	env SHELL=/bin/bash vim $argv
end

function line
	head -$argv | tail -1
end

function goo
	googler -j $argv
end

function dc --wraps docker-compose
	docker-compose $argv
end

function _prompt_user
	set_color yellow
	printf '%s' $USER
	set_color normal
end

function _prompt_host
	if not set -q __fish_prompt_hostname
		set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
	end
	printf ' at '
	set_color magenta
	printf $__fish_prompt_hostname
	set_color normal
end

function _prompt_pwd
	if not set -q __fish_prompt_cwd
		set -g __fish_prompt_cwd (set_color green)
	end
	printf ' in '
	set_color green
	printf '%s' (prompt_pwd)
	set_color normal
end

function _prompt_git
	set -l git_prompt (__fish_git_prompt)
	if test -n "$git_prompt"
		printf ' on'
		printf "$git_prompt"
	end
	set_color normal
end

function _prompt_screen
	if not set -q __fish_prompt_screen
		set -g __fish_prompt_screen (set_color cyan)
	end
	if test -n "$WINDOW"
		printf $__fish_prompt_screen
		printf ':%s' $WINDOW
		set_color normal
	end
end

function fish_prompt --description "Write out a custom prompt"

	_prompt_user
	_prompt_host
	_prompt_screen
	_prompt_pwd
	_prompt_git
	printf ' > '
	printf '\ek\e\\'

end

if test -e /usr/libexec/java_home
	set -g JAVA_HOME (/usr/libexec/java_home)
end

if test -e (which fish)
	set -g SHELL (which fish)
end

function fish_title
	echo (prompt_pwd)
end

# set TERM xterm-256color

function sc --wraps screen
	env TERM=xterm-256color SHELL=(which fish) screen -DR
end

if [ -n "$SSH_AUTH_SOCK" -a ! -h "$SSH_AUTH_SOCK" ]
	ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
	set SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
end
