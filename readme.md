# Installing new machine

## Xcode

    xcode-select --install
    sudo xcodebuild -license

## Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew install zsh git translate-shell rbenv ruby-build readline gnupg gpg-agent pinentry-mac nvm node yarn

## Z shell
    chsh -s /bin/zsh
    rm -f ~/.bash*

## Terminal Settings
    curl --silent -L https://raw.githubusercontent.com/jonikanerva/dotfiles/master/terminal-setup.sh | bash

## Rbenv + gems
    rbenv install --list | grep -E "^\s*\d" | tail -5
    rbenv install 2.4.1
    rbenv global 2.4.1
    gem update --system
    gem update
    gem cleanup
    gem install bundler rails rubocop

## Nvm + npms
    nvm ls-remote --lts | tail -5
    nvm install v6.11.4
    nvm use v6.11.4
    nvm alias default v6.11.4
