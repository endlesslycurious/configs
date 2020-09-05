This repo contains various configuration files I use for development.

## Setup scripts
Sets up symbolic links from files in repo to expected install locations on disk.
* Mac & Linux - setup.sh (use 'chmod u+x setup.sh' to make this script executable)
* Windows - setup.bat

## Editor Configuration files
* Sublime 3  - Sublime3.sublime-settings
* Vim  - .vimrc
* VS Code  - VSCode.json

### VS Code Extensions
* code-ext.txt - extensions list generated from 'code --list-extensions'
* code-update.sh/bat - installs extensions listed in code-ext.txt

## Environment Configuration files
* Bash - .bash_profile

## Package manifests
* Chocolatey for Windows - Chocolatey.config
* Homebrew for Mac - Brewfile

### Package update scripts
* update.sh/bat - Runs brew/choco package update & cleanup process
