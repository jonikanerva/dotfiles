#!/usr/bin/bash

echo
echo -n "Installing required configs for bundle, gem and rbenv... "

if [ ! -d ~/.bundle ]; then
  mkdir ~/.bundle
fi

curl --silent -o ~/.gemrc          https://raw.github.com/jonikanerva/dotfiles/master/.gemrc
curl --silent -o ~/.bundle/config  https://raw.github.com/jonikanerva/dotfiles/master/.bundle/config

echo '
# Add rbenv to path
export PATH="$HOME/.rbenv/bin:$PATH"

# Load rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Add alias for updating rbenv
alias rbenv-update="cd ~/.rbenv && git pull && cd ~/.rbenv/plugins/ruby-build && git pull && cd"
' >> ~/.bash_profile

exec /bin/bash -l

echo "OK!"
echo
