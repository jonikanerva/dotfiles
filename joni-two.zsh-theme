function git_prompt_check() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%{$reset_color%} at %{$fg[magenta]%}${ref#refs/heads/}"
}

NAME="%{$fg[magenta]%}%n"
MACHINE="%{$fg[yellow]%}%m"
DIR="%{$fg[green]%}%~%"

PROMPT='$NAME %{$reset_color%}on $MACHINE %{$reset_color%}in $DIR $(git_prompt_check)$(git_prompt_status)
%{$reset_color%}$ '
RPROMPT=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%} ✱"
