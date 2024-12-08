#!/usr/bin/env bash

# Use 'chmod u+x update.sh' to make this script executable
# Run with './update.sh'

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup 

	echo "--- Refresh brew version & forumulas ---"
	brew update

	echo "--- Install missing tools using brew bundle ---"
	brewfile=./Brewfile.$HOSTNAME
	brew bundle --file=$brewfile --verbose

	echo "--- Update casks to latest ---"
	brew upgrade --cask --greedy

	echo "--- Listing redundant dependencies to remove manually with 'brew bundle cleanup -f' ---"
	brew bundle --file=$brewfile cleanup

	echo "--- Cleanup old versions and temp file ---"
	brew cleanup

	echo "--- Done! ---"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"		
fi
