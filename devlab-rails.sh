#!/usr/bin/bash

echo
echo -n "Installing required .rc files..."

if [ ! -d ~/.bundle ]; then
  mkdir ~/.bundle
fi

curl --silent -o ~/.gitignore      https://raw.github.com/jonikanerva/dotfiles/master/.gitignore
curl --silent -o ~/.irbrc          https://raw.github.com/jonikanerva/dotfiles/master/.irbrc
curl --silent -o ~/.pryrc          https://raw.github.com/jonikanerva/dotfiles/master/.pryrc
curl --silent -o ~/.gemrc          https://raw.github.com/jonikanerva/dotfiles/master/.gemrc
curl --silent -o ~/.bundle/config  https://raw.github.com/jonikanerva/dotfiles/master/.bundle/config

echo "OK"
echo
