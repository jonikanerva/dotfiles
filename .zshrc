# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export LANG=en_US.UTF-8

# for oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="joni-two"
DISABLE_AUTO_TITLE=true
COMPLETION_WAITING_DOTS=true
DISABLE_UPDATE_PROMPT=true
plugins=(heroku zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Mac
if [[ $(uname) == 'Darwin' ]]; then
  # editor
  export EDITOR=atom

  # for gpg-agent
  if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
  else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
  fi

  # for homebrew
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  alias bu='brew update && brew upgrade && brew cleanup && brew doctor'

  # for mysql/maria
  alias mysql-start='mysql.server start'
  alias mysql-stop='mysql.server stop'

  # for postgres
  alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
  alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

  # for ftp
  alias ftp-start='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
  alias ftp-stop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

  # for misc
  alias s='cd ~/Sites'
  alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
  alias netlisteners='lsof -i -P | grep LISTEN'
fi

# generate password
alias gp='openssl rand -base64 21'

# misc
alias pgrep='pgrep -lf'
alias e=$EDITOR

# git
alias g='git'
alias git-clean-repo='du -sh $(pwd) && git fetch && git remote prune origin && git branch | grep -v master | grep -v "$(git symbolic-ref --short -q HEAD)" | xargs git branch -D && git gc && if [ -f Gemfile ]; then bundle clean; fi && du -sh $(pwd)'
