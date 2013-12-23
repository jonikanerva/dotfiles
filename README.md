# Installing new machine

## Homebrew
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    brew update
    brew doctor
    brew install zsh git hub ssh-copy-id wget grc htop highlight

## Z shell
    chsh -s /bin/zsh
    rm -f ~/.bash*

## Terminal Settings
    curl --silent -L https://raw.github.com/jonikanerva/dotfiles/master/terminal-setup.sh | bash
