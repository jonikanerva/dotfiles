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

# Check .gnupg dir
if [ ! -d ~/.gnupg ]; then
  mkdir ~/.gnupg
fi

# Fetch oh-my-zsh
if [ ! -d ~/.oh-my-zsh ]; then
  echo "Getting oh-my-zsh.."
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh --quiet

  mkdir -p ~/.oh-my-zsh/custom/plugins
  cd ~/.oh-my-zsh/custom/plugins
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git --quiet
fi

if [ -d ~/.oh-my-zsh ]; then
  echo "Update oh-my-zsh custom.."
  cd ~/.oh-my-zsh/custom
  curl --silent -O https://raw.githubusercontent.com/jonikanerva/dotfiles/master/joni.zsh-theme
  curl --silent -O https://raw.githubusercontent.com/jonikanerva/dotfiles/master/joni-two.zsh-theme
  curl --silent -O https://raw.githubusercontent.com/jonikanerva/dotfiles/master/joni.zsh
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  echo "Update zsh syntax highlighting.."
  cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git pull
fi

echo "Getting .rc files.."

cd ~
curl --silent -O https://raw.githubusercontent.com/jonikanerva/dotfiles/master/.zshrc
curl --silent -O https://raw.githubusercontent.com/jonikanerva/dotfiles/master/.gitignore
curl --silent -O https://raw.githubusercontent.com/jonikanerva/dotfiles/master/.gitconfig

cd ~/.gnupg
curl --silent -O https://raw.githubusercontent.com/jonikanerva/dotfiles/master/gpg-agent.conf

echo "Done."
echo
