# Joni: Oh My Zsh -asetukset, teema ja omat komennot.
# terminal-setup.sh asentaa tämän tiedostoon ~/.oh-my-zsh/custom/joni.zsh.
# Oh My Zsh lukee tiedoston nykyiseen zsh-istuntoon; shebangia ei tarvita.

# Päätteen otsikko ja asetusten automaattipäivitys.
function precmd {
  printf "\033]0;%s@%s:%s\007" "${USER}" "`hostname -s`" "${PWD/#$HOME/~}"
}

function _current_time() {
  echo $(($(date +%s) / 60 / 60 / 24))
}

function _update_time() {
  echo "UPDATE_TIME=$(_current_time)" > ~/.oh-my-zsh/custom/.joni-lastupdate
}

if [ ! -f ~/.oh-my-zsh/custom/.joni-lastupdate ]; then
  _update_time
else
  source ~/.oh-my-zsh/custom/.joni-lastupdate
  CURRENT_TIME=$(_current_time)
  TIME_DIFF=$(($CURRENT_TIME-$UPDATE_TIME))

  if [ $TIME_DIFF -gt 13 ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/jonikanerva/dotfiles/main/terminal-setup.sh)"
    _update_time
  fi
fi

# Teema (aiemmin joni-two.zsh-theme).
function kube_prompt() {
  if [ ! -f "Jenkinsfile" ]; then
    return
  fi

  context=$(kubectl config current-context 2> /dev/null) || return

  echo "%{$reset_color%} ‹k8s in %{$fg[yellow]%}${context}%{$reset_color%}›"
}

function git_prompt_check() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%{$reset_color%} at %{$fg[magenta]%}${ref#refs/heads/}"

  if [ ! -f ".git/FETCH_HEAD" ]; then
    return
  fi

  # On mac do git fetch automatically if not done in the last 24h
  if [[ `uname` == 'Darwin' ]]; then
    last_fetch=$(stat -f "%Sm" -t "%s" .git/FETCH_HEAD)
    time_now=$(date +%s)
    time_diff=$((($time_now-$last_fetch) / 60 / 60))

    if [ $time_diff -gt 24 ]; then
      git fetch
      git remote prune origin > /dev/null
    fi
  fi
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
MACHINE="%{$fg[yellow]%}$(scutil --get ComputerName)"
DIR="%{$fg[green]%}%~%"

PROMPT='$NAME %{$reset_color%}on $MACHINE %{$reset_color%}in $DIR $(git_prompt_check)$(git_prompt_status)$(git_remote_check)
%{$fg[cyan]%}$ %{$reset_color%}'
RPROMPT=''

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[white]%} ✱"

# Listaa ServiceManagementilla sovellusten sisältä ladatut apuohjelmat.
# Koittaa selvittää mitkä sovellukset käynnistyvät automaattisesti.
# launchctl-tuloste ei ole vakaa rajapinta; testattu macOS 27.0.1:ssä.

# Korvaa mahdollinen samanniminen aiempi alias.
unalias startup-apps 2>/dev/null

