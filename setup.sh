#!/usr/bin/env bash

# Use 'chmod u+x setup.sh' to make this script executable
# Run with './setup.sh'

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup
	
	# make sure config directory exists
	mkdir -p ~/.config

	echo "Configuring neovim"
	ln -F -s $PWD/nvim ~/.config/nvim

	echo "Configuring vim"
	ln -F -s $PWD/vim/.vimrc ~/.vimrc

	echo "Configuring Sublime Text 3"
	ln -F -s $PWD/sublime/Sublime3.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings

	echo "Configuring bash"
	ln -F -s $PWD/bash/.bash_profile ~/.bash_profile

	echo "Configuring zed"
	mkdir -p ~/.config/zed
	ln -F -s $PWD/zed/settings.json ~/.config/zed/settings.json

	echo "Configuring zsh"
	ln -F -s $PWD/zsh/.zshrc ~/.zshrc

	echo "Configuring Brewfile"
	brewfile=$PWD/brew/Brewfile.$HOSTNAME
	ln -sF $brewfile ~/.Brewfile

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"
fi
