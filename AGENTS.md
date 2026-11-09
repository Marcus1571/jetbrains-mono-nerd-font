# AGENTS.md

**Governance first.** At the start of any session in this project, read the operator's
`GOVERNANCE.md` and `USER.md` from their working copy (the operator's private
governance repo); they hold the operator's cross-project defaults. This file governs
when the two disagree on a project-specific fact, except cross-cutting principles
(secrets handling, destructive-action caution and the like), which apply everywhere.

## What this project is

A public backup of the official Nerd Fonts `JetBrainsMono.zip`, plus `install.sh`,
which tries the official release, then this repo's release, then the split parts in
`backup/`. Created after a day when the official download failed everywhere.

## Rules

- The zip is never modified: the release asset and the joined parts must be
  byte-identical to the official file, and `backup/SHA256SUMS` proves it.
- Parts stay under GitHub's 100 MB per-file limit (`split -b 45m`).
- `install.sh` stays POSIX `sh` and runs on stock macOS and Linux (no Homebrew, no git).

## Updating to a new Nerd Fonts version

1. Download `https://github.com/ryanoasis/nerd-fonts/releases/download/<version>/JetBrainsMono.zip`, run `unzip -tq` on it.
2. `split -b 45m JetBrainsMono.zip JetBrainsMono.zip.part-` into `backup/` (delete the old parts first); regenerate `backup/SHA256SUMS` (parts, then the zip).
3. In `install.sh`, update `VERSION`, `SHA256` and the part list if their number changed; update README's version and link.
4. Test the three sources (see STATUS.md for how), then run the release sequence from `USER.md` with the zip attached to the GitHub release.
