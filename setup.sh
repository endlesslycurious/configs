#!/usr/bin/env bash

# Use 'chmod u+x setup.sh' to make this script executable

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup 

	echo "Setting .vimrc"
	ln -F -s $PWD/.vimrc ~/.vimrc	

	echo "Setting .bash_profile"
	ln -F -s $PWD/.bash_profile ~/.bash_profile	
	
	echo "Setting Brewfile"
	ln -F -s $PWD/Brewfile ~/Brewfile	
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"		
fi
