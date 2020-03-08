#!/usr/bin/env bash

# Use 'chmod u+x setup.sh' to make this script executable

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup 

	echo "Setting .vimrc"
	ln -F -s $PWD/.vimrc ~/.vimrc	

	echo "Setting Sublime Text 3"
	ln -F -s $PWD/Sublime3.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/Preferences.sublime-settings

	echo "Setting .bash_profile"
	ln -F -s $PWD/.bash_profile ~/.bash_profile	
	
	echo "Setting Brewfile"
	ln -F -s $PWD/Brewfile ~/Brewfile	
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"		
fi
