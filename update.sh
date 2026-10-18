#!/usr/bin/env bash

# Use 'chmod u+x update.sh' to make this script executable
# Run with './update.sh'

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X setup 

	echo "--- Refresh brew version & forumulas ---"
	brew update

	echo "--- Install missing tools using brew bundle ---"
	brew bundle --global --verbose

	echo "--- Update casks to latest ---"
	brew upgrade --cask

	echo "--- Listing redundant dependencies to remove manually with 'brew bundle cleanup -f' ---"
	brew bundle --global cleanup

	echo "--- Cleanup old versions and temp file ---"
	brew cleanup

	echo "--- Checking for issues ---"
	brew doctor

	echo "--- Done! ---"

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup (Debian/Ubuntu; includes Raspberry Pi OS and WSL Ubuntu)

	echo "--- Refresh apt package lists ---"
	sudo apt update

	echo "--- Upgrade system packages ---"
	sudo apt upgrade -y

	echo "--- Update mise itself ---"
	mise self-update

	echo "--- Upgrade mise-managed tools ---"
	mise upgrade

	echo "--- Upgrade declared apt packages ---"
	mise bootstrap packages upgrade

	echo "--- Remove orphaned packages ---"
	sudo apt autoremove --purge

	echo "--- Done! ---"
fi
