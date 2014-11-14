# Installing new machine

## Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/homebrew/go/install)"
    brew doctor
    brew install zsh git hub ssh-copy-id wget grc rbenv ruby-build rbenv-gem-rehash rbenv-bundler

## Z shell
    chsh -s /bin/zsh
    rm -f ~/.bash*

## Terminal Settings
    curl --silent -L https://raw.githubusercontent.com/jonikanerva/dotfiles/master/terminal-setup.sh | bash

## Rbenv + gems
    rbenv install 2.1.5
    rbenv global 2.1.5
    gem update --system
    yes | gem update
    gem install bundler chef rails travis travis-lint
