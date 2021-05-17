# Installing a new machine

## Xcode

    Install Xcode from the Mac App Store.

## Homebrew

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew doctor && brew install git translate-shell gnupg pinentry-mac

## Terminal Settings

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/jonikanerva/dotfiles/main/terminal-setup.sh)"

## Nvm + Node

    brew install nvm node yarn
    nvm install --lts
    nvm use --lts
    nvm alias default "lts/*"

## Rbenv + Gems

    brew install rbenv ruby-build readline
    rbenv install --list | grep -E "^\s*\d" | tail -5
    rbenv install 2.7.0
    rbenv global 2.7.0
    gem update --system
    gem update
    gem cleanup
    gem install bundler rails rubocop
