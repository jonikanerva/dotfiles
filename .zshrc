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
  export EDITOR=code

  # for homebrew
  export HOMEBREW_ROOT=/opt/homebrew
  export PATH=$HOMEBREW_ROOT/bin:$HOMEBREW_ROOT/sbin:$PATH
  export HOMEBREW_INSTALL_CLEANUP=true
  export HOMEBREW_NO_ENV_HINTS=1
  alias bu='brew update && brew upgrade && brew cleanup; brew doctor'

  # for gpg
  export GPG_TTY=$(tty)

  # for node modules
  export PATH=$PATH:./node_modules/.bin

  # for nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # for go
  export GOROOT=/opt/homebrew/opt/go/libexec
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

  # for yarn/npm
  alias y='yarn'
  alias n='npm run-script'

  # for kubernetes
  alias k='kubectl'
  alias ks="echo '* deployments';  kubectl get deployment; echo '* pods'; kubectl get pods;  echo '* services'; kubectl get service;  echo '* ingresses'; kubectl get ing"

  # for ruby
  if which rbenv > /dev/null; then eval "$(rbenv init - zsh)"; fi

  # for mysql/maria
  alias mysql-start='mysql.server start'
  alias mysql-stop='mysql.server stop'

  # for postgres
  alias pg-start='pg_ctl -D /opt/homebrew/var/postgres -l /opt/homebrew/var/postgres/server.log start'
  alias pg-stop='pg_ctl -D /opt/homebrew/var/postgres stop -s -m fast'

  # for dynamo
  alias ddb="aws dynamodb --endpoint-url http://localhost:8000"

  # for ftp
  alias ftp-start='sudo -s launchctl load -w /System/Library/LaunchDaemons/ftp.plist'
  alias ftp-stop='sudo -s launchctl unload -w /System/Library/LaunchDaemons/ftp.plist'

  # for docker
  alias docker-remove-all='docker stop $(docker ps -q); docker rm $(docker ps -a -q); docker rmi -f $(docker images -q)'

  # for misc
  alias s='cd ~/Sites'
  alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
  alias netlisteners='lsof -i -P | grep LISTEN'
  alias static-serve='python -m SimpleHTTPServer 8000'
  alias update='echo "==> Updating Homebrew packages" && brew update && brew upgrade && brew cleanup; brew doctor && echo "\n==> Updating Apple software" && softwareupdate --install --all && echo "\n==> Updating Mac Appstore software" && mas upgrade && echo'
  alias startup-items='echo "\n/Library/LaunchDaemons (root)\n======================"; find /Library/LaunchDaemons/*; echo "\n/Library/LaunchAgents (all users)\n====================="; find /Library/LaunchAgents/*; echo "\n~/Library/LaunchAgents ($(whoami))\n======================"; find ~/Library/LaunchAgents/*; echo'

  sleep-log() {
    DAYS=${1:-"0"}
    pmset -g log | egrep 'UserIsActive|FullWake|Display is turned on|powerd process|\(coreaudiod\) Released PreventUserIdleSystemSleep' | egrep -B 1 'UserIsActive|FullWake|Display is turned on|powerd process' | grep $(date -v -${DAYS}d +"%Y-%m-%d"); date +%Y-%m-%d\ %H:%M.%S\ nyt;
  }

  function iterm2_print_user_vars() {
    iterm2_set_user_var kubecontext $(kubectl config current-context)
  }

  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# generate password
alias gp='openssl rand -base64 21'

# misc
alias pgrep='pgrep -lf'

# git
alias g='git'
alias git-clean-repo='du -sh $(pwd) && git fetch && git remote prune origin && git branch | grep -v main | grep -v "$(git symbolic-ref --short -q HEAD)" | xargs git branch -D && git gc && if [ -f Gemfile ]; then bundle clean; fi && du -sh $(pwd)'

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=~/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
