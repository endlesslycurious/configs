# add homebrew to path
export PATH="/opt/homebrew/bin:$PATH"

# source local secrets (outside repo)
[[ -f "$HOME/.secrets/env.sh" ]] && source "$HOME/.secrets/env.sh"

# shared shell colours (Catppuccin Latte LS_COLORS, delta, bat, k9s and btop themes)
[[ -f "$HOME/.config/shell/ls_colors.sh" ]] && source "$HOME/.config/shell/ls_colors.sh"

# add homebrew LLVM to path
export PATH="/opt/homebrew/opt/llvm/bin/:$PATH"

# Add binaries from Go default workspace to path
export PATH="$PATH:$HOME/go/bin"

# pipenv create virtual environment folders inside projects
export PIPENV_VENV_IN_PROJECT=1

# oh-my-posh setup using vendored themes; THEME_MODE is light unless switched
posh_themes="$HOME/.config/oh-my-posh/themes"
case "$THEME_MODE" in
    dark) posh_theme=catppuccin_frappe ;;
    *) posh_theme=catppuccin_latte ;;
esac
if [ -f "$posh_themes/${posh_theme}.omp.json" ]; then
    eval "$(oh-my-posh init zsh --config "$posh_themes/${posh_theme}.omp.json")"
fi
