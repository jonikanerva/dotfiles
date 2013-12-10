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

MATE="/Applications/TextMate.app/Contents/SharedSupport/Support/bin/mate"
MATE_BIN="/usr/local/bin/mate"

SUBL="/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"
SUBL_BIN="/usr/local/bin/subl"

if [[ -f "${SUBL}" && ! -f "${SUBL_BIN}" ]]; then
  ln -s "${SUBL}" "${SUBL_BIN}"
fi

if [[ -f "${MATE}" && ! -f "${MATE_BIN}" ]]; then
  ln -s "${MATE}" "${MATE_BIN}"
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
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/joni.zsh-theme
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/joni-two.zsh-theme
  curl --silent -O https://raw.github.com/jonikanerva/dotfiles/master/joni.zsh
fi

if [ -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
  echo "Update zsh syntax highlighting.."
  cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  git pull
fi

if [ -d ~/.rbenv/bin ]; then
  echo "Update rbenv.."
  cd ~/.rbenv
  git pull
  cd ~/.rbenv/plugins/ruby-build
  git pull
fi

echo "Getting .rc files.."

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

echo "Done."
echo
