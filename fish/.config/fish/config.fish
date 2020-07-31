
function gst --wraps git
	git status --short -b $argv
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

function lines
	head -$2 | head -(expr $2 - $1)
end

function goo
	googler -j $argv
end

function dc --wraps docker-compose
	docker-compose $argv
end

function midtruncate -a maxlen value
	set len (string length $value)
	if test "$len" -gt 19
		set prefix (math $maxlen / 2)
		set suffix (math $maxlen - $prefix)
		echo (string sub -s 1 -l $prefix $value)...(string sub -s -$suffix $value)
	else
		echo $value
	end
end

function _prompt_date
	if not set -q __fish_prompt_date
		set -g __fish_prompt_date (set_color white)
	end
	printf $__fish_prompt_date
	printf '%s | ' (date "+%m/%d %H:%M")
	set_color normal
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
	printf '@'
	set_color magenta
	printf $__fish_prompt_hostname
	set_color normal
end

function _prompt_pwd
	if not set -q __fish_prompt_cwd
		set -g __fish_prompt_cwd (set_color green)
	end
	printf ' '
	printf $__fish_prompt_cwd
	printf '%s' (prompt_pwd)
	set_color normal
end

function _prompt_git
	set -l git_prompt (__fish_git_prompt)
	if test -n "$git_prompt"
		printf (midtruncate "20" "$git_prompt")
	end
	set_color normal
end

function _prompt_screen
	if test -n "$WINDOW"
		if not set -q __fish_prompt_screen
			set -g __fish_prompt_screen (set_color cyan)
		end
		printf $__fish_prompt_screen
		printf ':%s' $WINDOW
		set_color normal
	end
end

function _prompt_autotitle
	# if we are in a screen session,
	# output the special the autotitle escape code
	if test -n "$WINDOW"
		printf '\ek\e\\'
		printf '\ek'(prompt_pwd)'\e\\'
	end
end

function _prompt_todo
	if test -e ".todo"
		echo -n (todo prompt)
	end
end

function fish_prompt --description "Write out a custom prompt"

	_prompt_autotitle
	_prompt_date
	_prompt_user
	_prompt_host
	_prompt_screen
	_prompt_pwd
	_prompt_git
	_prompt_todo
	printf ' > '

end

if test -e /usr/libexec/java_home
	set -gx JAVA_HOME (/usr/libexec/java_home)
end

if test -e /usr/lib/node_modules
	set -gx NODE_PATH /usr/lib/node_modules
end

if test -e (which fish)
	set -gx SHELL (which fish)
end

function fish_title
	echo (prompt_pwd)
end

function sc --wraps screen
	env SHELL=(which fish) screen -DRR
end

if [ -n "$SSH_AUTH_SOCK" -a ! -h "$SSH_AUTH_SOCK" ]
	ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
	set SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
end

