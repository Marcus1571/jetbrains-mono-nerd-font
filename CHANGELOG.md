# Changelog

## v1.0.1 (2026-11-09)

- Fix: the mirror-release source pointed at a tag named after the Nerd Fonts version (v3.5.1) instead of this repo's release, so it always returned 404 and fell through to the split parts. It now uses this repo's latest release.

## v1.0.0 (2026-11-09)

- Mirror of Nerd Fonts v3.5.1 `JetBrainsMono.zip`: release asset plus three split parts in `backup/` with SHA-256 sums.
- `install.sh` for macOS and Linux: official release first, then the mirror release, then the split parts.
- README with the same three sources by hand, Windows included.
