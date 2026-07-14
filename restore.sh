#!/usr/bin/env sh

set -eu

usage() {
  printf 'Usage: %s [backup-directory]\n' "$0" >&2
}

is_intellij_running() {
  os_name=$(uname 2>/dev/null || printf 'unknown')

  case "$os_name" in
    MINGW*|MSYS*|CYGWIN*)
      if command -v tasklist >/dev/null 2>&1; then
        tasklist 2>/dev/null | grep -Eiq '(^|[[:space:]])idea(64)?\.exe([[:space:]]|$)'
        return
      fi
      ;;
  esac

  if command -v pgrep >/dev/null 2>&1; then
    if pgrep -x 'idea|idea64' >/dev/null 2>&1; then
      return 0
    fi
    pgrep -f 'IntelliJ IDEA\.app/Contents/MacOS/idea|com\.intellij\.idea\.Main|-Didea\.paths\.selector=(IntelliJIdea|IdeaIC)|/idea(64)?([[:space:]]|$)' >/dev/null 2>&1
    return
  fi

  ps -ef 2>/dev/null | grep -Ei '[I]ntelliJ IDEA|[I]ntelliJIdea|[I]deaIC|com\.intellij\.idea\.Main|/[i]dea(64)?([[:space:]]|$)' >/dev/null 2>&1
}

ensure_intellij_is_stopped() {
  if is_intellij_running; then
    printf '%s\n' 'Error: IntelliJ IDEA is running. Close all IntelliJ IDEA processes before restoring settings.' >&2
    exit 1
  fi
}

restore_config() {
  backup_config_path=$1
  relative_path=${backup_config_path#"$backup_root/config/"}
  config_path="$HOME/$relative_path"

  mkdir -p "$config_path"

  for item in codestyles keymaps options templates; do
    rm -rf "$config_path/$item"
    if [ -e "$backup_config_path/$item" ] || [ -L "$backup_config_path/$item" ]; then
      cp -pR "$backup_config_path/$item" "$config_path/"
    fi
  done

  printf 'Restored IntelliJ configuration: %s\n' "$config_path"
}

find_latest_backup() {
  backup_base=${INTELLIJ_SETTINGS_BACKUP_DIR:-"$HOME/.intellij-settings-backups"}
  latest_backup=

  for candidate in "$backup_base"/*; do
    [ -d "$candidate/config" ] || continue
    [ -d "$candidate/home" ] || continue

    candidate_name=${candidate##*/}
    case "$candidate_name" in
      [0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]*) ;;
      *) continue ;;
    esac

    latest_backup=$candidate
  done

  printf '%s\n' "$latest_backup"
}

case "$#" in
  0)
    requested_backup=$(find_latest_backup)
    if [ -z "$requested_backup" ]; then
      backup_base=${INTELLIJ_SETTINGS_BACKUP_DIR:-"$HOME/.intellij-settings-backups"}
      printf 'Error: no valid backups found under: %s\n' "$backup_base" >&2
      exit 1
    fi
    printf 'Using latest backup: %s\n' "$requested_backup"
    ;;
  1)
    requested_backup=$1
    ;;
  *)
    usage
    exit 2
    ;;
esac

if [ ! -d "$requested_backup" ]; then
  printf 'Error: backup directory not found: %s\n' "$requested_backup" >&2
  exit 1
fi

backup_root=$(cd "$requested_backup" 2>/dev/null && pwd -P) || {
  printf 'Error: cannot access backup directory: %s\n' "$requested_backup" >&2
  exit 1
}

if [ ! -d "$backup_root/config" ] || [ ! -d "$backup_root/home" ]; then
  printf 'Error: invalid backup directory: %s\n' "$backup_root" >&2
  exit 1
fi

ensure_intellij_is_stopped

restored_config_count=0
for backup_config_path in \
  "$backup_root"/config/.config/JetBrains/IdeaIC* \
  "$backup_root"/config/.config/JetBrains/IntelliJIdea* \
  "$backup_root"/config/Library/Application\ Support/JetBrains/IdeaIC* \
  "$backup_root"/config/Library/Application\ Support/JetBrains/IntelliJIdea* \
  "$backup_root"/config/AppData/Roaming/JetBrains/IdeaIC* \
  "$backup_root"/config/AppData/Roaming/JetBrains/IntelliJIdea*; do
  [ -d "$backup_config_path" ] || continue
  restore_config "$backup_config_path"
  restored_config_count=$((restored_config_count + 1))
done

if [ -e "$backup_root/home/.ideavimrc" ] || [ -L "$backup_root/home/.ideavimrc" ]; then
  cp -p "$backup_root/home/.ideavimrc" "$HOME/.ideavimrc"
  printf 'Restored IdeaVim configuration: %s\n' "$HOME/.ideavimrc"
else
  rm -f "$HOME/.ideavimrc"
  printf 'Removed IdeaVim configuration because it did not exist in the backup.\n'
fi

if [ "$restored_config_count" -eq 0 ]; then
  printf '%s\n' 'No IntelliJ configuration directories were present in this backup.'
fi

printf 'Restore completed from: %s\n' "$backup_root"
