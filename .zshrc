# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export EDITOR=mate
export LANG=en_US.UTF-8

# for oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="joni"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git github osx)
source $ZSH/oh-my-zsh.sh

# for homebrew/pear
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/pear/bin:$HOME/.rvm/bin:$PATH

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

# for printers
alias p='clear;echo "Viimeset 10:";lpstat -W completed -o|tail -10;echo;echo "Jono nyt:";lpstat -o;echo;echo "Disabloidut printterit:";lpstat -p |grep dis;echo'

# for rvm
source ~/.rvm/scripts/rvm

# for misc
alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'
alias gp='openssl rand -base64 21'
alias pupe='cd ~/Dropbox/Sites/pupesoft'
alias s='cd ~/Dropbox/Sites'
alias top='top -u'
alias dropbox_conflicts='ls ~/Dropbox/**/*conflicted\ copy*'
