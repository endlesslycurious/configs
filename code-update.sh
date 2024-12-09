#!/usr/bin/env bash

# Use 'chmod u+x code-update.sh' to make this script executable
# Run with './code-update.sh'

if [ "$(uname)" == "Darwin" ]; then
	# MAC OS: installing VS.Code extensions from code-ext.txt file, use
	# 'code --list-extensions > code-ext.txt' to update extensions list

	# See https://stackoverflow.com/a/1521498
	while read ext; do
		code --install-extension $ext
	done <./vscode/odin-code-ext.txt

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"		
fi
