## Terminal preferences

    chsh -s /bin/zsh

    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone git://github.com/jonikanerva/dotfiles.git ~/.dotfiles
    cp ~/.dotfiles/joni.zsh-theme ~/.oh-my-zsh/custom/
    cp ~/.dotfiles/.zshrc ~/.zshrc
    cp ~/.dotfiles/.gitconfig ~/.gitconfig
    cp ~/.dotfiles/.gitignore ~/.gitignore
    cp ~/.dotfiles/.gemrc ~/.gemrc
    cp ~/.dotfiles/.irbrc ~/.irbrc
    cp ~/.dotfiles/.pryrc ~/.pryrc
    cp -R ~/.dotfiles/.bundle ~/.bundle
    rm -f ~/.bash*

## Sublime Text 2 preferences

    cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User
    cp ~/.dotfiles/Default\ \(OSX\).sublime-keymap .
    cp ~/.dotfiles/Preferences.sublime-settings .
    wget -q https://raw.github.com/ryanb/textmate-themes/master/railscasts.tmTheme
    wget -q https://raw.github.com/deplorableword/textmate-solarized/master/Solarized%20(dark).tmTheme
    wget -q https://raw.github.com/chriskempson/tomorrow-theme/master/textmate/Tomorrow-Night-Eighties.tmTheme