function startup-apps {
  emulate -L zsh
  setopt PIPE_FAIL

  typeset -A startup_app_paths startup_found_apps
  typeset startup_root startup_app_path startup_bundle_id
  typeset startup_domain startup_domain_dump startup_label startup_job_dump
  typeset startup_registered_app startup_error=0
  typeset startup_uid=$(/usr/bin/id -u)

  # Selvitä sovellusten polut ilman Spotlight-riippuvuutta.
  for startup_root in /Applications "$HOME/Applications"; do
    [[ -d "$startup_root" ]] || continue
    while IFS= read -r -d '' startup_app_path; do
      startup_bundle_id=$(/usr/bin/plutil -extract CFBundleIdentifier raw -o - \
        "$startup_app_path/Contents/Info.plist" 2>/dev/null) || continue
      [[ -n "$startup_bundle_id" ]] && \
        startup_app_paths[$startup_bundle_id]="$startup_app_path"
    done < <(/usr/bin/find "$startup_root" -type d -name '*.app' -prune -print0)
  done

  for startup_domain in "gui/$startup_uid" "user/$startup_uid" system; do
    startup_domain_dump=$(/bin/launchctl print "$startup_domain") || {
      print -u2 -r -- "Listaus jäi vajaaksi: $startup_domain ei ollut luettavissa."
      startup_error=1
      continue
    }

    while IFS= read -r startup_label; do
      case "$startup_label" in
        com.apple.*|application.*) continue ;;
      esac

      startup_job_dump=$(/bin/launchctl print "$startup_domain/$startup_label" 2>/dev/null) || {
        print -u2 -r -- "Palvelua ei saatu luettua: $startup_label"
        startup_error=1
        continue
      }

      startup_registered_app=$(print -r -- "$startup_job_dump" | /usr/bin/awk -v user_home="$HOME" '
        /^[[:space:]]*managed_by = com.apple.xpc.ServiceManagement$/ { managed = 1 }
        /^[[:space:]]*path = / {
          origin = $0
          sub(/^[[:space:]]*path = /, "", origin)
          if (index(origin, "/Library/LaunchAgents/") == 1 ||
              index(origin, "/Library/LaunchDaemons/") == 1 ||
              index(origin, user_home "/Library/LaunchAgents/") == 1) legacy = 1
        }
        /^[[:space:]]*parent bundle identifier = / {
          sub(/^[[:space:]]*parent bundle identifier = /, "")
          bundle = $0
        }
        END {
          if (managed && !legacy && bundle != "" && bundle !~ /^com\.apple\./) print bundle
        }
      ')

      [[ -n "$startup_registered_app" ]] && startup_found_apps[$startup_registered_app]=1
    done < <(print -r -- "$startup_domain_dump" | /usr/bin/awk '
      /^[[:space:]]*services = \{/ { inside = 1; next }
      inside && /^[[:space:]]*\}/ { exit }
      inside && NF >= 3 { print $3 }
    ')
  done

  if (( ${#startup_found_apps} )); then
    for startup_bundle_id in ${(k)startup_found_apps}; do
      if [[ -n "${startup_app_paths[$startup_bundle_id]}" ]]; then
        print -r -- "${startup_app_paths[$startup_bundle_id]}"
      else
        print -r -- "$startup_bundle_id (sovelluksen polkua ei löytynyt)"
      fi
    done | /usr/bin/sort -fu
  else
    print -r -- "Ei löytynyt sovellusten sisältä ladattuja käynnistysapuohjelmia."
  fi

  return "$startup_error"
}

# Worktree-komennot (aiemmin git-worktree.zsh).
# git-clean-repo säilyttää main-haaran ja nykyisen haaran paikallisesti ja originissa.
# Muut haarat ja linkitetyt worktreet poistetaan pakotetusti, myös niiden
# commitoimattomat ja seuraamattomat tiedostot. Aja alkuperäisessä worktreessä.
unalias gwt git-clean-repo 2>/dev/null

gwt() {
  if (( $# != 1 )); then
    print -u2 'Käyttö: gwt <haara>'
    return 1
  fi

  git rev-parse --git-dir >/dev/null 2>&1 || {
    print -u2 'Suorita komento Git-repositorion sisältä.'
    return 1
  }

  local record wt_dir
  while IFS= read -r -d '' record; do
    case "$record" in
      "worktree "*) wt_dir="${record#worktree }" ;;
      "branch refs/heads/$1")
        builtin cd -- "$wt_dir"
        return $?
        ;;
    esac
  done < <(git worktree list --porcelain -z)

  print -u2 -- "Haaralle '$1' ei löytynyt worktreetä."
  return 1
}

git-clean-repo() (
  emulate -L zsh

  local current root gd common refs oid ref branch entry wt
  local -a remote_delete

  current=$(git symbolic-ref --quiet --short HEAD) || {
    print -u2 'Keskeytetty: HEAD ei ole branchissa.'
    return 1
  }

  root=$(git rev-parse --show-toplevel) || return
  gd=$(git rev-parse --absolute-git-dir) || return
  common=$(git rev-parse --path-format=absolute --git-common-dir) || return

  [[ ${gd:A} == ${common:A} ]] || {
    print -u2 'Aja tämä alkuperäisessä worktreessä, ei linkitetyssä worktreessä.'
    return 1
  }

  cd "$root" || return
  du -sh . || return

  # Listaa poistettavat haarat suoraan remotesta.
  refs=$(git ls-remote --heads origin) || return

  while IFS=$'\t' read -r oid ref; do
    [[ -n "$ref" ]] || continue
    branch=${ref#refs/heads/}
    [[ "$branch" == main || "$branch" == "$current" ]] && continue
    remote_delete+=("$ref")
  done <<< "$refs"

  # Poista remote-haarat ennen paikallisia poistoja.
  if (( ${#remote_delete} )); then
    git push --atomic --delete origin "${remote_delete[@]}" || return
  fi

  # Poista kaikki muut worktreet, myös lukitut ja muutoksia sisältävät.
  while IFS= read -r -d '' entry; do
    [[ "$entry" == 'worktree '* ]] || continue
    wt=${entry#worktree }
    [[ ${wt:A} == ${root:A} ]] && continue
    git worktree remove --force --force -- "$wt" || return
  done < <(git worktree list --porcelain -z)

  git worktree prune --expire now || return

  # Poista muut paikalliset haarat täsmällisen nimen perusteella.
  while IFS= read -r branch; do
    [[ "$branch" == main || "$branch" == "$current" ]] && continue
    git branch -D -- "$branch" || return
  done < <(git for-each-ref --format='%(refname:strip=2)' refs/heads/)

  git fetch --prune origin && git gc && du -sh .
)
