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

	echo "Configuring ghostty"
	mkdir -p ~/.config/ghostty
	ln -F -s $PWD/ghostty/config.ghostty ~/.config/ghostty/config.ghostty

	echo "Configuring lazygit"
	mkdir -p ~/Library/Application\ Support/lazygit
	ln -F -s $PWD/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml

	echo "Configuring zsh"
	ln -F -s $PWD/zsh/.zshrc ~/.zshrc

	echo "Configuring Brewfile"
	brewfile=$PWD/brew/Brewfile.$HOSTNAME
	ln -sF $brewfile ~/.Brewfile

	echo "Configuring opencode"
	mkdir -p ~/.config/opencode
	ln -F -s $PWD/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc
	ln -F -s $PWD/opencode/tui.jsonc ~/.config/opencode/tui.jsonc

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux setup (Debian/Ubuntu; includes Raspberry Pi OS and WSL Ubuntu)

	if [ ! -f /etc/debian_version ]; then
		echo "Unsupported Linux distribution (expected Debian/Ubuntu)."
		exit 1
	fi

	if ! command -v curl >/dev/null 2>&1; then
		sudo apt-get update && sudo apt-get install -y curl
	fi

	if ! command -v mise >/dev/null 2>&1; then
		echo "Installing mise"
		curl -fsSL https://mise.run | sh
	fi
	export PATH="$HOME/.local/bin:$PATH"

	mkdir -p ~/.config

	echo "Configuring neovim"
	ln -sfn $PWD/nvim ~/.config/nvim

	echo "Configuring zed"
	mkdir -p ~/.config/zed
	ln -sf $PWD/zed/settings.json ~/.config/zed/settings.json

	echo "Configuring ghostty"
	mkdir -p ~/.config/ghostty
	ln -sf $PWD/ghostty/config.ghostty ~/.config/ghostty/config.ghostty

	echo "Configuring opencode"
	mkdir -p ~/.config/opencode
	ln -sf $PWD/opencode/opencode.jsonc ~/.config/opencode/opencode.jsonc

	echo "Configuring lazygit"
	mkdir -p ~/.config/lazygit
	ln -sf $PWD/lazygit/config.yml ~/.config/lazygit/config.yml

	echo "Configuring mise"
	mkdir -p ~/.config/mise
	ln -sf $PWD/mise/config.toml ~/.config/mise/config.toml

	echo "Applying mise bootstrap"
	mise bootstrap
fi

# Common configuration (~/.gitconfig is not symlinked, so set keys individually)
echo "Configuring git to use delta"
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global merge.conflictStyle zdiff3
