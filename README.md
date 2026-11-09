# JetBrains Mono Nerd Font, with a backup

[JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) patched with
[Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) icons, installable even when the
official download is down. This repo keeps an exact copy of the official zip
(Nerd Fonts v3.5.1, 96 `.ttf` files: Nerd Font, Mono, Propo and their NL variants), so
there is always a second place to get it from.

## Install (macOS or Linux)

```sh
curl -fsSL https://raw.githubusercontent.com/Marcus1571/jetbrains-mono-nerd-font/main/install.sh | sh
```

The script tries three sources, most desirable first, and stops at the first that works:

1. **Official Nerd Fonts release** (always the latest version).
2. **This repo's release** `v3.5.1`: the same zip, byte for byte, checked against its SHA-256.
3. **This repo's split parts** in [`backup/`](backup): the same zip cut into three pieces
   under GitHub's 100 MB file limit, joined back and checked. These come from a
   different GitHub server than releases, so they still work when release downloads don't.

It installs into `~/Library/Fonts` on macOS and `~/.local/share/fonts` on Linux,
then restart the apps that should use the font.

## Install by hand

Get the zip from the first source that works, then install the fonts from it.

1. Official: <https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip>
2. Mirror: <https://github.com/Marcus1571/jetbrains-mono-nerd-font/releases/download/v3.5.1/JetBrainsMono.zip>
3. Split parts: download the three files in [`backup/`](backup) (or the whole repo with
   **Code → Download ZIP**) and join them:
   - macOS / Linux: `cat JetBrainsMono.zip.part-aa JetBrainsMono.zip.part-ab JetBrainsMono.zip.part-ac > JetBrainsMono.zip`
   - Windows (Command Prompt): `copy /b JetBrainsMono.zip.part-aa + JetBrainsMono.zip.part-ab + JetBrainsMono.zip.part-ac JetBrainsMono.zip`

   Check it with `shasum -a 256 JetBrainsMono.zip` (Windows: `certutil -hashfile JetBrainsMono.zip SHA256`);
   it must match the last line of [`backup/SHA256SUMS`](backup/SHA256SUMS).

Then unzip it and install the `.ttf` files:

- **macOS:** select them all, double-click, **Install** in Font Book (or copy them into `~/Library/Fonts`).
- **Windows:** select them all, right-click → **Install for all users**.
- **Linux:** copy them into `~/.local/share/fonts` and run `fc-cache -f`.

## License

The fonts are under the SIL Open Font License 1.1 ([`LICENSE`](LICENSE)), redistributed
unmodified. `install.sh` is MIT-licensed.
