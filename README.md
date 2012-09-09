# Installing new machine

## Homebrew
    ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)
    brew update
    brew doctor
    brew install zsh git hub ssh-copy-id wget grc htop

## Z shell
    chsh -s /bin/zsh
    rm -f ~/.bash*

## Terminal Settings
    curl --silent -L https://raw.github.com/jonikanerva/dotfiles/master/terminal-setup.sh | bash
