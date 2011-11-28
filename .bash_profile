# for bash
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export CLICOLOR=1
export LSCOLORS=dxgxcxdxcxegedabagacad
export EDITOR=mate
alias l='ls -lh'

# for homebrew/pear
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/pear/bin:$PATH

# for prompt
PS1='\[\e[0;34m\]\133\[\e[m\]\[\e[0;33m\]\u@\h: \W\[\e[m\]\[\e[0;34m\]\135\[\e[m\]\[\e[0;37m\]\$\[\e[m\] '

# for mysql
alias mysql-start='mysql.server start'
alias mysql-stop='mysql.server stop'

# for printers
alias p='clear;echo "Viimeset 10:";lpstat -W completed -o|tail -10;echo;echo "Jono nyt:";lpstat -o;echo;echo "Disabloidut printterit:";lpstat -p |grep dis;echo'
