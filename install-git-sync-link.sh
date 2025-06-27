#!/bin/bash

# Resolve script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN="$HOME/.local/bin"

# Ensure ~/.local/bin exists
mkdir -p "$LOCAL_BIN"

# Create symlinks
ln -sf "$SCRIPT_DIR/git-sync" "$LOCAL_BIN/git-sync"
ln -sf "$SCRIPT_DIR/add-sync-shortcuts" "$LOCAL_BIN/add-sync-shortcuts"
ln -sf "$SCRIPT_DIR/add-termux-widget-sync-shortcuts" "$LOCAL_BIN/add-termux-widget-sync-shortcuts"

echo "✅ Symlinks created:"
echo "  $LOCAL_BIN/git-sync -> $SCRIPT_DIR/git-sync"
echo "  $LOCAL_BIN/add-sync-shortcuts -> $SCRIPT_DIR/add-sync-shortcuts"
echo "  $LOCAL_BIN/add-termux-widget-sync-shortcuts -> $SCRIPT_DIR/add-termux-widget-sync-shortcuts"

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
