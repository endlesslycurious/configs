This repo contains various configuration files I use for development.

## Cloning

You need to close this repository with the `--recurse-submodules` option or run `git submodule init` then `git submodule update` after cloning to update the submodules.

### Submodules

* Neovim configuration from my kickstart fork.

The Catppuccin Windows Terminal schemes and themes are vendored in `cmd/windows-terminal`.

## Windows Setup

You need to set `HOME` environment vairable to `%USERPROFILE%` then open new console to get git to clone this repo!

## Setup scripts

Sets up symbolic links from files in repo to expected install locations on disk.

* Mac & Linux - setup.sh (use 'chmod u+x setup.sh' to make this script executable)
* Windows - setup.bat

## Editor Configuration files

* NeoVim - `nvim` folder (Catppuccin Latte; Frappe definition retained)
* Zed - `zed` folder (Catppuccin Latte; Frappe definition retained)

## Environment Configuration files

* Bash - `bash/.bash_profile` for Mac
* Delta - `delta` folder (Catppuccin Latte/Frappe diff themes)
* Ghostty - `ghostty` folder
* Herdr - `herdr/config.toml` (Catppuccin Latte UI; Frappe retained). Managed
  as a symlink; Herdr's Settings UI writes to this file, so prefer editing the
  repo copy to keep the working tree clean.
* oh-my-posh - `oh-my-posh/themes` (vendored Catppuccin Latte and Frappe prompt
  themes; selected by `THEME_MODE`; used by zsh on Mac and bash on Linux/WSL)
* Shell theme - `shell/ls_colors.sh` (Catppuccin Latte `LS_COLORS`, delta, bat,
  k9s and btop theme selection; Frappe retained)
* Zsh - `zsh/.zshrc` for Mac

### Ghostty themes & fonts

Theme setup is handled by the `theme` key in `ghostty/config.ghostty`. The font
and colours are managed in that file, pinned to Catppuccin Latte.

### Switching to Frappe

The config is static (Catppuccin Latte) so the terminal background and tool
colours cannot drift apart. To switch the whole setup to the dark Frappe theme,
change these values:

1. `ghostty/config.ghostty` - `theme = Catppuccin Frappe`
2. `shell/ls_colors.sh` - `THEME_MODE="dark"` (also switches the oh-my-posh theme)
3. `nvim/lua/custom/plugins/catppuccin.lua` - `flavour = 'frappe'` and
   `vim.o.background = 'dark'`
4. `zed/settings.json` - `"mode": "dark"`
5. `herdr/config.toml` - `name = "catppuccin"`
6. Windows: change `LIGHT` to `DARK` in `cmd/apply-windows-terminal.py`, rerun
   `setup.bat`, and set the clink prompt to `catppuccin_frappe.omp.json`

`setup.sh` also sets `delta.features` to `catppuccin-latte`; change it to
`catppuccin-frappe` at the same time. lazygit and opencode follow the terminal,
so they switch automatically.

## Tool Configuration files

* btop - `btop` folder (Catppuccin Latte; Frappe theme retained)
* k9s - `k9s` folder (Catppuccin Latte; Frappe skin retained)
* Lazygit - `lazygit` folder (Catppuccin Latte/Frappe UI; follows the terminal)
* opencode - `opencode` folder (theme: system, follows the terminal)

## Package manifests

* Homebrew for Mac - `brew/Brewfile.*.local`
* mise for Linux - `mise/config.toml` (Raspberry Pi OS + Ubuntu on WSL)
* Win Get for Windows Store `winget/*.txt`

Note: `herdr` is installed manually on Windows (no WinGet package).

### Linux (Raspberry Pi OS & WSL Ubuntu)

Both Linux targets share `mise/config.toml`. `setup.sh` installs mise via
`mise.run`, symlinks the config, then runs `mise bootstrap` (apt packages +
CLI tools, with shims on PATH). The bash prompt is oh-my-posh, using the
vendored Catppuccin themes selected by `THEME_MODE`.

On WSL, clone this repo into the Linux filesystem (e.g. `~/Source/configs`),
not `/mnt/c`, so symlinks work and tool I/O is fast. Ensure LF line endings
(`core.autocrlf=input`) so the shell scripts don't pick up stray `\r`.

### Package update scripts

* `update.sh/bat` - Runs brew/choco package update & cleanup process

## Core tools

These tools are installed on all machines and must be available on all three
platforms (Homebrew on macOS, mise on Linux, WinGet on Windows). Prefer them
over default shell equivalents.

| Tool | macOS (brew) | Linux (mise) | Windows (winget) | Purpose |
| --- | --- | --- | --- | --- |
| ast-grep | `ast-grep` | `ast-grep` | `ast-grep.ast-grep` | Structural search and rewrite |
| bat | `bat` | `bat` | `sharkdp.bat` | cat with syntax highlighting |
| difftastic | `difftastic` | `difftastic` | `Wilfred.difftastic` | Structural diff |
| dust | `dust` | `dust` | `bootandy.dust` | du replacement |
| eza | `eza` | `eza` | `eza-community.eza` | Modern ls replacement |
| fd | `fd` | `fd` | `sharkdp.fd` | find alternative |
| fzf | `fzf` | `fzf` | `junegunn.fzf` | Fuzzy file finder |
| just | `just` | `just` | `Casey.Just` | Command runner |
| lazygit | `lazygit` | `lazygit` | `JesseDuffield.lazygit` | Git TUI |
| neovim | `neovim` | `neovim` | `Neovim.Neovim` | Editor |
| ripgrep | `ripgrep` | `ripgrep` | `BurntSushi.ripgrep.MSVC` | Faster grep |
| tealdeer | `tealdeer` | `tealdeer` | `dbrgn.tealdeer` | Better man pages |
| yq | `yq` | `yq` | `MikeFarah.yq` | YAML/JSON processor |

## Guidelines

* Core tools must be available on all three platforms. Verify macOS, Linux,
  and Windows packaging before adding a tool to the core list.
* Favour cross-platform tools. OS-specific tools are allowed as extras, but
  must stay out of the core set.
* Avoid npm/Node-based tools and dependencies.
* Core tools must not be language toolchains (Python, Go, Node, C/C++, Rust).
  Language toolchains may appear as OS-specific extras only.
* Add tools to every applicable manifest for parity, and annotate each entry
  with a trailing comment.

## Automation Scripts

### Windows

* `hosts/hosts.bat` - Setup distracting site blocking in hosts file
