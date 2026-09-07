#!/usr/bin/env bash

# Use 'chmod u+x setup.sh' to make this script executable
# Run with './setup.sh'

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup

	# make sure config directory exists
	mkdir -p ~/.config

	echo "Configuring neovim"
	ln -F -s $PWD/nvim ~/.config/nvim

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

	echo "Configuring opencode"
	ln -F -s $PWD/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"
fi
