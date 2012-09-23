# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export LANG=en_US.UTF-8

# for oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="joni-two"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UPDATE_PROMPT="true"
plugins=(git github osx bundler gem heroku)
source $ZSH/oh-my-zsh.sh

# Mac
if [[ `uname` == 'Darwin' ]]; then
	# editor
	export EDITOR=mate

	# for grc
	source "`brew --prefix grc`/etc/grc.bashrc"

	# for rbenv
	if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

	# for homebrew/pear
	export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/pear/bin:$PATH

	# for apache
	alias apache-start='sudo apachectl start'
	alias apache-stop='sudo apachectl stop'
	alias apache-restart='sudo apachectl restart'

	# for mysql/maria
	alias mysql-start='mysql.server start'
	alias mysql-stop='mysql.server stop'

	# for postgres
	alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
	alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

	# for misc
	alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
	alias pupe='cd ~/Dropbox/Sites/pupesoft'
	alias s='cd ~/Dropbox/Sites'
	alias top='htop'
	alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
	alias nano='mate'
fi

# Linux
if [[ `uname` == 'Linux' ]]; then
	# editor
	export EDITOR=nano
	alias mate='nano'
fi

# generate password
alias gp='openssl rand -base64 21'

# for printers
alias p='clear;echo "Viimeset 10:";lpstat -W completed -o|tail -10;echo;echo "Jono nyt:";lpstat -o;echo;echo "Disabloidut printterit:";lpstat -p |grep dis;echo'
