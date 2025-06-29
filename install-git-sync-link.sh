#!/bin/bash

# Resolve script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"

# Ensure ~/.local/bin exists
mkdir -p "$LOCAL_BIN"

# Install and verify symlink for a given script
install_symlink() {
  local script_name="$1"
  local source_path="$SCRIPT_DIR/$script_name"
  local target_path="$LOCAL_BIN/$script_name"

  rm -f "$target_path"
  ln -sf "$source_path" "$target_path"

  if [ -L "$target_path" ]; then
    echo "✅ Symlink created: $target_path -> $source_path"
  else
    echo "⚠️ WARNING: $target_path is not a symlink."
    echo "   It was copied or your platform does not support symlinks properly."
    echo "   If you update the script later, rerun this installer to reflect changes."
  fi
}

# Create symlinks
install_symlink "git-sync"
install_symlink "add-sync-shortcuts"
install_symlink "add-termux-widget-sync-shortcuts"

# Add ~/.local/bin to PATH in .bashrc if needed
if ! echo "$PATH" | grep -q "$LOCAL_BIN"; then
  echo -e "\n⚠️  WARNING: ~/.local/bin is not in your PATH."

  if ! grep -qx 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
    echo "✅ Added PATH update to ~/.bashrc"
  else
    echo "ℹ️  PATH entry already exists in ~/.bashrc"
  fi

  if [ -f "$HOME/.bashrc" ]; then
    echo "   Sourcing ~/.bashrc..."
    source "$HOME/.bashrc"
    echo "✅ PATH updated and shell reloaded."
  else
    echo "⚠️ Could not find ~/.bashrc to source. Please restart your shell manually."
  fi
else
  echo "✅ ~/.local/bin is already in your PATH."
fi
