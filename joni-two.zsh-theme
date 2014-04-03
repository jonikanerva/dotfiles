function git_prompt_check() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%{$reset_color%} at %{$fg[magenta]%}${ref#refs/heads/}"
}

git_remote_check() {
    remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

    if [[ -n ${remote} ]] ; then
        ahead=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | xargs)
        behind=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | xargs)

        if [ $ahead -eq 0 ] && [ $behind -gt 0 ]
        then
            echo "%{$reset_color%} $behind↓"
        elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]
        then
            echo "%{$reset_color%} $ahead↑"
        elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]
        then
          echo "%{$reset_color%} $ahead↑$behind↓"
        fi
    fi
}

NAME="%{$fg[magenta]%}%n"
MACHINE="%{$fg[yellow]%}%m"
DIR="%{$fg[green]%}%~%"

PROMPT='$NAME %{$reset_color%}on $MACHINE %{$reset_color%}in $DIR $(git_prompt_check)$(git_prompt_status)$(git_remote_check)
%{$fg[cyan]%}$ %{$reset_color%}'
RPROMPT=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%} ✱"
