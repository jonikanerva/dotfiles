# Installing new machine

## Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
    brew install zsh git hub ssh-copy-id wget grc rbenv ruby-build rbenv-gem-rehash rbenv-bundler ctags

## Z shell
    chsh -s /bin/zsh
    rm -f ~/.bash*

## Terminal Settings
    curl --silent -L https://raw.githubusercontent.com/jonikanerva/dotfiles/master/terminal-setup.sh | bash

## Rbenv + gems
    rbenv install 2.2.3
    rbenv global 2.2.3
    gem update --system
    gem update
    gem cleanup
    gem install bundler chef rails rubocop
