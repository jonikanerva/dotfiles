# for zsh
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups
export LANG=en_US.UTF-8

# for rbenv
if [[ -d "${HOME}/.rbenv/bin" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  alias rbenv-pull='cd ~/.rbenv && git pull && cd ~/.rbenv/plugins/ruby-build && git pull && cd ~/.rbenv/plugins/rbenv-gem-rehash && git pull && cd'
fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# for oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="joni-two"
plugins=(heroku zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Mac
if [[ `uname` == 'Darwin' ]]; then
  # editor
  export EDITOR=subl

  # for grc
  source "`brew --prefix grc`/etc/grc.bashrc"

  # for ssh-agent (ssh-add -K ~/.ssh/id_rsa)
  eval $(ssh-agent) > /dev/null

  # for homebrew/pear
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/pear/bin:$PATH
  alias bu='brew update && brew upgrade && brew cleanup && brew doctor'
  alias gu='for ruby in $(rbenv versions --bare); do rbenv shell ${ruby} && echo "Updating Ruby ${ruby}.." && gem update --system -N; gem update -N && gem cleanup; unset RBENV_VERSION; echo; done;'

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
  alias s='cd ~/Dropbox/Sites'
  alias r='cd ~/Sites/ruby'
  alias a='cd ~/Sites/ruby/ahkio'
  alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
  alias nano='subl'
  alias netlisteners='lsof -i -P | grep LISTEN'

  # for rails
  alias migrate='echo "Development..." && bundle exec rake db:migrate RAILS_ENV=development && echo "Test..." && bundle exec rake db:migrate RAILS_ENV=test'
  alias l-production='heroku logs --tail --app ahkio'
  alias l-staging='heroku logs --tail --app ahkio-staging'
  alias l-development='tail -f log/development.log'
  alias l-test='tail -f log/test.log'

  # for redis
  alias redis-start='redis-server /usr/local/etc/redis.conf'
  alias redis-stop='kill $(cat /usr/local/var/run/redis.pid)'
fi

# Linux
if [[ `uname` == 'Linux' ]]; then
  # editor
  export EDITOR=nano
  alias mate='nano'
  alias subl='nano'
fi

# generate password
alias gp='openssl rand -base64 21'
alias secret='ruby -e "require \"securerandom\"; puts SecureRandom.hex(64)"'

# for printers
alias p='clear;echo "Viimeset 10:";lpstat -W completed -o|tail -10;echo;echo "Jono nyt:";lpstat -o;echo;echo "Disabloidut printterit:";lpstat -p |grep dis;echo'

# misc
alias pgrep='pgrep -lf'
alias e=$EDITOR

# git
alias g='git'
alias git-cleanup='find ~ -path "*/.git" -not -path "*/vendor/bundle/*" -type d -exec sh -c "cd {} && cd .. && git config --get remote.origin.url &> /dev/null && pwd && git fetch origin && git remote prune origin && git gc && if [ -f Gemfile ]; then bundle --quiet && bundle clean; fi && cd && echo" \;'
alias git-remove-all-local-branches='git branch | grep -v master | grep -v "$(git symbolic-ref --short -q HEAD)" | xargs git branch -d'
alias git-clean-repo='git fetch && git remote prune origin && git branch | grep -v master | grep -v "$(git symbolic-ref --short -q HEAD)" | xargs git branch -D && git gc'

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
