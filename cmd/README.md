# Windows theme setup

## Prerequistes

These should be getting installed by `winget`.

- [oh-my-posh](https://ohmyposh.dev/) prompt configurator.
- [clink](https://chrisant996.github.io/clink/) GNU readline for windows.
- (Catppuccin) [Windows-Terminal](https://github.com/catppuccin/windows-terminal) theme.

## Setup

Sadly this is a fairly manual process!

### Terminal Font

1. Install the hack font with `oh-my-posh font install hack`.
2. Reload cmd/terminal and select the default font in settings.

### Terminal Colour Scheme

Follow the catppuccin [windows-terminal instructions](https://github.com/catppuccin/windows-terminal) to modify Windows Terminal's config file.

### Terminal Prompt

Following these [oh my posh instructions](https://ohmyposh.dev/docs/installation/prompt):
1. Use `clink info` to find the location of clinks scripts directory.
2. Create the file `oh-my-posh.lua` in that location with the following contents:
```
load(io.popen('oh-my-posh init cmd'):read("*a"))()
```
3. Restart cmd/terminal for the change to take effect.
4. Set oh-my-posh as the default for clink with `clink config prompt use oh-my-posh`.
5. Locate the oh-my-posh theme directory via the environment variable `POSH_THEMES_PATH`
6. Set clinks theme to catppuccin machiato with `clink set ohmyposh.theme C:\Users\daniel\AppData\Local\Programs\oh-my-posh\themes\catppuccin_macchiato.omp.json`.
