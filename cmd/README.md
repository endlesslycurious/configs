# Windows theme setup

## Prerequisites

These should be installed by `winget`.

- [oh-my-posh](https://ohmyposh.dev/) prompt configurator.
- [clink](https://chrisant996.github.io/clink/) GNU readline for Windows.
- [Python](https://www.python.org/) 3.x (only needed to apply the Terminal
  themes and light/dark defaults; the colour schemes work without it).

## Setup

Run `setup.bat` from the repository root. It:

- installs the Catppuccin Latte and Frappe colour schemes as a Windows Terminal
  JSON fragment;
- installs the matching tab/window themes and sets the app theme, default
  profile colour scheme and default font face (requires Python; Frappe remains
  installed for a manual switch);
- backs up `settings.json` before changing it;
- points the clink oh-my-posh prompt at Catppuccin Latte.

Restart Windows Terminal afterwards. A portable Terminal install stores
`settings.json` beside the executable and is not detected automatically; run
`cmd\apply-windows-terminal.py --settings <path>` manually if needed.

### Terminal font

oh-my-posh needs a [Nerd Font](https://www.nerdfonts.com/) for its glyphs;
without one the prompt renders a missing-glyph box (a question mark in a
diamond). This repo standardises on JetBrainsMono Nerd Font, matching
`ghostty/config.ghostty`.

1. Install it with `oh-my-posh font install JetBrainsMono`. This pulls the
   release straight from [ryanoasis/nerd-fonts][nf] and installs per-user, so it
   needs no elevation.
2. Run `setup.bat`, which sets `profiles.defaults.font.face` to
   `JetBrainsMono Nerd Font Mono` so every profile picks it up, including WSL.
3. Restart Windows Terminal.

Profiles that pin their own `font.face` bypass the default; the script lists
them when it runs.

The font is deliberately **not** in `winget/*.txt`. The former
`NerdFonts.JetBrainsMono` package was withdrawn from the winget source, and its
replacement (`DEVCOM.JetBrainsMonoNerdFont`) is an elevated MSI from a small
unverified publisher that repackages the same upstream release. Installing via
oh-my-posh gets identical fonts with a shorter trust chain. The trade-off is
that a rebuilt machine will install oh-my-posh but not the font, so step 1 has
to be run by hand.

[nf]: https://github.com/ryanoasis/nerd-fonts

### Terminal prompt

Following these [oh my posh instructions](https://ohmyposh.dev/docs/installation/prompt):
1. Use `clink info` to find the location of clinks scripts directory.
2. Create the file `oh-my-posh.lua` in that location with the following contents:
```
load(io.popen('oh-my-posh init cmd'):read("*a"))()
```
3. Restart cmd/terminal for the change to take effect.
4. Set oh-my-posh as the default for clink with `clink config prompt use oh-my-posh`.
5. Locate the oh-my-posh theme directory via the environment variable `POSH_THEMES_PATH`
6. `setup.bat` sets clinks theme to Catppuccin Latte automatically. To do it by
   hand, run `clink set ohmyposh.theme %POSH_THEMES_PATH%\catppuccin_latte.omp.json`
   (use `catppuccin_frappe.omp.json` for the dark theme).

The clink prompt is static; it does not follow the terminal theme automatically.
