# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export EDITOR=mate

# for oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="joni"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git github osx)
source $ZSH/oh-my-zsh.sh

# for homebrew/pear
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/pear/bin:$PATH

# for mysql
alias mysql-start='mysql.server start'
alias mysql-stop='mysql.server stop'

# for printers
alias p='clear;echo "Viimeset 10:";lpstat -W completed -o|tail -10;echo;echo "Jono nyt:";lpstat -o;echo;echo "Disabloidut printterit:";lpstat -p |grep dis;echo'
