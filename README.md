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
* Win Get for Windows Store `winget/*.txt`

### Package update scripts

* `update.sh/bat` - Runs brew/choco package update & cleanup process

## Automation Scripts

### Windows

* `hosts/hosts.bat` - Setup distracting site blocking in hosts file
