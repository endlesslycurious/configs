This repo contains various configuration files I use for development.

## Windows Setup
You need to set `HOME` environment vairable to `%USERPROFILE%` then open new console to get git to clone this repo!

## Setup scripts
Sets up symbolic links from files in repo to expected install locations on disk.
* Mac & Linux - setup.sh (use 'chmod u+x setup.sh' to make this script executable)
* Windows - setup.bat

## Editor Configuration files
* Sublime 3  - Sublime3.sublime-settings
* Vim  - .vimrc
* VS Code  - VSCode.json

## Environment Configuration files
* Bash - .bash_profile for Mac

## Package manifests
* Chocolatey for Windows - `*-choco.config`
* Homebrew for Mac - `Brewfile`
* VS Code Extensions - `*-code-ext.txt`
* Win Get for Windows Store `*- winget.txt`

### Package update scripts
* update.sh/bat - Runs brew/choco package update & cleanup process

## Automation Scripts

### Mac
* MinimiseAll.scpt - Minimise all applications, schedule using crontab

### Windows
* hosts.bat - Setup distracting site blocking in hosts file

## Misc

### Windows
* ctrl-zoom.ahk - auto hot key config to surpress control+zoom text scaling.
