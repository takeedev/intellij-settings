#!/usr/bin/env sh

cmd=idea
if uname | grep -q "^MINGW"; then
  if command -v idea.cmd >/dev/null 2>&1; then
    cmd=idea.cmd
  elif command -v idea64 >/dev/null 2>&1; then
    cmd=idea64
  else
    echo "Warning: neither idea.cmd nor idea64 found, falling back to idea"
  fi
fi

$cmd installPlugins \
  "PlantUML integration" \
  IdeaVIM \
  com.github.camork.fileExpander \
  com.intellij.ml.llm \
  com.intellij.plugins.macoskeymap \
  com.joshestein.ideavim-quickscope \
  com.julienphalip.ideavim.peekaboo \
  dev.turingcomplete.intellijdevelopertoolsplugins \
  eu.theblob42.idea.whichkey \
  org.asciidoctor.intellij.asciidoc \
  org.jetbrains.jumpToLine
