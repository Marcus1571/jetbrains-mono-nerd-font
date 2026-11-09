#!/bin/sh
# Install JetBrains Mono Nerd Font (all 96 .ttf files) on macOS or Linux.
# Sources, most to least desirable: the official Nerd Fonts release, this repo's release, this repo's split parts.
set -eu
VERSION=v3.5.1
SHA256=fab782a66f7d3019da64f6572db9fc5d3a4bcb19f9fa13e2d8a62e3693d6396e
REPO=Marcus1571/jetbrains-mono-nerd-font
OFFICIAL=https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
MIRROR=https://github.com/$REPO/releases/download/$VERSION/JetBrainsMono.zip
PARTS=https://raw.githubusercontent.com/$REPO/main/backup/JetBrainsMono.zip.part-

case $(uname -s) in
  Darwin) DEST="$HOME/Library/Fonts" ;;
  Linux)  DEST="${XDG_DATA_HOME:-$HOME/.local/share}/fonts" ;;
  *) echo "Unsupported OS. On Windows follow the manual steps in README.md." >&2; exit 1 ;;
esac
TMP=$(mktemp -d); trap 'rm -rf "$TMP"' EXIT
ZIP="$TMP/JetBrainsMono.zip"

sha() { if command -v sha256sum >/dev/null; then sha256sum "$1"; else shasum -a 256 "$1"; fi | cut -d' ' -f1; }
readable() { unzip -tq "$ZIP" >/dev/null 2>&1; }
pinned() { readable && [ "$(sha "$ZIP")" = "$SHA256" ]; }

if curl -fsSL "$OFFICIAL" -o "$ZIP" && readable; then
  src="official Nerd Fonts release (latest)"
elif curl -fsSL "$MIRROR" -o "$ZIP" && pinned; then
  src="mirror release $VERSION"
else
  : > "$ZIP"
  for p in aa ab ac; do curl -fsSL "$PARTS$p" >> "$ZIP" || break; done
  pinned || { echo "All three sources failed. See README.md for the manual steps." >&2; exit 1; }
  src="mirror split parts $VERSION"
fi

mkdir -p "$DEST"
unzip -o -q "$ZIP" '*.ttf' -d "$DEST"
if command -v fc-cache >/dev/null; then fc-cache -f "$DEST" >/dev/null; fi
echo "Installed $(unzip -Z1 "$ZIP" '*.ttf' | wc -l | tr -d ' ') fonts into $DEST from the $src."
