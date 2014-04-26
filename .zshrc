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

  # for homebrew/pear
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/pear/bin:$PATH
  alias bu='brew update && brew upgrade && brew cleanup && brew doctor'
  alias gu='for ruby in $(rbenv versions --bare); do rbenv shell ${ruby} && echo "Updating Ruby ${ruby}.." && gem update --system -N; gem update -N && gem cleanup; unset RBENV_VERSION; echo; done;'

  # for os x
  alias osu='sudo softwareupdate -i -a'

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
  alias pupe='cd ~/Dropbox/Sites/pupesoft'
  alias s='cd ~/Dropbox/Sites'
  alias r='cd ~/Sites/ruby'
  alias dropbox_conflicts='find ~/Dropbox -name \*conflicted\ copy\*'
  alias nano='subl'
  alias netlisteners='lsof -i -P | grep LISTEN'
  alias highlight_rb='pbpaste | highlight --syntax=rb --font=Inconsolata-dz --font-size=24 --style=dante --out-format=rtf | pbcopy'
  alias highlight_php='pbpaste | highlight --syntax=php --font=Inconsolata-dz --font-size=24 --style=dante --out-format=rtf | pbcopy'
  alias highlight_sh='pbpaste | highlight --syntax=sh --font=Inconsolata-dz --font-size=24 --style=dante --out-format=rtf | pbcopy'
	alias highlight_sql='pbpaste | highlight --syntax=sql --font=Inconsolata-dz --font-size=24 --style=dante --out-format=rtf | pbcopy'
  alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
  alias fixopenwith='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user'
  alias delete_spotify_cache='rm -rf ~/Library/Caches/com.spotify.client'
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

# git
alias g='git'

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
