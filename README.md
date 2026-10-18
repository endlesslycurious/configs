This repo contains various configuration files I use for development.

## Cloning

You need to close this repository with the `--recurse-submodules` option or run `git submodule init` then `git submodule update` after cloning to update the submodules.

### Submodules

* Catppucin CMD color scheme.
* Neovim configuration from my kickstart fork.

## Windows Setup

You need to set `HOME` environment vairable to `%USERPROFILE%` then open new console to get git to clone this repo!

## Setup scripts

Sets up symbolic links from files in repo to expected install locations on disk.

* Mac & Linux - setup.sh (use 'chmod u+x setup.sh' to make this script executable)
* Windows - setup.bat

## Editor Configuration files

* NeoVim - `nvim` folder
* Zed - `zed` folder

## Environment Configuration files

* Bash - `bash/.bash_profile` for Mac
* Ghostty - `ghostty` folder
* Zsh - `zsh/.zshrc` for Mac

### Ghostty themes & fonts

Theme setup is handled by the `theme` key in `ghostty/config.ghostty`. The font
and colour scheme (Catppuccin Macchiato) are managed in that file.

## Package manifests

* Homebrew for Mac - `brew/Brewfile.*.local`
* mise for Linux - `mise/config.toml` (Raspberry Pi OS + Ubuntu on WSL)
* Win Get for Windows Store `winget/*.txt`

### Linux (Raspberry Pi OS & WSL Ubuntu)

Both Linux targets share `mise/config.toml`. `setup.sh` installs mise via
`mise.run`, symlinks the config, then runs `mise bootstrap` (apt packages +
CLI tools, with shims on PATH).

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
| ripgrep | `ripgrep` | `ripgrep` | `BurntSushi.ripgrep.MSVC` | Faster grep |
| fd | `fd` | `fd` | `sharkdp.fd` | find alternative |
| bat | `bat` | `bat` | `sharkdp.bat` | cat with syntax highlighting |
| tealdeer | `tealdeer` | `tealdeer` | `dbrgn.tealdeer` | Better man pages |
| fzf | `fzf` | `fzf` | `junegunn.fzf` | Fuzzy file finder |
| just | `just` | `just` | `Casey.Just` | Command runner |
| ast-grep | `ast-grep` | `ast-grep` | `ast-grep.ast-grep` | Structural search and rewrite |
| difftastic | `difftastic` | `difftastic` | `Wilfred.difftastic` | Structural diff |
| yq | `yq` | `yq` | `MikeFarah.yq` | YAML/JSON processor |
| neovim | `neovim` | `neovim` | `Neovim.Neovim` | Editor |
| lazygit | `lazygit` | `lazygit` | `JesseDuffield.lazygit` | Git TUI |
| dust | `dust` | `dust` | `bootandy.dust` | du replacement |

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
