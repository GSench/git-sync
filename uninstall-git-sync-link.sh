#!/bin/bash

LOCAL_BIN="$HOME/.local/bin"
FILES=("git-sync" "add-sync-shortcuts" "add-termux-widget-sync-shortcuts")

echo "🔧 Uninstalling git-sync tools from $LOCAL_BIN..."

for file in "${FILES[@]}"; do
  target="$LOCAL_BIN/$file"
  if [ -e "$target" ]; then
    rm -f "$target"
    echo "❌ Removed $target"
  else
    echo "ℹ️  $target not found"
  fi
done

# # Optionally, offer to remove PATH export from .bashrc (interactive)
# echo ""
# read -p "🧼 Do you want to remove PATH export line from ~/.bashrc? [y/N] " reply
# if [[ "$reply" =~ ^[Yy]$ ]]; then
#   sed -i '/export PATH="\$HOME\/\.local\/bin:\$PATH"/d' "$HOME/.bashrc"
#   echo "✅ Removed PATH line from ~/.bashrc"
# else
#   echo "⏩ Skipped editing ~/.bashrc"
# fi
