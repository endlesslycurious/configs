This repo contains various configuration files I use for development.

## Cloning
You need to close this repository with the `--recurse-submodules` option or run `git submodule init` then `git submodule update` after cloning to update the submodules.

### Submodules
- Catppucin iterm color scheme.
- Neovim configuration from my kickstart fork.

## Windows Setup
You need to set `HOME` environment vairable to `%USERPROFILE%` then open new console to get git to clone this repo!

## Setup scripts
Sets up symbolic links from files in repo to expected install locations on disk.
* Mac & Linux - setup.sh (use 'chmod u+x setup.sh' to make this script executable)
* Windows - setup.bat

## Editor Configuration files
* Sublime 3  - `sublime/Sublime3.sublime-settings`
* Vim  - `vim/.vimrc`
* VS Code  - `vscode/VSCode.json`

## Environment Configuration files
* Bash - `bash/.bash_profile` for Mac
* Zsh - `zsh/.zshrc` for Mac

### iterm2 themes
Theme setup is a bit manual:
1. Open iterm2.
2. Settings -> Profiles -> Colors -> Color Presets.
3. Navigate to the theme files e.g. `iterm2/catppucin` and select theme.
4. Select the imported theme from the drop down!

## Package manifests
* Homebrew for Mac - `Brewfile.*.local`
* VS Code Extensions - `vscode/*-code-ext.txt`
* Win Get for Windows Store `*- winget.txt`

### Package update scripts
* `update.sh/bat` - Runs brew/choco package update & cleanup process

## Automation Scripts

### Windows
* `hosts/hosts.bat` - Setup distracting site blocking in hosts file

