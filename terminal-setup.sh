#!/usr/bin/bash

echo
echo "Updating terminal settings"
echo

# Check we have Git
command -v git > /dev/null

if [[ $? != 0 ]]; then
  echo "Install git first!"
  exit
fi

# Check we have Curl
command -v curl > /dev/null

if [[ $? != 0 ]]; then
  echo "Install curl first!"
  exit
fi

# Check .bundle dir
if [ ! -d ~/.bundle ]; then
  mkdir ~/.bundle
fi

# Fetch oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "Getting oh-my-zsh.."
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh --quiet
fi

echo "Getting .rc files.."

if [ -d ~/.oh-my-zsh ]; then
  cd ~/.oh-my-zsh/custom
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/joni.zsh-theme
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/joni.zsh
fi

cd ~
curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/.zshrc
curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/.gitignore
curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/.gitconfig
curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/.irbrc
curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/.pryrc
curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/.gemrc

cd ~/.bundle
curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/.bundle/config

# If we have Sublime Text
if [ -d ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User ]; then
  echo "Getting Sublime Text preferences.."
  cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/Preferences.sublime-settings
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/Default\ \(OSX\).sublime-keymap
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/Markdown.sublime-settings
  curl --silent -O https://raw.github.com/ryanb/textmate-themes/master/railscasts.tmTheme
  curl --silent -O https://raw.github.com/deplorableword/textmate-solarized/master/Solarized\ \(dark\).tmTheme
  curl --silent -O https://raw.github.com/chriskempson/tomorrow-theme/master/textmate/Tomorrow-Night-Eighties.tmTheme
fi

echo
echo "Done."
echo
