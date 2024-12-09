#!/usr/bin/env bash

# Use 'chmod u+x setup.sh' to make this script executable
# Run with './setup.sh'

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup

	echo "Configuring neovim"
	mkdir -p ~/.config
	ln -F -s $PWD/nvim ~/.config/nvim

	echo "Configuring vim"
	ln -F -s $PWD/vim/.vimrc ~/.vimrc

	echo "Configuring Sublime Text 3"
	ln -F -s $PWD/sublime/Sublime3.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings

	echo "Configuring VS Code"
	ln -F -s $PWD/vscode/VSCode.json ~/Library/Application\ Support/Code/User/settings.json

	echo "Configuring bash"
	ln -F -s $PWD/bash/.bash_profile ~/.bash_profile
	
	echo "Configuring zsh"
	ln -F -s $PWD/zsh/.zshrc ~/.zshrc

	echo "Configuring Brewfile"
	brewfile=$PWD/Brewfile.$HOSTNAME
	ln -F -s $brewfile ~/Brewfile

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"	
fi
