#!/bin/bash
# credits to https://gist.github.com/pixelhandler/5718585

master="master"
current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
push_command=$(ps -ocommand= -p $PPID)
is_destructive="force|delete|\-f"
remove_branch=":${master}"
red=`tput -Txterm-color setaf 1`
normal=`tput -Txterm-color sgr0`

do_exit() {
  echo
  echo "${red}FOOL! Never force push or delete the master branch!${normal}"
  echo
  exit 1
}

if [[ $push_command =~ $is_destructive ]] && [ $current_branch = $master ]; then
  do_exit
fi

if [[ $push_command =~ $is_destructive ]] && [[ $push_command =~ $master ]]; then
  do_exit
fi

if [[ $push_command =~ $remove_branch ]]; then
  do_exit
fi

unset do_exit
exit 0
