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
