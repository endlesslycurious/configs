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

	echo "Configuring shell colours"
	mkdir -p ~/.config/shell
	ln -F -s $PWD/shell/ls_colors.sh ~/.config/shell/ls_colors.sh

	echo "Configuring oh-my-posh themes"
	mkdir -p ~/.config/oh-my-posh/themes
	ln -F -s $PWD/oh-my-posh/themes/catppuccin_latte.omp.json ~/.config/oh-my-posh/themes/
	ln -F -s $PWD/oh-my-posh/themes/catppuccin_frappe.omp.json ~/.config/oh-my-posh/themes/

	echo "Configuring zed"
	mkdir -p ~/.config/zed
	ln -F -s $PWD/zed/settings.json ~/.config/zed/settings.json

	echo "Configuring ghostty"
	mkdir -p ~/.config/ghostty
	ln -F -s $PWD/ghostty/config.ghostty ~/.config/ghostty/config.ghostty

	echo "Configuring lazygit"
	mkdir -p ~/Library/Application\ Support/lazygit
	ln -F -s $PWD/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml

	echo "Configuring k9s skins"
	mkdir -p ~/Library/Application\ Support/k9s/skins
	ln -sf $PWD/k9s/skins/catppuccin-latte.yaml ~/Library/Application\ Support/k9s/skins/
	ln -sf $PWD/k9s/skins/catppuccin-frappe.yaml ~/Library/Application\ Support/k9s/skins/

	echo "Configuring tuicr"
	mkdir -p ~/.config/tuicr
	ln -F -s $PWD/tuicr/config.toml ~/.config/tuicr/config.toml

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

	echo "Configuring shell colours"
	mkdir -p ~/.config/shell
	ln -sf $PWD/shell/ls_colors.sh ~/.config/shell/ls_colors.sh

	echo "Configuring oh-my-posh themes"
	mkdir -p ~/.config/oh-my-posh/themes
	ln -sf $PWD/oh-my-posh/themes/catppuccin_latte.omp.json ~/.config/oh-my-posh/themes/
	ln -sf $PWD/oh-my-posh/themes/catppuccin_frappe.omp.json ~/.config/oh-my-posh/themes/

	echo "Configuring neovim"
	ln -sfn $PWD/nvim ~/.config/nvim

	echo "Configuring zed"
	mkdir -p ~/.config/zed
	ln -sf $PWD/zed/settings.json ~/.config/zed/settings.json

	echo "Configuring ghostty"
	mkdir -p ~/.config/ghostty
	ln -sf $PWD/ghostty/config.ghostty ~/.config/ghostty/config.ghostty

	echo "Configuring lazygit"
	mkdir -p ~/.config/lazygit
	ln -sf $PWD/lazygit/config.yml ~/.config/lazygit/config.yml

	echo "Configuring k9s skins"
	k9s_skins="${XDG_CONFIG_HOME:-$HOME/.config}/k9s/skins"
	mkdir -p "$k9s_skins"
	ln -sf $PWD/k9s/skins/catppuccin-latte.yaml "$k9s_skins/"
	ln -sf $PWD/k9s/skins/catppuccin-frappe.yaml "$k9s_skins/"

	echo "Configuring tuicr"
	mkdir -p ~/.config/tuicr
	ln -sf $PWD/tuicr/config.toml ~/.config/tuicr/config.toml

	echo "Configuring mise"
	mkdir -p ~/.config/mise
	ln -sf $PWD/mise/config.toml ~/.config/mise/config.toml

	echo "Applying mise bootstrap"
	mise bootstrap
fi

# Common configuration (~/.gitconfig is not symlinked, so set keys individually)
echo "Configuring herdr"
mkdir -p ~/.config/herdr
ln -sf "$PWD/herdr/config.toml" ~/.config/herdr/config.toml
if command -v herdr >/dev/null 2>&1; then
    herdr server reload-config >/dev/null 2>&1 || true
fi

echo "Configuring btop themes"
btop_theme_dir="$HOME/.config/btop/themes"
mkdir -p "$btop_theme_dir"
ln -sf "$PWD/btop/themes/catppuccin_latte.theme" "$btop_theme_dir/"
ln -sf "$PWD/btop/themes/catppuccin_frappe.theme" "$btop_theme_dir/"
ln -sf "$btop_theme_dir/catppuccin_latte.theme" "$btop_theme_dir/catppuccin.theme"
btop_conf="$HOME/.config/btop/btop.conf"
if [ -f "$btop_conf" ]; then
    awk 'BEGIN { done = 0 }
         /^color_theme[[:space:]]*=/ { print "color_theme = \"catppuccin\""; done = 1; next }
         { print }
         END { if (!done) print "color_theme = \"catppuccin\"" }' "$btop_conf" > "$btop_conf.tmp" \
        && mv "$btop_conf.tmp" "$btop_conf"
else
    printf 'color_theme = "catppuccin"\n' > "$btop_conf"
fi

echo "Configuring git to use delta"
mkdir -p ~/.config/delta
ln -sf "$PWD/delta/catppuccin.gitconfig" ~/.config/delta/catppuccin.gitconfig
delta_include="$HOME/.config/delta/catppuccin.gitconfig"
if ! git config --global --get-all include.path 2>/dev/null | grep -qxF "$delta_include"; then
    git config --global --add include.path "$delta_include"
fi
git config --global core.pager "delta"
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.features "catppuccin-latte"
git config --global --unset-all delta.dark 2>/dev/null || true
git config --global --unset-all delta.light 2>/dev/null || true
git config --global merge.conflictStyle zdiff3
