#!/usr/bin/env sh

RAW_INTELLIJ_SETTINGS_URL="https://raw.githubusercontent.com/takeedev/intellij-settings/refs/heads/main"
RAW_IDEAVIM_URL="https://raw.githubusercontent.com/takeedev/intellij-settings/refs/heads/main/ideavim"

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
    echo "Error: IntelliJ IDEA is running. Close all IntelliJ IDEA processes before installing settings." >&2
    exit 1
  fi
}

create_backup_root() {
  backup_base=${INTELLIJ_SETTINGS_BACKUP_DIR:-"$HOME/.intellij-settings-backups"}
  backup_timestamp=$(date '+%Y%m%d-%H%M%S')
  BACKUP_ROOT="$backup_base/$backup_timestamp"

  if [ -e "$BACKUP_ROOT" ]; then
    BACKUP_ROOT="$BACKUP_ROOT-$$"
  fi

  (umask 077 && mkdir -p "$BACKUP_ROOT/config" "$BACKUP_ROOT/home") || exit 1
  echo "Backup directory: $BACKUP_ROOT"
}

backup_config() {
  config_path=$1

  case "$config_path" in
    "$HOME"/*) relative_path=${config_path#"$HOME"/} ;;
    *) relative_path=$(basename "$config_path") ;;
  esac

  backup_target="$BACKUP_ROOT/config/$relative_path"
  mkdir -p "$backup_target" || exit 1

  for item in codestyles keymaps options templates; do
    if [ -e "$config_path/$item" ]; then
      cp -pR "$config_path/$item" "$backup_target/" || exit 1
    fi
  done
}

backup_ideavimrc() {
  if [ -e "$HOME/.ideavimrc" ]; then
    cp -p "$HOME/.ideavimrc" "$BACKUP_ROOT/home/.ideavimrc" || exit 1
  fi
}

ensure_intellij_is_stopped
create_backup_root

# config paths
for config_path in \
  "$HOME"/.config/JetBrains/IntelliJIdea* \
  "$HOME"/Library/Application\ Support/JetBrains/IntelliJIdea* \
  "$HOME"/AppData/Roaming/JetBrains/IntelliJIdea*; do
  if [ -d "$config_path" ]; then
    echo "$config_path"
    backup_config "$config_path"
    # install code styles
    mkdir -p "$config_path/codestyles"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/codestyles/Default.xml" -o "$config_path/codestyles/Default.xml"

    # install keymaps
    mkdir -p "$config_path/keymaps"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/keymaps/chubbyhippo.xml" -o "$config_path/keymaps/chubbyhippo.xml"

    # install options
    mkdir -p "$config_path/options"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/editor.xml" -o "$config_path/options/editor.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/laf.xml" -o "$config_path/options/laf.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/colors.scheme.xml" -o "$config_path/options/colors.scheme.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/postfixTemplates.xml" -o "$config_path/options/postfixTemplates.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/projectView.xml" -o "$config_path/options/projectView.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/ui-datetime.xml" -o "$config_path/options/ui-datetime.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/ui.lnf.xml" -o "$config_path/options/ui.lnf.xml"
    mkdir -p "$config_path/options/mac"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/mac/keymap.xml" -o "$config_path/options/mac/keymap.xml"
    mkdir -p "$config_path/options/windows"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/options/windows/keymap.xml" -o "$config_path/options/windows/keymap.xml"

    # install templates
    mkdir -p "$config_path/templates"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/templates/javaJava.xml" -o "$config_path/templates/javaJava.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/templates/javaJackson.xml" -o "$config_path/templates/javaJackson.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/templates/javaJUnit.xml" -o "$config_path/templates/javaJUnit.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/templates/javaMockito.xml" -o "$config_path/templates/javaMockito.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/templates/javaSpring.xml" -o "$config_path/templates/javaSpring.xml"
    curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/config/templates/javaWireMock.xml" -o "$config_path/templates/javaWireMock.xml"

  fi
done

# install .ideavimrc
backup_ideavimrc
curl -ksS "$RAW_IDEAVIM_URL/.ideavimrc" -o ~/.ideavimrc

# install plugins
curl -ksS "$RAW_INTELLIJ_SETTINGS_URL/install-plugins-ij.sh" | /usr/bin/env sh
