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
