# Installing a new machine

## Xcode

    Install Xcode from the Mac App Store.

## Homebrew

    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew install git translate-shell gnupg pinentry-mac

## Terminal Settings

    curl --silent -L https://raw.githubusercontent.com/jonikanerva/dotfiles/master/terminal-setup.sh | bash

## Rbenv + gems

    brew install rbenv ruby-build readline
    rbenv install --list | grep -E "^\s*\d" | tail -5
    rbenv install 2.7.0
    rbenv global 2.7.0
    gem update --system
    gem update
    gem cleanup
    gem install bundler rails rubocop

## Nvm + npms

    brew install nvm node yarn
    nvm ls-remote --lts | tail -5
    nvm install v12.16.1
    nvm use v12.16.1
    nvm alias default v12.16.1
