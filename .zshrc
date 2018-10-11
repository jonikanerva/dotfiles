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
  alias a=$EDITOR

  # for homebrew
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  alias bu='brew update && brew upgrade; brew cleanup && brew doctor'

  # for gpg
  export GPG_TTY=$(tty)

  # for node modules
  export PATH=$PATH:./node_modules/.bin

  # for nvm
  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

  # for go
  export GOROOT=/usr/local/opt/go/libexec
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

  # for yarn
  export PATH=$PATH:$(yarn global bin)
  alias y='yarn'
  alias yu='yarn global upgrade'

  # for kubernetes
  alias k='kubectl'
  alias ks="echo '* deployments';  kubectl get deployment; echo '* pods'; kubectl get pods;  echo '* services'; kubectl get service;  echo '* ingresses'; kubectl get ing"

  # for ruby
  if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

  # for mysql/maria
  alias mysql-start='mysql.server start'
  alias mysql-stop='mysql.server stop'

  # for postgres
  alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
  alias pg-stop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

  # for ftp
  alias ftp-start='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
  alias ftp-stop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

  # for docker
  alias docker-remove-all='docker rm $(docker ps -a -q) && docker rmi -f $(docker images -q)'

  # for misc
  alias s='cd ~/Sites'
  alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
  alias netlisteners='lsof -i -P | grep LISTEN'
  alias static-serve='python -m SimpleHTTPServer 8000'
  alias t='trans -show-languages n -show-translation n -show-original n fi:en'
  alias te='trans -show-languages n -show-translation n -show-original n en:fi'
  alias update='echo "==> Updating Homebrew packages" && brew update && brew upgrade; brew cleanup && brew doctor && echo "\n==> Updating Yarn packages" && yarn global upgrade -s --no-progress && echo "\n==> Updating Atom packages" && apm upgrade --no-confirm && echo "\n==> Updating Apple software" && softwareupdate --install --all --restart && echo'
  alias startup-items='echo "\n/Library/LaunchDaemons (root)\n======================" && find /Library/LaunchDaemons/* && echo "\n/Library/LaunchAgents (all users)\n=====================" && find /Library/LaunchAgents/* && echo "\n~/Library/LaunchAgents ($(whoami))\n======================" && find ~/Library/LaunchAgents/* && echo'

  sleep-log() {
    DAYS=${1:-"0"}
    pmset -g log | egrep 'UserIsActive|FullWake|Display is turned on|powerd process|\(coreaudiod\) Released PreventUserIdleSystemSleep' | egrep -B 1 'UserIsActive|FullWake|Display is turned on|powerd process' | grep $(date -v -${DAYS}d +"%Y-%m-%d"); date +%Y-%m-%d\ %H:%M.%S\ nyt;
  }
fi

# generate password
alias gp='openssl rand -base64 21'

# misc
alias pgrep='pgrep -lf'

# git
alias g='git'
alias git-clean-repo='du -sh $(pwd) && git fetch && git remote prune origin && git branch | grep -v master | grep -v "$(git symbolic-ref --short -q HEAD)" | xargs git branch -D && git gc && if [ -f Gemfile ]; then bundle clean; fi && du -sh $(pwd)'

# perform
awslogin() { perform get-aws-keys jkanerva $1 hbogo; }
