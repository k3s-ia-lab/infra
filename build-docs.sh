#!/bin/bash
mkdir -p ./docs/apps

yq -i '(.nav[] | select(has("Apps")).Apps) = []' mkdocs.yml

find ./apps -mindepth 1 -maxdepth 1 -type d | sort | while read appdir; do
  if [ -d "$appdir" ]; then
    APPNAME=$(basename "$appdir")
    SRC="$appdir/README.md"
    DEST="./docs/apps/${APPNAME}.md"
    if [ -f "$SRC" ]; then
      cp "$SRC" "$DEST"
      echo "apps/${APPNAME}.md"
      APP_TMP=("apps/${APPNAME}.md")
      yq -i '(.nav[] | select(has("Apps")) | .Apps) += ["'"$APP_TMP"'"]' mkdocs.yml
    fi
  fi
done
