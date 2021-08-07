#!/usr/bin/env bash

# Use 'chmod u+x update.sh' to make this script executable
# Run with './update.sh'

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup 

	echo "--- Refresh brew version & forumulas ---"
	brew update

	echo "--- Install updates using brew bundle ---"
	brew bundle --verbose

	echo "--- Listing redundant dependencies to remove manually with 'brew bundle cleanup -f' ---"
	brew bundle cleanup

	echo "--- Cleanup old versions and temp file ---"
	brew cleanup

	echo "--- Python: Upgrade PIP ---"
	python3 -m pip install --upgrade pip

	echo "--- Python: Install/Upgrade modules ---"
	pip3 install --upgrade -r python-modules.txt

	echo "--- Done! ---"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"		
fi
