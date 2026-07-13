#!/usr/bin/env sh

# configs
for config_path in \
  "$HOME"/.config/JetBrains/IdeaIC* \
  "$HOME"/.config/JetBrains/IntelliJIdea* \
  "$HOME"/Library/Application\ Support/JetBrains/IdeaIC* \
  "$HOME"/Library/Application\ Support/JetBrains/IntelliJIdea* \
  "$HOME"/AppData/Roaming/JetBrains/IdeaIC* \
  "$HOME"/AppData/Roaming/JetBrains/IntelliJIdea*; do
  if [ -d "$config_path" ]; then
  echo "$config_path"
    # install code styles
    mkdir -p "$config_path/codestyles"
    cp -frv "config/codestyles"/* "$config_path/codestyles"

    # install keymaps
    mkdir -p "$config_path/keymaps"
    cp -frv "config/keymaps"/* "$config_path/keymaps"

    # install settings
    mkdir -p "$config_path/options"
    cp -frv "config/options"/* "$config_path/options"

    # install templates
    mkdir -p "$config_path/templates"
    cp -frv "config/templates"/* "$config_path/templates"

  fi
done

# plugins
sh ./install-plugins-ij.sh

# ideavim
cp -f ./ideavim/.ideavimrc "$HOME"/.ideavimrc
