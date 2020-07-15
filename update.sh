#!/usr/bin/env bash

# Use 'chmod u+x update.sh' to make this script executable
# Run with './update.sh'

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup 

	echo "--- Refresh bew version & forumulas ---"
	brew update

	echo "--- Install updates using brew bundle ---"
	brew bundle --verbose

	echo "--- Cleanup old versions and temp file ---s"
	brew cleanup

	echo "--- Done! ---"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup
	echo "Not written yet!"		
fi
